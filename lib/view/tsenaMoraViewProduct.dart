import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/view/appBarBottomBar.dart';
import 'package:tsena_mora/view/appColors.dart';
import 'package:tsena_mora/viewModel/viewModelProduct.dart';

class TsenaMoraViewDescription extends StatefulWidget{
  const TsenaMoraViewDescription({super.key});

  @override
  State<TsenaMoraViewDescription> createState() => TsenaMoraViewDescriptionState();
}

class TsenaMoraViewDescriptionState extends State<TsenaMoraViewDescription>{
  AppBarBottomBar appBottom  = AppBarBottomBar();
  @override
  Widget build(BuildContext context) {
    final viewModelProduct = Provider.of<ViewModelProduct>(context);
    return Scaffold(
      appBar: appBottom.appBar(),

      body:(viewModelProduct.isLoading)
        ?Center(child: CircularProgressIndicator(),)
        :Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ),
                  itemCount: viewModelProduct.getListDescription.length, 
                  itemBuilder: (context, index){
                    final description = viewModelProduct.getListDescription[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      color: AppColors.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(description.image), fit: BoxFit.cover)
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(description.price, style: TextStyle(color: Colors.white),),
                            subtitle: Text(description.description, style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    );
                  }
                )
              )
            ],
          ),
        ),


      bottomNavigationBar: appBottom.bottomBar(context),
    );
  }
}