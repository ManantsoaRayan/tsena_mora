class Product {
  int? id;
  String name;
  double price;
  String description;
  bool isFavorite;
  String image;
  String? category;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isFavorite,
    required this.image,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'is_favorite': isFavorite ? 1 : 0,
      'image': image,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'].toDouble(),
      description: map['description'],
      isFavorite: map['is_favorite'] == 1,
      image: map['image'],
      category: map['category'],
    );
  }
}
