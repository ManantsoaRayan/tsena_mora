import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/view/wave.dart';
//import 'package:tsena_mora/view/tsenMoraView.dart';
import 'package:tsena_mora/viewModel/tsenaMoraViewModel.dart';

class TsenaMoraLogin extends StatefulWidget{
  const TsenaMoraLogin({super.key});

  @override
  State<TsenaMoraLogin> createState() => TsenaMoraViewState();
}

class TsenaMoraViewState extends State<TsenaMoraLogin>{

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context){

    final tsenaMoraViewModel = Provider.of<TsenaMoraViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Expanded(
            child: const WaveHeader(
              color: Color(0XFFFF7A7A),
              height: 260,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Sing in",
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle_rounded)
                    ),
                    
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
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
                        backgroundColor: WidgetStateProperty.all(Color(0XFFFF7A7A)),
                        foregroundColor: WidgetStateProperty.all(Colors.white)
                      ),
                      onPressed: () {
                                    
                        String userName = userController.text;
                        String password = passwordController.text;
                    
                        bool userExists = tsenaMoraViewModel.authenticateUser(userName);
                        bool passwordExists = tsenaMoraViewModel.authenticatePassword(password);
                    
                        if (userExists && passwordExists) {
                          Navigator.pushReplacementNamed(context, '/home', arguments: userName);
                        }else{
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Login Failed'),
                                content: const Text('User namae or password incorrect'),
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
                      child: const Text('Login'),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have account?"),
                      TextButton(
                        onPressed:(){
                          Navigator.pushNamed(context, '/registre');
                        }, 
                        child: Text(
                          "Sing up?",
                          style: TextStyle(
                            color: Color(0XFFFF7A7A)
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
      )
    );
  }
}