from pathlib import Path

import pandas as pd

from app.schemas.product import ProductBase

DATA_FILE = Path(__file__).parent.resolve().parent.parent


class ProductRepository:
    def __init__(self, csv_path: str) -> None:
        self.df = pd.read_csv(str(DATA_FILE) + "/" + csv_path)

    def get_products(self) -> list[ProductBase]:
        products = []

        for _, row in self.df.iterrows():
            products.append(
                ProductBase(
                    name=str(row["name"]),
                    price=float(row["price"]),
                    ref=str(row["ref"]),
                    description=str(row["description"]),
                    image=str(row["image"]),
                    provider=str(row["provider"]),
                    category_level1=str(row["category_level1"]),
                    category_level2=str(row["category_level2"]),
                    category_level3=str(row["category_level3"]),
                    in_stock=bool(row["in_stock"]),
                )
            )
        return products
