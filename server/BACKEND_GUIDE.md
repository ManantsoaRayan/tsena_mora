# Tsena Mora - Backend Documentation

This document provides an overview and explanation of the backend architecture for the Tsena Mora product comparison application.

## Architecture Overview

The backend is built with **FastAPI**, following a modular structure that separates concerns into routes, services, repositories, and schemas.

### Directory Structure

```text
server/
├── app/
│   ├── main.py              # Application entry point
│   ├── api/
│   │   └── routes/
│   │       ├── product.py   # Product and category endpoints
│   │       └── ai.py        # AI comparison endpoints
│   ├── ai/
│   │   └── adviser.py       # Ollama/DeepSeek integration logic
│   ├── services/
│   │   └── scoring_service.py # Business logic (scoring & categories)
│   ├── repositories/
│   │   └── product_repository.py # Data access layer (CSV reading)
│   ├── schemas/
│   │   └── product.py       # Pydantic models for data validation
│   └── utils/
│       └── normalizations.py # Utility functions for data processing
├── data/
│   └── products.csv         # The product dataset
└── requirements.txt         # Project dependencies
```

---

## Component Explanations

### 1. Entry Point (`app/main.py`)
- Initializes the FastAPI application.
- Configures **CORS** (Cross-Origin Resource Sharing) to allow the Flutter app to communicate with the server.
- Includes the routers from the `api/routes` directory.

### 2. API Routes (`app/api/routes/`)
- **`product.py`**: Defines GET endpoints for `/products/scores` (fetching all products with calculated scores) and `/products/categories` (fetching the category hierarchy).
- **`ai.py`**: Defines a POST endpoint `/ai/advice` that receives a list of products and returns AI-generated comparison advice.

### 3. AI Service (`app/ai/adviser.py`)
- Handles communication with **Ollama**.
- Uses the **DeepSeek-R1:8b** model.
- Formats product data into a prompt and requests a comparison analysis in **French**.

### 4. Scoring Service (`app/services/scoring_service.py`)
- Contains the core business logic.
- **`calculate_score`**: Computes a weighted score (0-100) for each product based on price (normalized), stock availability, and provider reputation.
- **`get_categories`**: Processes the raw product data to build a hierarchical dictionary of categories and subcategories.

### 5. Repository (`app/repositories/product_repository.py`)
- Acts as the data access layer.
- Uses **Pandas** to read and parse the `products.csv` file.
- Converts raw CSV rows into `ProductBase` objects.

### 6. Schemas (`app/schemas/product.py`)
- Defines **Pydantic** models (`ProductBase`, `ProductScored`) to ensure data consistency between the CSV, the business logic, and the API responses.

### 7. Utils (`app/utils/normalizations.py`)
- Provides helper functions like `normalize_min_max` used by the scoring service to scale values between 0 and 1.

---

## Data Flow

1. **Request**: The Flutter app sends a request to an endpoint (e.g., `/products/scores`).
2. **Route**: The route in `product.py` calls the corresponding method in `ScoringService`.
3. **Repository**: `ScoringService` requests raw data from `ProductRepository`.
4. **Data Loading**: `ProductRepository` reads `products.csv` and returns a list of product objects.
5. **Logic**: `ScoringService` applies the scoring algorithm or category mapping.
6. **AI (Optional)**: For comparison advice, the `ai.py` route calls the `Adviser` which interacts with the local Ollama instance.
7. **Response**: The processed data is returned as JSON to the Flutter app.
