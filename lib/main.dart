import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/view/tsena_mora_view_categorie.dart';
import 'package:tsena_mora/view/tsena_mora_login.dart';
import 'package:tsena_mora/view/tsena_mora_registre.dart';
import 'package:tsena_mora/view/tsena_mora_view_product.dart';
import 'package:tsena_mora/view/tsena_mora_welcome.dart';
import 'package:tsena_mora/viewModel/user_view_model.dart';
import 'package:tsena_mora/viewModel/view_model_categorie.dart';
import 'package:tsena_mora/viewModel/view_model_product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TsenaMoraViewModel()),
        ChangeNotifierProvider(
          create: (_) => ViewModelCategorie()..fetchCategorie(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewModelProduct()..fetchDescription(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/login': (context) => const TsenaMoraLogin(),
          '/home': (context) => const TsenaMoraViewCategorie(),
          '/registre': (context) => const TsenaMoraRegistre(),
          '/tsenaMoraWelcome': (context) => TsenaMoraWelcome(),
          '/description': (context) => TsenaMoraViewDescription(),
        },
        home: TsenaMoraWelcome(),
      ),
    );
  }
}
