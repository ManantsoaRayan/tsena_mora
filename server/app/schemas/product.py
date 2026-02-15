from pydantic import BaseModel
from typing import Optional

class ProductBase(BaseModel):
    name:str
    description: Optional[str]
    ref: str
    image: str
    price: float
    provider: str
    category_level1: Optional[str]
    category_level2: Optional[str]
    category_level3: Optional[str]
    in_stock: bool

class ProductScored(ProductBase):
    score: float
