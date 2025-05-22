from pydantic import BaseModel, Json
from typing import Optional, List, Dict, Any, Union
from datetime import datetime

class ConfigParams(BaseModel):
    img_size: Optional[int] = 640
    epochs: Optional[int] = 50
    batch_size: Optional[int] = 16
    model_base: Optional[str] = "yolo11n.pt"
    
    class Config:
        from_attributes = True

class ModelUpdate(BaseModel):
    name: Optional[str] = None
    status: Optional[str] = None
    
    class Config:
        from_attributes = True

class IdentificationRequest(BaseModel):
    image_base64: str
    region_model_id: int
    identity_model_id: int
    
    class Config:
        from_attributes = True

class TrainingJobBase(BaseModel):
    id: int
    model_type: str
    status: str
    created_at: datetime
    started_at: Optional[datetime] = None
    completed_at: Optional[datetime] = None
    original_filename: Optional[str] = None
    error_message: Optional[str] = None
    
    class Config:
        from_attributes = True

class TrainingJobResponse(TrainingJobBase):
    config_params: Dict[str, Any]
    
    class Config:
        from_attributes = True

class ModelBase(BaseModel):
    id: int
    name: str
    type: str
    created_at: datetime
    status: str
    
    class Config:
        from_attributes = True

class ModelResponse(ModelBase):
    training_job_id: int
    model_accuracy: Optional[float] = None
    model_loss: Optional[float] = None
    
    class Config:
        from_attributes = True

class IdentificationResponse(BaseModel):
    employee_id: Optional[str] = None
    status: str  # 'allowed', 'denied', 'unknown'
    
    class Config:
        from_attributes = True

class MessageResponse(BaseModel):
    message: str