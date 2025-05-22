from fastapi import APIRouter, Depends, status
from typing import List
from sqlalchemy.ext.asyncio import AsyncSession

from app.controllers.model_controller import ModelController
from app.database.database import get_db
from app.schemas.schemas import ModelResponse, ModelUpdate, MessageResponse

router = APIRouter(prefix="/models", tags=["Models"])

@router.get("", response_model=List[ModelResponse])
async def get_models(db: AsyncSession = Depends(get_db)):
    """
    Get all trained models
    """
    return await ModelController.get_all_models(db=db)

@router.get("/{model_id}", response_model=ModelResponse)
async def get_model(model_id: int, db: AsyncSession = Depends(get_db)):
    """
    Get model by ID
    
    - **model_id**: The ID of the model to retrieve
    """
    return await ModelController.get_model(model_id=model_id, db=db)

@router.patch("/{model_id}", response_model=ModelResponse)
async def update_model(
    model_id: int, 
    update_data: ModelUpdate, 
    db: AsyncSession = Depends(get_db)
):
    """
    Update model information
    
    - **model_id**: The ID of the model to update
    - **update_data**: Data to update (name and/or status)
    """
    return await ModelController.update_model(
        model_id=model_id,
        update_data=update_data,
        db=db
    )

@router.delete("/{model_id}", response_model=MessageResponse)
async def delete_model(model_id: int, db: AsyncSession = Depends(get_db)):
    """
    Delete a model
    
    - **model_id**: The ID of the model to delete
    """
    return await ModelController.delete_model(model_id=model_id, db=db)