import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'comparison_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFEAF3FF), Colors.white],
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Text(
                        "MGA ${product.price.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Note : ${product.score.toStringAsFixed(1)}",
                      style: TextStyle(
                        color: Colors.amber[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${product.categoryLevel1} > ${product.categoryLevel2} ${product.categoryLevel3 == "__none__" ? "" : " > ${product.categoryLevel3}"}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.description != "nan" ? product.description : "Aucune description disponible",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Chip(
                        label: Text(product.inStock ? "En stock" : "Rupture de stock"),
                        backgroundColor: product.inStock ? Colors.green[100] : Colors.red[100],
                        labelStyle: TextStyle(
                          color: product.inStock ? Colors.green[800] : Colors.red[800],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text("Fournisseur : ${product.provider}"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      final isInCompare = provider.isInCompare(product);
                      final canAddToCompare =
                          isInCompare || provider.canAddToCompare(product);
                      final compareContext = provider.comparisonList.isEmpty
                          ? null
                          : "${provider.comparisonCategoryLevel1} > ${provider.comparisonCategoryLevel2}";

                      return SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton.icon(
                              onPressed: canAddToCompare
                                  ? () {
                                      if (isInCompare) {
                                        provider.removeFromCompare(product);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Retiré de la comparaison")),
                                        );
                                      } else {
                                        provider.addToCompare(product);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Ajouté à la comparaison")),
                                        );
                                      }
                                    }
                                  : null,
                              icon: Icon(isInCompare ? Icons.remove_circle_outline : Icons.add_circle_outline),
                              label: Text(
                                isInCompare
                                    ? "Retirer de la comparaison"
                                    : "Ajouter à la comparaison",
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: isInCompare
                                    ? Colors.red[50]
                                    : Theme.of(context).colorScheme.primaryContainer,
                                foregroundColor:
                                    isInCompare ? Colors.red : Theme.of(context).primaryColor,
                              ),
                            ),
                            if (!canAddToCompare && compareContext != null)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF4E5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Comparaison active : $compareContext. Sélectionnez un produit de la même catégorie et sous-catégorie.",
                                  style: TextStyle(
                                    color: Colors.orange[900],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Suggestions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      // Simple suggestion logic: same category level 2, excluding current product
                      final suggestions = provider.products
                          .where((p) =>
                              p.categoryLevel2 == product.categoryLevel2 &&
                              p.ref != product.ref)
                          .take(4)
                          .toList();

                      if (suggestions.isEmpty) {
                        return const Text("Aucune suggestion disponible.");
                      }

                      return SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ProductCard(product: suggestions[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          return FloatingActionButton(
            onPressed: () => _showComparisonBottomSheet(context),
            tooltip: "Produits à comparer",
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const Icon(Icons.compare_arrows),
                Positioned(
                  right: -7,
                  top: -7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD64545),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${provider.comparisonList.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showComparisonBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Consumer<ProductProvider>(
          builder: (context, provider, _) {
            final products = provider.comparisonList;

            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(sheetContext).size.height * 0.55,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Produits à comparer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${products.length} produit(s) sélectionné(s)",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: products.isEmpty
                            ? Center(
                                child: Text(
                                  "Aucun produit ajouté à la comparaison.",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              )
                            : ListView.separated(
                                itemCount: products.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final comparedProduct = products[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        comparedProduct.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        "${comparedProduct.categoryLevel1} > ${comparedProduct.categoryLevel2}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: IconButton(
                                        tooltip: "Retirer",
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: Color(0xFFD64545),
                                        ),
                                        onPressed: () {
                                          provider.removeFromCompare(comparedProduct);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FilledButton.icon(
                          onPressed: products.isEmpty
                              ? null
                              : () {
                                  Navigator.pop(sheetContext);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ComparisonScreen(),
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.compare_arrows),
                          label: const Text("Comparer maintenant"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
