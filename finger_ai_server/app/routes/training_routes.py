from fastapi import APIRouter, Depends, BackgroundTasks, UploadFile, Form, status
from typing import List
from sqlalchemy.ext.asyncio import AsyncSession

from app.controllers.training_controller import TrainingController
from app.database.database import get_db
from app.schemas.schemas import TrainingJobResponse

router = APIRouter(prefix="/training", tags=["Training"])

@router.post("/region", status_code=status.HTTP_202_ACCEPTED, response_model=TrainingJobResponse)
async def create_region_training_job(
    data_file: UploadFile,
    config_params_json: str = Form(...),
    background_tasks: BackgroundTasks = BackgroundTasks(),
    db: AsyncSession = Depends(get_db)
):
    """
    Create a new region model training job
    
    - **data_file**: The training data file
    - **config_params_json**: JSON string containing training configuration parameters
    """
    return await TrainingController.create_training_job(
        data_file=data_file,
        config_params_json=config_params_json,
        model_type="region",
        background_tasks=background_tasks,
        db=db
    )

@router.post("/identity", status_code=status.HTTP_202_ACCEPTED, response_model=TrainingJobResponse)
async def create_identity_training_job(
    data_file: UploadFile,
    config_params_json: str = Form(...),
    background_tasks: BackgroundTasks = BackgroundTasks(),
    db: AsyncSession = Depends(get_db)
):
    """
    Create a new identity model training job
    
    - **data_file**: The training data file
    - **config_params_json**: JSON string containing training configuration parameters
    """
    return await TrainingController.create_training_job(
        data_file=data_file,
        config_params_json=config_params_json,
        model_type="identity",
        background_tasks=background_tasks,
        db=db
    )

@router.get("/jobs", response_model=List[TrainingJobResponse])
async def get_training_jobs(db: AsyncSession = Depends(get_db)):
    """
    Get all training jobs
    """
    return await TrainingController.get_all_jobs(db=db)

@router.get("/jobs/{job_id}", response_model=TrainingJobResponse)
async def get_training_job(job_id: int, db: AsyncSession = Depends(get_db)):
    """
    Get training job by ID
    
    - **job_id**: The ID of the training job to retrieve
    """
    return await TrainingController.get_job(job_id=job_id, db=db)