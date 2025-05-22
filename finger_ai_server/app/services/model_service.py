import os
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import update, delete
from typing import Dict, Any, List, Optional

from app.models.models import TrainedModel

class ModelService:
    @staticmethod
    async def get_all_models(db: AsyncSession) -> List[TrainedModel]:
        """Get all trained models"""
        result = await db.execute(select(TrainedModel).order_by(TrainedModel.created_at.desc()))
        return result.scalars().all()
        
    @staticmethod
    async def get_model(db: AsyncSession, model_id: int) -> Optional[TrainedModel]:
        """Get a specific model by ID"""
        return await db.get(TrainedModel, model_id)
        
    @staticmethod
    async def update_model(
        db: AsyncSession,
        model_id: int,
        update_data: Dict[str, Any]
    ) -> Optional[TrainedModel]:
        """Update model information"""
        filtered_data = {k: v for k, v in update_data.items() if v is not None}
        
        if not filtered_data:
            return await ModelService.get_model(db, model_id)
            
        await db.execute(
            update(TrainedModel)
            .where(TrainedModel.id == model_id)
            .values(**filtered_data)
        )
        await db.commit()
        
        return await ModelService.get_model(db, model_id)
        
    @staticmethod
    async def delete_model(db: AsyncSession, model_id: int) -> bool:
        """Delete a model"""
        model = await db.get(TrainedModel, model_id)
        if not model:
            return False
            
        if os.path.exists(model.model_path):
            os.remove(model.model_path)
            
        await db.execute(delete(TrainedModel).where(TrainedModel.id == model_id))
        await db.commit()
        
        return True
