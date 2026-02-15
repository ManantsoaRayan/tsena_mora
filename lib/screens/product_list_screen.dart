import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'comparison_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false).fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tsena Mora",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primaryContainer,
                colorScheme.surface,
              ],
            ),
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.products.isEmpty) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_off_rounded, size: 44),
                    SizedBox(height: 8),
                    Text(
                      "Aucun produit pour ce filtre",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text("Essayez une autre catégorie ou sous-catégorie."),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Text(
                            "Catégorie : ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: const Text("Toutes"),
                            selected: provider.selectedCategoryLevel1 == null,
                            showCheckmark: false,
                            selectedColor: colorScheme.primaryContainer,
                            onSelected: (selected) {
                              if (selected) provider.setCategoryLevel1(null);
                            },
                          ),
                          const SizedBox(width: 8),
                          ...provider.categoryLevel1Options.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FilterChip(
                                label: Text(category),
                                selected:
                                    provider.selectedCategoryLevel1 == category,
                                showCheckmark: false,
                                selectedColor: colorScheme.primaryContainer,
                                onSelected: (selected) {
                                  provider.setCategoryLevel1(
                                    selected ? category : null,
                                  );
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    if (provider.selectedCategoryLevel1 != null) ...[
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text(
                              "Sous-catégorie : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 8),
                            FilterChip(
                              label: const Text("Toutes"),
                              selected: provider.selectedCategoryLevel2 == null,
                              showCheckmark: false,
                              selectedColor: colorScheme.primaryContainer,
                              onSelected: (selected) {
                                if (selected) provider.setCategoryLevel2(null);
                              },
                            ),
                            const SizedBox(width: 8),
                            ...provider.categoryLevel2Options.map((category) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChip(
                                  label: Text(category),
                                  selected:
                                      provider.selectedCategoryLevel2 ==
                                      category,
                                  showCheckmark: false,
                                  selectedColor: colorScheme.primaryContainer,
                                  onSelected: (selected) {
                                    provider.setCategoryLevel2(
                                      selected ? category : null,
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: provider.products[index]);
                  },
                ),
              ),
            ],
          );
        },
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
                                  final product = products[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        product.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        "${product.categoryLevel1} > ${product.categoryLevel2}",
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
                                          provider.removeFromCompare(product);
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
