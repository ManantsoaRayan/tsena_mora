import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/model/product_model.dart';
import 'package:tsena_mora/view/app_bar_bottom_bar.dart';
import 'package:tsena_mora/view/app_colors.dart';
import 'package:tsena_mora/view/comparate_view.dart';
import 'package:tsena_mora/viewModel/view_model_product.dart';

class TsenaMoraViewDescription extends StatefulWidget {
  const TsenaMoraViewDescription({super.key});

  @override
  State<TsenaMoraViewDescription> createState() =>
      TsenaMoraViewDescriptionState();
}

class TsenaMoraViewDescriptionState extends State<TsenaMoraViewDescription> {
  AppBarBottomBar appBottom = AppBarBottomBar();
  @override
  Widget build(BuildContext context) {
    final viewModelProduct = Provider.of<ViewModelProduct>(context);
    return Scaffold(
      appBar: appBottom.appBar(),

      body: (viewModelProduct.isLoading)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SearchBar(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    elevation: WidgetStatePropertyAll(0),
                    leading: Icon(Icons.search),
                    hintText: "Search article " /*  */,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: MasonryGridView.builder(
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: viewModelProduct.getListDescription.length,
                      itemBuilder: (context, index) {
                        final description =
                            viewModelProduct.getListDescription[index];
                        return InkWell(
                          onTap: () {
                            ProductClass productClass = ProductClass(
                              title: description.title,
                              price: description.price,
                              description: description.description,
                              image: description.image,
                              rating: description.rating,
                            );
                            viewModelProduct.selectdProduct(productClass);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ComparateView(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAlias,
                            color: AppColors.textLight,
                            //color: AppColors.primary,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.asset(
                                      description.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        description.title,
                                        style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        description.description,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "Ar:${description.price}",
                                        style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RatingBarIndicator(
                                        rating: description.rating,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                        itemCount: 5,
                                        itemSize: 14,
                                        unratedColor: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

      bottomNavigationBar: appBottom.bottomBar(context),
    );
  }
}
