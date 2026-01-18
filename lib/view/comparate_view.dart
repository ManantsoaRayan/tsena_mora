import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/model/product_model.dart';
import 'package:tsena_mora/view/app_colors.dart';
import 'package:tsena_mora/viewModel/view_model_product.dart';

class ComparateView extends StatefulWidget {
  const ComparateView({super.key});

  @override
  State<ComparateView> createState() => ComparateViewState();
}

class ComparateViewState extends State<ComparateView> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ViewModelProduct>(context);
    final product = vm.selectProduct!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tsena mora",
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          color: AppColors.textLight,
          child: ListView(
            children: [
              // Image principale du produit sélectionné
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      product.description,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Ar ${product.price.toStringAsFixed(0)}",
                      style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                    ),
                    RatingBarIndicator(
                      rating: product.rating,
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 14,
                      unratedColor: Colors.grey,
                    ),

                    const SizedBox(height: 30),
                    Text(
                      "Similar To ",
                      style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Grille des produits similaires
              MasonryGridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                itemCount: vm.getListDescription.length,
                itemBuilder: (context, index) {
                  final productCo = vm.getListDescription[index];
                  final productCompare = ProductClass(
                    title: product.title,
                    price: product.price,
                    description: product.description,
                    image: product.image,
                    rating: product.rating,
                  );

                  if (productCo.title == product.title) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: AppColors.textLight,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              productCo.image,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productCo.title,
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                productCo.description,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Ar ${productCo.price.toStringAsFixed(0)}",
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RatingBarIndicator(
                                rating: productCo.rating,
                                itemBuilder: (context, index) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                itemCount: 5,
                                itemSize: 14,
                                unratedColor: const Color.fromARGB(
                                  255,
                                  85,
                                  53,
                                  53,
                                ),
                              ),
                              Text(
                                "Price difference Ar:${vm.comparateProduct(productCompare, productCo.price)}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.compare, color: Colors.amber),
      ),
    );
  }
}
