import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tsena_mora/view/appColors.dart';

class AppBarBottomBar {

  PreferredSizeWidget appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primary,
      title: const Text(
        'Tsena Mora',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white
        ),
      ),
      centerTitle: true,
    );
  }

  Widget bottomBar(BuildContext context){
    return BottomAppBar(
      height: 50,
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.list, color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.chat, color: Colors.white)),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/categorie'), icon: Icon(Icons.home, color: Colors.white)),

          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    content: Text("Vous voukez vraiment sortire"),
                    actions: [
                      TextButton(onPressed: ()=> Navigator.pushNamed(context, '/login'), child: Text("oui")),
                      TextButton(onPressed: () => Navigator.pop(context), child: Text("Non"))
                    ],
                  );
                }
              );
            }, 
            icon: Icon(Icons.logout_rounded, color: Colors.white)
          ),
        ],
      ),
    );
  }
}