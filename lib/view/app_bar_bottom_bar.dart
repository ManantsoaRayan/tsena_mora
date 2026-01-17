import 'package:flutter/material.dart';
import 'package:tsena_mora/view/app_colors.dart';

class AppBarBottomBar {

  PreferredSizeWidget appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.textLight,
      title: const Text(
        'Tsena Mora',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black
        ),
      ),
      centerTitle: true,
    );
  }

  Widget bottomBar(BuildContext context){
    return BottomAppBar(
      height: 50,
      color: AppColors.textLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.list, color: Colors.black, )),
          IconButton(onPressed: (){}, icon: Icon(Icons.chat, color: Colors.black)),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/home'), icon: Icon(Icons.home, color: Colors.black)),

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
            icon: Icon(Icons.logout_rounded, color: Colors.black)
          ),
        ],
      ),
    );
  }
}