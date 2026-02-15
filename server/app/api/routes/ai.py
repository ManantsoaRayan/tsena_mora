from fastapi import APIRouter, Body
from app.ai.adviser import Adviser
from app.schemas.product import ProductScored

router = APIRouter(prefix="/ai", tags=["AI"])
adviser = Adviser()

@router.post("/advice")
async def get_advice(products: list[ProductScored] = Body(...)):
    advice = adviser.generate_advice(products)
    return {"advice": advice}
