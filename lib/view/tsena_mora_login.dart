import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/view/app_colors.dart';
import 'package:tsena_mora/view/wave.dart';
import 'package:tsena_mora/viewModel/user_view_model.dart';

class TsenaMoraLogin extends StatefulWidget {
  const TsenaMoraLogin({super.key});

  @override
  State<TsenaMoraLogin> createState() => TsenaMoraViewState();
}

class TsenaMoraViewState extends State<TsenaMoraLogin> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final tsenaMoraViewModel = Provider.of<TsenaMoraViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: const WaveHeader(color: AppColors.primary, height: 260),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Sing in",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

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
                      prefixIcon: Icon(Icons.account_circle_rounded),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.primary,
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        String userName = userController.text;
                        String password = passwordController.text;

                        if (userName.isEmpty || password.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Echec de connection'),
                                content: const Text(
                                  'Veuilleze remplire tous les champs',
                                ),
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

                        bool userExists = tsenaMoraViewModel.authenticateUser(
                          userName,
                          password,
                        );
                        if (userExists) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/home',
                            arguments: userName,
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Echec de connection'),
                                content: const Text(
                                  'Nom d\'utilisateur pou mots de pass incorecte',
                                ),
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

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registre');
                        },
                        child: Text(
                          "Sing up?",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
