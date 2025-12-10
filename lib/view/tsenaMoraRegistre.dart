import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/view/appColors.dart';
import 'package:tsena_mora/view/wave.dart';
import 'package:tsena_mora/viewModel/tsenaMoraViewModel.dart';

class TsenaMoraRegistre extends StatefulWidget{
  const TsenaMoraRegistre({super.key});

  @override
  State<TsenaMoraRegistre> createState() => TsenaMoraViewState();
}

class TsenaMoraViewState extends State<TsenaMoraRegistre>{
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    final tsenaMoraViewModel = Provider.of<TsenaMoraViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: WaveHeader(
              color: AppColors.primary,
              height: 260,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Sing up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),   
                ),

              ],
            ),
          ),
          
          SizedBox(height: 20,),
          
          Expanded(
            child: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle)
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password)
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(AppColors.primary),
                        foregroundColor: WidgetStateProperty.all(Colors.white)
                      ),
                      onPressed: () {
                        String userName = userController.text;
                        String password = passwordController.text;  
                        if(userName.isNotEmpty && password.isNotEmpty){
                          tsenaMoraViewModel.addUser(userName);
                          tsenaMoraViewModel.addPassword(password);
                          Navigator.pushNamed(
                            context, '/home',
                            arguments: userName
                          );
                        }else{
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Login Failed'),
                                content: const Text('Veuillez remlire tous les champ'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have a count?"),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/login');
                        }, 
                        child: Text(
                          "Sing in?",
                          style: TextStyle(
                            color: AppColors.primary
                          ),
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}