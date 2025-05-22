import uuid
import random
from typing import Dict, Any
import base64
from ultralytics import YOLO
from pathlib import Path
import os
import cv2  # Added import for OpenCV

class IdentificationService:
    @staticmethod
    async def identify(
        image_base64: str,
        region_model_id: int = None,
        identity_model_id: int = None
    ) -> Dict[str, Any]:
        """Model identification service"""
        print(f"Using region model ID: {region_model_id}, identity model ID: {identity_model_id}")

        # Decode the base64 image
        image_data = base64.b64decode(image_base64)
        
        # Define paths for saving and processing images
        upload_dir = Path("uploads/identification_images")
        upload_dir.mkdir(parents=True, exist_ok=True)
        
        results_dir = Path("uploads/identification_results")
        results_dir.mkdir(parents=True, exist_ok=True)

        image_filename = f"{uuid.uuid4().hex[:10]}.png"
        image_path = upload_dir / image_filename
        
        # Save the uploaded image
        with open(image_path, "wb") as f:
            f.write(image_data)

        identified_image_base64 = None
        # --- Region Model Prediction (YOLO) ---
        if region_model_id:
            # TEMPORARY: Using a fixed model path for demonstration.
            # Replace 'yolo11n.pt' with the actual path to your trained region detection model.
            # This path should point to the .pt file of your trained YOLO model.
            # The model should be trained to detect fingerprint regions.
            yolo_model_path = "yolo11n.pt" # Replace with your actual region model path

            if os.path.exists(yolo_model_path):
                model = YOLO(yolo_model_path)
                
                # Perform detection
                # The `save=True` argument will save the image with detections.
                # `project` specifies the directory to save results.
                # `name` specifies the subdirectory within `project`.
                # We keep save=True for now, though not strictly needed for plot()
                results = model.predict(source=str(image_path), save=True, project=str(results_dir), name=f"run_{image_filename.split('.')[0]}")
                
                if results and len(results) > 0:
                    try:
                        # Use plot() to get the image with detections as a NumPy array
                        im_array = results[0].plot(conf=True, labels=True) # Default is BGR
                        
                        # Encode the NumPy array to PNG image bytes
                        is_success, buffer = cv2.imencode(".png", im_array)
                        
                        if is_success:
                            identified_image_base64 = base64.b64encode(buffer).decode('utf-8')
                        else:
                            print("Error: Failed to encode plotted image to PNG.")
                            # Optionally, fall back to original image or None
                            # For example, to send original image if plotting fails:
                            # with open(image_path, "rb") as img_file:
                            #     identified_image_base64 = base64.b64encode(img_file.read()).decode('utf-8')
                    except Exception as e:
                        print(f"Error processing results[0].plot() or encoding: {e}")
                        # Optionally, fall back to original image or None
                else:
                    print("Error: YOLO prediction did not return expected results structure.")
            else:
                print(f"Error: Region model not found at {yolo_model_path}. Skipping region detection.")
        # --- End Region Model Prediction ---

        status_options = ["allowed", "denied", "unknown"]
        status = random.choice(status_options)
        
        employee_id = None
        if status == "allowed":
            employee_id = f"EMP_{uuid.uuid4().hex[:6].upper()}"
            
        return {
            "employee_id": employee_id,
            "status": status,
            "identified_image_base64": identified_image_base64
        }