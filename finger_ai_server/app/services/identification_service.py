import uuid
import random
from typing import Dict, Any

class IdentificationService:
    @staticmethod
    async def identify(
        image_base64: str,
        region_model_id: int = None,
        identity_model_id: int = None
    ) -> Dict[str, Any]:
        """Model identification service"""
        print(f"Using region model ID: {region_model_id}, identity model ID: {identity_model_id}")
        
        status_options = ["allowed", "denied", "unknown"]
        status = random.choice(status_options)
        
        employee_id = None
        if status == "allowed":
            employee_id = f"EMP_{uuid.uuid4().hex[:6].upper()}"
            
        return {
            "employee_id": employee_id,
            "status": status
        }