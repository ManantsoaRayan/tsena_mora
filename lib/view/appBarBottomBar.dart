import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarBottomBar {

  PreferredSizeWidget appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0XFFFF7A7A),
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
      color: Color(0XFFFF7A7A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.list, color: Colors.white,)),
          IconButton(onPressed: (){Navigator.pushNamed(context, '/home');}, icon: Icon(Icons.home, color: Colors.white)),
          IconButton(onPressed: (){}, icon: Icon(Icons.chat, color: Colors.white)),
          IconButton(onPressed: (){Navigator.pushNamed(context, '/login');}, icon: Icon(Icons.logout, color: Colors.white))
        ],
      ),
    );
  }
}