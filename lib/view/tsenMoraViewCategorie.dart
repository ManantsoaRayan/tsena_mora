import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/view/appBarBottomBar.dart';
import 'package:tsena_mora/viewModel/viewModelCategorie.dart';

class TsenaMoraViewCategorie extends StatefulWidget{
  const TsenaMoraViewCategorie({super.key});

  @override
  State<TsenaMoraViewCategorie> createState() => TsenaMoraViewState();
}

class TsenaMoraViewState extends State<TsenaMoraViewCategorie>{
  AppBarBottomBar appBottom  = AppBarBottomBar();
  int? setIndex;
  @override
  Widget build(BuildContext context){
    final viewModelCategorie = Provider.of<ViewModelCategorie>(context);
    //final  userName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: appBottom.appBar(),
      body: (viewModelCategorie.isLoading)
        ? Center(child: CircularProgressIndicator(),)
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Color(0XFFFF7A7A)),
                        elevation: WidgetStateProperty.all(0),
                      ),
                      onPressed: (){}, 
                      child: Text(
                        "Categorien 1",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Color(0XFFFF7A7A)),
                        elevation: WidgetStateProperty.all(0),
                      ),
                      onPressed: (){}, 
                      child: Text(
                        "Categorien 2",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Color(0XFFFF7A7A)),
                        elevation: WidgetStateProperty.all(0),
                      ),
                      onPressed: (){}, 
                      child: Text(
                        "Categorien 3",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ),
                  itemCount: viewModelCategorie.getListCategorie.length, 
                  itemBuilder: (context, index){
                    final categorie = viewModelCategorie.getListCategorie[index];
                    return InkWell(
                      onTap: (){
                        setState(() {
                          setIndex = (setIndex == index)? null:index;
                        });
                        if(setIndex == index) {
                          Navigator.pushNamed(context, '/description');
                        }
                      },
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        ),
                        clipBehavior: Clip.antiAlias,
                        color: Color(0XFFFF7A7A),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(categorie.imageCategorie), fit: BoxFit.cover, opacity: 0.1)
                          ),
                          child: Center(
                            child: Text(
                              categorie.categorie,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            )
                          )
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: appBottom.bottomBar(context)
    );
  }
}