from fastapi.routing import APIRouter

from app.repositories.product_repository import ProductRepository
from app.schemas.product import ProductScored
from app.services.scoring_service import ScoringService

router = APIRouter(prefix="/products", tags=["Products"])

product_repo = ProductRepository("/data/products.csv")
scoring_service = ScoringService(product_repository=product_repo)


@router.get("/scores", response_model=list[ProductScored])
async def get_products():
    product_scored = await scoring_service.get_products()
    print(product_scored)
    return product_scored


@router.get("/categories", response_model=dict)
async def get_categories():
    categories = await scoring_service.get_categories()
    return categories
