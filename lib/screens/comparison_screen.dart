import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparer les produits"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: "Effacer la comparaison",
            onPressed: () {
              Provider.of<ProductProvider>(context, listen: false).clearComparison();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Liste de comparaison effacée")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showExplanationPopup(context);
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          final products = provider.comparisonList;

          if (products.isEmpty) {
            return const Center(
              child: Text("Aucun produit sélectionné pour la comparaison."),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  const DataColumn(label: Text("Critère", style: TextStyle(fontWeight: FontWeight.bold))),
                  ...products.map((p) => DataColumn(
                        label: SizedBox(
                          width: 150,
                          child: Text(
                            p.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                ],
                rows: [
                  _buildImageRow(products),
                  _buildRow("Prix", products, (p) => "MGA ${p.price.toStringAsFixed(2)}"),
                  _buildRow("Note", products, (p) => p.score.toStringAsFixed(1)),
                  _buildRow("Catégorie", products, (p) => p.categoryLevel2),
                  _buildRow("Fournisseur", products, (p) => p.provider),
                  _buildRow("Stock", products, (p) => p.inStock ? "En stock" : "Rupture de stock"),
                  _buildRow("Description", products, (p) => p.description != "nan" ? p.description : "non disponible"),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           _showExplanationPopup(context);
        },
        label: const Text("Qui est le gagnant ?"),
        icon: const Icon(Icons.psychology),
      ),
    );
  }

  DataRow _buildImageRow(List<Product> products) {
    return DataRow(
      cells: [
        const DataCell(Text("Image")),
        ...products.map((p) => DataCell(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CachedNetworkImage(
                  imageUrl: p.image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const SizedBox(
                    height: 80,
                    width: 80,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            )),
      ],
    );
  }

  DataRow _buildRow(String feature, List<Product> products, String Function(Product) extractor) {
    return DataRow(
      cells: [
        DataCell(Text(feature, style: const TextStyle(fontWeight: FontWeight.bold))),
        ...products.map((p) => DataCell(
          SizedBox(
            width: 150,
            child: Text(extractor(p), softWrap: true),
          )
        )),
      ],
    );
  }

  void _showExplanationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<String>(
          future: Provider.of<ProductProvider>(context, listen: false).getAdvice(),
          builder: (context, snapshot) {
            return AlertDialog(
              title: const Text("Analyse IA de la comparaison"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (snapshot.connectionState == ConnectionState.waiting)
                      const Center(child: CircularProgressIndicator())
                    else if (snapshot.hasError)
                      const Text("Erreur lors de la récupération des conseils.")
                    else
                      // Text(
                      //   snapshot.data ?? "Aucun conseil disponible.",
                      //   style: const TextStyle(fontSize: 16),
                      // ),
                      MarkdownBody(
                        data: snapshot.data ?? "Aucun conseil disponible.",
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(fontSize: 16),
                        ),
                      )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fermer"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
