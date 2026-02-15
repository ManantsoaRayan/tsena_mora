from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.routes import product, ai

app = FastAPI(title="Product Comparison API")

# CORS settings - adjust origins for production as needed
origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://127.0.0.1",
    "http://127.0.0.1:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # use origins or specific domains in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(product.router)
app.include_router(ai.router)
