from typing import Union

from fastapi import FastAPI

from app.api.routes import product

app = FastAPI(title="Product Comparison API")

app.include_router(product.router)
