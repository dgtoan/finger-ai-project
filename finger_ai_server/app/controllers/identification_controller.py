from fastapi import Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.database.database import get_db
from app.services.identification_service import IdentificationService
from app.schemas.schemas import IdentificationRequest, IdentificationResponse

class IdentificationController:
    @staticmethod
    async def identify(
        request: IdentificationRequest,
        db: AsyncSession = Depends(get_db)
    ) -> IdentificationResponse:
        """Handle identification requests"""
        try:
            result = await IdentificationService.identify(
                request.image_base64,
                region_model_id=request.region_model_id,
                identity_model_id=request.identity_model_id
            )
            
            return IdentificationResponse(
                employee_id=result.get("employee_id"),
                status=result.get("status"),
                identified_image_base64=result.get("identified_image_base64")
            )
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error during identification: {str(e)}"
            )