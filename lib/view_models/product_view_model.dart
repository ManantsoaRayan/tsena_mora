import 'package:flutter/material.dart';
import 'package:tsena_mora/repositories/product_repository.dart';
import '../model/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<Product> _favoriteProducts = [];
  List<String> _categories = [];

  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Tous';
  String _searchQuery = '';

  // Getters
  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get favoriteProducts => _favoriteProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  // Initialize and load all products
  Future<void> loadAllProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _productRepository.getAllProducts();
      await loadCategories();
      _applyFilters();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load products: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load all categories
  Future<void> loadCategories() async {
    try {
      _categories = ['Tous'];
      final dbCategories = await _productRepository.getAllCategories();
      _categories.addAll(dbCategories);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load categories: ${e.toString()}";
      notifyListeners();
    }
  }

  // Load favorite products
  Future<void> loadFavoriteProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _favoriteProducts = await _productRepository.getFavoriteProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load favorites: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new product
  Future<bool> addProduct(Product product) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _productRepository.insertProduct(product);
      await loadAllProducts();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Failed to add product: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update product
  Future<bool> updateProduct(Product product) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _productRepository.updateProduct(product);
      await loadAllProducts();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Failed to update product: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _productRepository.deleteProduct(id);
      await loadAllProducts();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Failed to delete product: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Toggle favorite status
  Future<bool> toggleFavorite(int id, bool currentStatus) async {
    _errorMessage = null;
    notifyListeners();

    try {
      await _productRepository.toggleFavorite(id, !currentStatus);

      // Update the product in the local list
      final productIndex = _products.indexWhere((p) => p.id == id);
      if (productIndex != -1) {
        _products[productIndex].isFavorite = !currentStatus;
      }

      // Update filtered products
      final filteredIndex = _filteredProducts.indexWhere((p) => p.id == id);
      if (filteredIndex != -1) {
        _filteredProducts[filteredIndex].isFavorite = !currentStatus;
      }

      await loadFavoriteProducts();
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Failed to update favorite: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  // Search products by name
  Future<void> searchProducts(String query) async {
    _searchQuery = query;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (query.isEmpty) {
        _applyFilters();
      } else {
        _filteredProducts = await _productRepository.searchProductsByName(query);
        // Apply category filter on search results
        if (_selectedCategory != 'Tous') {
          _filteredProducts = _filteredProducts
              .where((p) => p.category == _selectedCategory)
              .toList();
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Search failed: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filter by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  // Apply filters (category and search)
  void _applyFilters() {
    _filteredProducts = _products;

    // Apply category filter
    if (_selectedCategory != 'Tous') {
      _filteredProducts = _filteredProducts
          .where((p) => p.category == _selectedCategory)
          .toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredProducts = _filteredProducts
          .where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  // Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      if (category == 'Tous') {
        return _products;
      }
      return await _productRepository.getProductsByCategory(category);
    } catch (e) {
      _errorMessage = "Failed to get products by category: ${e.toString()}";
      notifyListeners();
      return [];
    }
  }

  // Get favorite products by category
  Future<List<Product>> getFavoriteProductsByCategory(String category) async {
    try {
      if (category == 'Tous') {
        return _favoriteProducts;
      }
      return await _productRepository.getFavoriteProductsByCategory(category);
    } catch (e) {
      _errorMessage = "Failed to get favorite products by category: ${e.toString()}";
      notifyListeners();
      return [];
    }
  }

  // Get product by id
  Future<Product?> getProductById(int id) async {
    try {
      return await _productRepository.getProductById(id);
    } catch (e) {
      _errorMessage = "Failed to get product: ${e.toString()}";
      notifyListeners();
      return null;
    }
  }

  // Get product count
  Future<int> getProductCount() async {
    try {
      return await _productRepository.getProductCount();
    } catch (e) {
      _errorMessage = "Failed to get product count: ${e.toString()}";
      notifyListeners();
      return 0;
    }
  }

  // Get favorite product count
  Future<int> getFavoriteProductCount() async {
    try {
      return await _productRepository.getFavoriteProductCount();
    } catch (e) {
      _errorMessage = "Failed to get favorite product count: ${e.toString()}";
      notifyListeners();
      return 0;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Reset filters
  void resetFilters() {
    _selectedCategory = 'Tous';
    _searchQuery = '';
    _applyFilters();
    notifyListeners();
  }
}
