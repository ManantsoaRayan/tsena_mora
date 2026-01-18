from fastapi.routing import APIRouter

from app.repositories.product_repository import ProductRepository
from app.schemas.product import ProductScored
from app.services.scoring_service import ScoringService

router = APIRouter(prefix="/products", tags=["Products"])

# ← Utilise ton fichier JSON ici
product_repo = ProductRepository("data/products.json")  # adapte le chemin si besoin

scoring_service = ScoringService(product_repository=product_repo)


@router.get("/scores", response_model=list[ProductScored])
async def get_products():
    product_scored = await scoring_service.get_products()
    return product_scored