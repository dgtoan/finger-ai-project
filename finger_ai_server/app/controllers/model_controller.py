from typing import List, Dict, Any, Optional
from fastapi import Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.database.database import get_db
from app.services.model_service import ModelService
from app.models.models import TrainedModel
from app.schemas.schemas import ModelResponse, ModelUpdate, MessageResponse

class ModelController:
    @staticmethod
    async def get_all_models(db: AsyncSession = Depends(get_db)) -> List[TrainedModel]:
        """Get all trained models"""
        try:
            return await ModelService.get_all_models(db)
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error retrieving models: {str(e)}"
            )

    @staticmethod
    async def get_model(model_id: int, db: AsyncSession = Depends(get_db)) -> TrainedModel:
        """Get a specific model by ID"""
        model = await ModelService.get_model(db, model_id)
        if not model:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Model with ID {model_id} not found"
            )
        return model

    @staticmethod
    async def update_model(
        model_id: int, 
        update_data: ModelUpdate,
        db: AsyncSession = Depends(get_db)
    ) -> TrainedModel:
        """Update model information"""
        model = await ModelService.get_model(db, model_id)
        if not model:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Model with ID {model_id} not found"
            )
            
        try:
            update_dict = update_data.dict(exclude_unset=True)
            
            if "status" in update_dict and update_dict["status"] not in ["active", "inactive"]:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail=f"Invalid status value. Must be either 'active' or 'inactive'"
                )
                
            updated_model = await ModelService.update_model(db, model_id, update_dict)
            return updated_model
            
        except Exception as e:
            if isinstance(e, HTTPException):
                raise e
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error updating model: {str(e)}"
            )
    
    @staticmethod
    async def delete_model(model_id: int, db: AsyncSession = Depends(get_db)) -> MessageResponse:
        """Delete a model"""
        result = await ModelService.delete_model(db, model_id)
        if not result:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Model with ID {model_id} not found"
            )
            
        return MessageResponse(message=f"Model with ID {model_id} successfully deleted")