import json
from pathlib import Path

from app.schemas.product import ProductBase

DATA_FILE = Path(__file__).parent.resolve().parent.parent


class ProductRepository:
    def __init__(self, json_path: str) -> None:
        file_path = DATA_FILE / json_path

        try:
            with open(file_path, "r", encoding="utf-8") as f:
                self.data = json.load(f)
            print(
                f"[INFO] Chargement JSON réussi : {json_path} ({len(self.data)} produits)"
            )
        except Exception as e:
            print(f"[ERREUR] Impossible de charger le JSON : {e}")
            self.data = []  # Liste vide pour éviter crash

    def get_products(self) -> list[ProductBase]:
        products = []
        for item in self.data:
            products.append(
                ProductBase(
                    name=str(item.get("name", "Produit inconnu")),
                    price=float(item.get("price", 0.0)),
                    ref=str(item.get("ref", "")),
                    description=str(item.get("description", "")),
                    image=str(item.get("image", "")),
                    provider=str(item.get("provider", "BonMarché")),
                    category_level1=str(item.get("category_level1", "")),
                    category_level2=str(item.get("category_level2", "")),
                    category_level3=str(item.get("category_level3", "")),
                    in_stock=bool(item.get("in_stock", True)),
                )
            )
        return products
