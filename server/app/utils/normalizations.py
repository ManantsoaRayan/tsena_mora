def normalize_min_max(value: float, min_value: float, max_value: float) -> float:
    if max_value == min_value:
        return 1.0
    return 1 - (value - min_value) / (max_value - min_value)

