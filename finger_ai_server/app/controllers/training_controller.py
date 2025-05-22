import json
from typing import List, Dict, Any, Optional
from fastapi import Depends, HTTPException, BackgroundTasks, UploadFile, Form, status
from sqlalchemy.ext.asyncio import AsyncSession
import traceback # Để debug lỗi tốt hơn

from app.database.database import get_db
from app.services.training_service import TrainingService
# from app.models.models import TrainingJob
from app.schemas.schemas import TrainingJobResponse, ConfigParams

class TrainingController:
    @staticmethod
    async def create_training_job(
        data_file: UploadFile,
        config_params_json: str = Form(...),
        model_type: str = "region",
        background_tasks: BackgroundTasks = BackgroundTasks(),
        db: AsyncSession = Depends(get_db),
    ) -> TrainingJobResponse:
        """Create a new training job"""
        try:
            try:
                config_params_dict = json.loads(config_params_json)
            except json.JSONDecodeError:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST, 
                    detail="Invalid JSON format in config_params_json"
                )
            
            file_path = await TrainingService.save_upload_file(data_file)
            
            job = await TrainingService.create_training_job(
                db=db,
                model_type=model_type,
                file_path=file_path,
                original_filename=data_file.filename,
                config_params=config_params_dict
            )
            
            background_tasks.add_task(
                TrainingService.model_training_process, 
                job_id=job.id,
                model_type=model_type
            )
            return job 
            
        except HTTPException as http_exc:
            raise http_exc
        except Exception as e:
            print(f"Error in create_training_job controller: {str(e)}")
            traceback.print_exc()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
                detail=f"Error creating training job: {str(e)}"
            )
            
    @staticmethod
    async def get_all_jobs(db: AsyncSession = Depends(get_db)) -> List[TrainingJobResponse]:
        """Get all training jobs"""
        try:
            jobs = await TrainingService.get_all_training_jobs(db)
            return jobs
        except Exception as e:
            print(f"Error in get_all_jobs controller: {str(e)}")
            traceback.print_exc()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
                detail=f"Error retrieving training jobs: {str(e)}"
            )
            
    @staticmethod
    async def get_job(job_id: int, db: AsyncSession = Depends(get_db)) -> TrainingJobResponse:
        """Get a specific training job by ID"""
        job = await TrainingService.get_training_job(db, job_id)
        if not job:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, 
                detail=f"Training job with ID {job_id} not found"
            )
        return job