# training_service.py
import uuid
from datetime import datetime
import random
from pathlib import Path
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from typing import Dict, Any, List, Optional
from fastapi import UploadFile
import asyncio
import zipfile
import shutil
import traceback

from app.models.models import TrainingJob, TrainedModel
from ultralytics import YOLO 
from app.database.database import AsyncSessionLocal 

class TrainingService:
    @staticmethod
    async def save_upload_file(file: UploadFile) -> str:
        """Save uploaded file and return the file path"""
        upload_dir = Path("uploads/training_data_archives")
        upload_dir.mkdir(parents=True, exist_ok=True)
            
        unique_filename = f"{str(uuid.uuid4())}_{file.filename}"
        file_path = upload_dir / unique_filename
        
        content = await file.read()
        with open(file_path, "wb") as f:
            f.write(content)
            
        return str(file_path.resolve())
        
    @staticmethod
    async def create_training_job(
        db: AsyncSession,
        model_type: str,
        file_path: str,
        original_filename: str,
        config_params: Dict[str, Any]
    ) -> TrainingJob:
        """Create a new training job in the database"""
        new_job = TrainingJob(
            model_type=model_type,
            status="pending",
            created_at=datetime.now(),
            uploaded_data_path=file_path,
            original_filename=original_filename,
            config_params=config_params,
        )
        
        db.add(new_job)
        await db.commit()
        await db.refresh(new_job)
        return new_job
        
    @staticmethod
    async def model_training_process(
        job_id: int,
        model_type: str,
    ):
        """Model training process that runs in the background.
           Integrates YOLO for 'region' model_type."""
        
        print(f"BACKGROUND TASK: Starting for job_id: {job_id}, model_type: {model_type}")
        
        async with AsyncSessionLocal() as db_task:
            try:
                job = await db_task.get(TrainingJob, job_id)
                if not job:
                    print(f"BACKGROUND TASK ERROR: Job {job_id} not found.")
                    return
                    
                job.status = "running"
                job.started_at = datetime.now()
                await db_task.commit()

                persistent_artifacts_dir = Path("persistent_training_artifacts")
                persistent_artifacts_dir.mkdir(parents=True, exist_ok=True)

                dataset_extract_path = persistent_artifacts_dir / "datasets" / f"job_{job_id}_dataset"
                
                yolo_runs_output_dir = persistent_artifacts_dir / "yolo_runs" 
                yolo_project_name = f"job_{job_id}_training"
                yolo_run_name = f"{model_type}_model"

                trained_model_storage_dir = persistent_artifacts_dir / "trained_models"
                trained_model_storage_dir.mkdir(parents=True, exist_ok=True)

                model_artifact_path_str = None
                model_accuracy = None
                model_loss = None

                cfg = job.config_params
                if not isinstance(cfg, dict):
                    print(f"BACKGROUND TASK WARNING: job.config_params for job {job_id} is not a dict: {type(cfg)}. Using defaults.")
                    cfg = {}


                if model_type == "region":
                    print(f"BACKGROUND TASK: Starting REGION model training for job {job_id}...")
                    
                    if not Path(job.uploaded_data_path).exists():
                        raise FileNotFoundError(f"Uploaded data archive not found at {job.uploaded_data_path}")
                    
                    if dataset_extract_path.exists():
                        shutil.rmtree(dataset_extract_path)
                    dataset_extract_path.mkdir(parents=True, exist_ok=True)

                    print(f"BACKGROUND TASK: Extracting {job.uploaded_data_path} to {dataset_extract_path}")
                    with zipfile.ZipFile(job.uploaded_data_path, 'r') as zip_ref:
                        zip_ref.extractall(dataset_extract_path)
                    
                    data_yaml_path_str = None
                    possible_yaml_paths = list(dataset_extract_path.rglob('data.yaml'))
                    if not possible_yaml_paths:
                         possible_yaml_paths = list(dataset_extract_path.rglob('*.yaml'))
                    
                    if possible_yaml_paths:
                        data_yaml_file = next((p for p in possible_yaml_paths if p.name == 'data.yaml'), possible_yaml_paths[0])
                        data_yaml_path_str = str(data_yaml_file.resolve())
                        print(f"BACKGROUND TASK: Found data config at: {data_yaml_path_str}")
                    else:
                        raise FileNotFoundError(f"data.yaml (or any .yaml) not found in the extracted archive at {dataset_extract_path}. Searched recursively.")

                    yolo_base_model = cfg.get("model_base", "yolov11n.pt")
                    epochs = cfg.get("epochs", 50)
                    imgsz = cfg.get("img_size", 640)
                    batch = cfg.get("batch_size", 16)

                    print(f"BACKGROUND TASK: Initializing YOLO model: {yolo_base_model}")
                    training_model = YOLO(yolo_base_model)
                    
                    effective_name_for_train = f"{yolo_project_name}/{yolo_run_name}"
                    print(f"BACKGROUND TASK: Starting YOLO training: data={data_yaml_path_str}, epochs={epochs}, imgsz={imgsz}, batch={batch}, project={str(yolo_runs_output_dir)}, name={effective_name_for_train}")
                    
                    # model.train() returns a Results object
                    training_results_obj = await asyncio.to_thread(
                        training_model.train,
                        data=data_yaml_path_str,
                        epochs=epochs,
                        imgsz=imgsz,
                        batch=batch,
                        project=str(yolo_runs_output_dir),
                        name=effective_name_for_train,
                        exist_ok=True
                    )
                    
                    print("BACKGROUND TASK: YOLO training completed.")

                    yolo_experiment_run_dir = Path(training_results_obj.save_dir)
                    source_model_path = yolo_experiment_run_dir / "weights" / "best.pt"

                    if not source_model_path.exists():
                        raise FileNotFoundError(f"Trained model 'best.pt' not found in {source_model_path.parent}")

                    final_model_filename = f"model_region_{job_id}_best.pt"
                    destination_model_path = trained_model_storage_dir / final_model_filename
                    shutil.copy2(source_model_path, destination_model_path)
                    model_artifact_path_str = str(destination_model_path.resolve())
                    print(f"BACKGROUND TASK: Best model saved to: {model_artifact_path_str}")

                    print(f"BACKGROUND TASK: Validating the best model from {source_model_path} using model.val()")
                    evaluation_model = YOLO(str(source_model_path))
                    
                    validation_metrics_obj = await asyncio.to_thread(
                        evaluation_model.val,
                        data=data_yaml_path_str,
                        imgsz=imgsz,
                        batch=batch,
                    )
                    print("BACKGROUND TASK: model.val() completed.")

                    model_accuracy = None
                    if hasattr(validation_metrics_obj, 'box') and hasattr(validation_metrics_obj.box, 'map'):
                        model_accuracy = validation_metrics_obj.box.map
                        print(f"BACKGROUND TASK: Accuracy (mAP50-95 from model.val()): {model_accuracy}")
                    else:
                        print(f"BACKGROUND TASK WARNING: Could not get 'validation_metrics_obj.box.map'. Full val_metrics_obj: {validation_metrics_obj}")
                        if hasattr(training_results_obj, 'box') and hasattr(training_results_obj.box, 'map'):
                             model_accuracy = training_results_obj.box.map
                             print(f"BACKGROUND TASK: Fallback accuracy (mAP50-95 from training_results_obj.box.map): {model_accuracy}")
                        elif 'metrics/mAP50-95(B)' in training_results_obj.results_dict:
                             model_accuracy = training_results_obj.results_dict['metrics/mAP50-95(B)']
                             print(f"BACKGROUND TASK: Fallback accuracy (mAP50-95 from training_results_obj.results_dict): {model_accuracy}")


                    training_run_metrics_dict = training_results_obj.results_dict
                    model_loss = training_run_metrics_dict.get('val/box_loss')
                    if model_loss is None:
                        model_loss = training_run_metrics_dict.get('val/loss')
                    if model_loss is None:
                        model_loss = training_run_metrics_dict.get('train/box_loss')
                    print(f"BACKGROUND TASK: Loss (from training_results_obj.results_dict): {model_loss}")
                    print(f"BACKGROUND TASK: Training results_dict keys: {list(training_run_metrics_dict.keys())}")


                    if model_accuracy is not None:
                        model_accuracy = float(model_accuracy)
                    else:
                        print("BACKGROUND TASK WARNING: model_accuracy is None. Defaulting to 0.0.")
                        model_accuracy = 0.0
                    
                    if model_loss is not None:
                        model_loss = float(model_loss)
                    elif model_loss is None and model_accuracy is not None and model_accuracy > 0:
                        model_loss = 1.0 - model_accuracy
                        print(f"BACKGROUND TASK INFO: model_loss was None, estimated as 1.0 - accuracy: {model_loss}")
                    else:
                        print("BACKGROUND TASK WARNING: model_loss is None. Defaulting to 1.0.")
                        model_loss = 1.0
                        
                    model_accuracy = round(model_accuracy, 4)
                    model_loss = round(model_loss, 4)
                    
                    print(f"BACKGROUND TASK: Final Metrics: Accuracy={model_accuracy}, Loss={model_loss}")

                else: # MOCK training
                    print(f"BACKGROUND TASK: Starting MOCK model training for job {job_id} (model_type: {model_type})...")
                    await asyncio.sleep(random.randint(5, 15))
                    
                    mock_model_filename = f"model_mock_{model_type}_{job_id}.bin"
                    model_artifact_path_str = str(trained_model_storage_dir / mock_model_filename)
                    
                    with open(model_artifact_path_str, "wb") as f:
                        f.write(b"mock model binary content")
                    
                    model_accuracy = round(random.uniform(0.7, 0.95), 3)
                    model_loss = round(random.uniform(0.05, 0.25), 3)
                    print(f"BACKGROUND TASK: Mock training complete. Model: {model_artifact_path_str}, Acc: {model_accuracy}, Loss: {model_loss}")

                new_model = TrainedModel(
                    name=f"{model_type.capitalize()} Model #{job_id}",
                    created_at=datetime.now(),
                    type=model_type,
                    model_path=model_artifact_path_str,
                    status="active",
                    training_job_id=job_id,
                    model_accuracy=model_accuracy,
                    model_loss=model_loss
                )
                db_task.add(new_model)
                
                job_final_update = await db_task.get(TrainingJob, job_id) 
                if job_final_update:
                    job_final_update.status = "completed"
                    job_final_update.completed_at = datetime.now()
                else:
                    print(f"BACKGROUND TASK WARNING: Job {job_id} could not be re-fetched for final update.")

                await db_task.commit()
                print(f"BACKGROUND TASK: Job {job_id} marked as completed. Trained model created.")
            
            except Exception as e:
                print(f"BACKGROUND TASK ERROR: Error during training process for job {job_id}: {str(e)}")
                traceback.print_exc()
                try:
                    job_to_fail = await db_task.get(TrainingJob, job_id)
                    if job_to_fail:
                        job_to_fail.status = "failed"
                        job_to_fail.error_message = str(e)
                        job_to_fail.completed_at = datetime.now()
                        await db_task.commit()
                        print(f"BACKGROUND TASK: Job {job_id} marked as failed in DB.")
                    else:
                         print(f"BACKGROUND TASK CRITICAL: Could not find job {job_id} to mark as failed after training error.")
                except Exception as db_error:
                    print(f"BACKGROUND TASK CRITICAL: Failed to mark job {job_id} as failed in DB after training error: {db_error}")
                    traceback.print_exc()
            finally:
                print(f"BACKGROUND TASK: Finished for job_id: {job_id}")
    
    @staticmethod
    async def get_all_training_jobs(db: AsyncSession) -> List[TrainingJob]:
        """Get all training jobs"""
        result = await db.execute(select(TrainingJob).order_by(TrainingJob.created_at.desc()))
        return result.scalars().all()
        
    @staticmethod
    async def get_training_job(db: AsyncSession, job_id: int) -> Optional[TrainingJob]:
        """Get a specific training job by ID"""
        return await db.get(TrainingJob, job_id)