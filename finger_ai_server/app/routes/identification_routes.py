from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.controllers.identification_controller import IdentificationController
from app.database.database import get_db
from app.schemas.schemas import IdentificationRequest, IdentificationResponse

router = APIRouter(prefix="/identify", tags=["Identification"])

@router.post("", response_model=IdentificationResponse)
async def identify(
    request: IdentificationRequest,
    db: AsyncSession = Depends(get_db)
):
    """
    Process identification request (model implementation)
    
    - **request**: JSON body containing base64 encoded image data
    """
    return await IdentificationController.identify(request=request, db=db)