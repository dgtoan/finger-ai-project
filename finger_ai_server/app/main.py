import asyncio
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

from app.database.database import Base, engine
from app.routes import training_routes, model_routes, identification_routes

@asynccontextmanager
async def lifespan(app: FastAPI):
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    
    yield
    
    await engine.dispose()

app = FastAPI(
    title="Finger AI API",
    description="A simplified FastAPI backend for fingerprint recognition",
    version="1.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(training_routes.router)
app.include_router(model_routes.router)
app.include_router(identification_routes.router)

@app.get("/")
async def root():
    """
    Root endpoint - Health check
    """
    return {"message": "Finger AI API is running", "status": "online"}