import 'package:sqflite/sqflite.dart';
import 'package:tsena_mora/database_helper.dart';
import '../model/product_model.dart';

class ProductRepository {
  final DatabaseHelper _dbhelper = DatabaseHelper();

  /// Insert a new product
  Future<int> insertProduct(Product product) async {
    final db = await _dbhelper.database;

    return await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all products
  Future<List<Product>> getAllProducts() async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> products = await db.query('products');

    return List.generate(products.length, (i) {
      return Product.fromMap(products[i]);
    });
  }

  /// Get product by id
  Future<Product?> getProductById(int id) async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> products = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (products.isEmpty) return null;

    return Product.fromMap(products.first);
  }

  /// Update a product
  Future<int> updateProduct(Product product) async {
    final db = await _dbhelper.database;

    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  /// Delete a product
  Future<int> deleteProduct(int id) async {
    final db = await _dbhelper.database;

    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get all favorite products
  Future<List<Product>> getFavoriteProducts() async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> products = await db.query(
      'products',
      where: 'is_favorite = ?',
      whereArgs: [1],
    );

    return List.generate(products.length, (i) {
      return Product.fromMap(products[i]);
    });
  }

  /// Toggle favorite status for a product
  Future<int> toggleFavorite(int id, bool isFavorite) async {
    final db = await _dbhelper.database;

    return await db.update(
      'products',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Search products by name
  Future<List<Product>> searchProductsByName(String query) async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> products = await db.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );

    return List.generate(products.length, (i) {
      return Product.fromMap(products[i]);
    });
  }

  /// Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> products = await db.query(
      'products',
      where: 'category = ?',
      whereArgs: [category],
    );

    return List.generate(products.length, (i) {
      return Product.fromMap(products[i]);
    });
  }

  /// Get favorite products by category
  Future<List<Product>> getFavoriteProductsByCategory(String category) async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> products = await db.query(
      'products',
      where: 'is_favorite = ? AND category = ?',
      whereArgs: [1, category],
    );

    return List.generate(products.length, (i) {
      return Product.fromMap(products[i]);
    });
  }

  /// Get all distinct categories
  Future<List<String>> getAllCategories() async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      'SELECT DISTINCT category FROM products WHERE category IS NOT NULL',
    );

    return results.map((row) => row['category'] as String).toList();
  }

  /// Get product count
  Future<int> getProductCount() async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      'SELECT COUNT(*) as count FROM products',
    );

    return (results.first['count'] as int?) ?? 0;
  }

  /// Get favorite product count
  Future<int> getFavoriteProductCount() async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      'SELECT COUNT(*) as count FROM products WHERE is_favorite = 1',
    );

    return (results.first['count'] as int?) ?? 0;
  }

  /// Delete all products
  Future<int> deleteAllProducts() async {
    final db = await _dbhelper.database;

    return await db.delete('products');
  }
}
