from sqlalchemy import Column, Integer, String, Float, ForeignKey, DateTime, Text, JSON
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

from app.database.database import Base

class TrainingJob(Base):
    __tablename__ = "training_jobs"
    
    id = Column(Integer, primary_key=True, index=True)
    model_type = Column(String, nullable=False)  # 'region' or 'identity'
    status = Column(String, nullable=False)  # 'pending', 'running', 'completed', 'failed'
    created_at = Column(DateTime, server_default=func.now())
    started_at = Column(DateTime, nullable=True)
    completed_at = Column(DateTime, nullable=True)
    uploaded_data_path = Column(Text, nullable=False)
    original_filename = Column(Text, nullable=True)
    config_params = Column(JSON, nullable=False)
    error_message = Column(Text, nullable=True)
    
    # Relationship
    trained_models = relationship("TrainedModel", back_populates="training_job", cascade="all, delete-orphan")

class TrainedModel(Base):
    __tablename__ = "trained_models"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    type = Column(String, nullable=False)  # 'region' or 'identity'
    created_at = Column(DateTime, server_default=func.now())
    model_path = Column(String, nullable=False)  # Path to model model file
    status = Column(String, default="active")  # 'active' or 'inactive'
    training_job_id = Column(Integer, ForeignKey("training_jobs.id"))
    model_accuracy = Column(Float, nullable=True)
    model_loss = Column(Float, nullable=True)
    
    # Relationship
    training_job = relationship("TrainingJob", back_populates="trained_models")