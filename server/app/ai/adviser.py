from ollama import chat

from app.schemas.product import ProductScored


class Adviser:
    def __init__(self, model: str = "gemma3:1b"):
        self.model = model

    def generate_advice(self, products: list[ProductScored]) -> str:
        if not products:
            return "No products to compare."

        products_str = "\n".join(
            [
                f"- {p.name} (Price: {p.price} Ariary, Score: {p.score}, Provider: {p.provider}, Stock: {p.in_stock}, Description: {p.description})"
                for p in products
            ]
        )

        prompt = (
            f"Comparez les produits suivants et sélectionnez le meilleur en fonction du score et des caractéristiques.Tous les prix etant en MGA "
            f"Expliquez pourquoi c'est le gagnant. Soyez concis et répondez en français.\n\n{products_str}"
        )

        try:
            response = chat(
                model=self.model,
                messages=[
                    {"role": "user", "content": prompt},
                ],
            )
            return response["message"]["content"]
        except Exception as e:
            print(f"Error generating advice: {e}")
            return "Sorry, I couldn't generate advice at this time."
