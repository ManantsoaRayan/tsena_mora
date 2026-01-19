from typing import List

import numpy as np

from app.repositories.product_repository import ProductRepository
from app.schemas.product import ProductBase, ProductScored
from app.utils.normalizations import normalize_min_max


class ScoringService:
    def __init__(self, product_repository: ProductRepository) -> None:
        self.product_repository = product_repository

    async def calculate_score(self, products: list[ProductBase]) -> list[ProductScored]:
        prices = [product.price for product in products]
        min_price = min(prices)
        max_price = max(prices)
        providers_score = {"Kibo": 3.8, "Bon Marche": 3.6}

        scores = []

        for product in products:
            price_score = normalize_min_max(product.price, min_price, max_price)
            stock_score = 1.0 if product.in_stock else 0.0
            rating_score = normalize_min_max(
                providers_score.get(product.provider, 3.0), 0, 5
            )

            final_score = (
                np.dot([price_score, stock_score, rating_score], [0.5, 0.3, 0.2]) * 100
            )

            scores.append(
                ProductScored(**product.model_dump(), score=round(final_score, 2))
            )

        return sorted(scores, key=lambda x: x.score, reverse=True)

    async def get_products(self) -> list[ProductScored]:
        products = self.product_repository.get_products()
        return await self.calculate_score(products)

    async def get_categories(self) -> dict:
        categories = {}
        for _, row in self.product_repository.df.iterrows():
            if not categories.get(row["category_level1"]):
                categories[row["category_level1"]] = set()
            categories[row["category_level1"]].add(row["category_level2"])
            categories[row["category_level1"]].add(row["category_level3"])

        # Convert sets to lists for JSON serialization
        print(categories)
        return {k: list(v) for k, v in categories.items()}
