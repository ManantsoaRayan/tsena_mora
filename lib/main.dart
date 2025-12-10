import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsena_mora/view/tsenMoraViewCategorie.dart';
import 'package:tsena_mora/view/tsenaMoraLogin.dart';
import 'package:tsena_mora/view/tsenaMoraRegistre.dart';
import 'package:tsena_mora/view/tsenaMoraViewDescription.dart';
import 'package:tsena_mora/view/tsenaMoraWelcome.dart';
import 'package:tsena_mora/viewModel/tsenaMoraViewModel.dart';
import 'package:tsena_mora/viewModel/viewModelCategorie.dart';
import 'package:tsena_mora/viewModel/viewModelDescription.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TsenaMoraViewModel(),),
        ChangeNotifierProvider(create: (_) => ViewModelCategorie()..fetchCategorie()),
        ChangeNotifierProvider(create: (_) => ViewModelDescription()..fetchDescription())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/login': (context) => const TsenaMoraLogin(),
          '/home': (context) => const TsenaMoraViewCategorie(),
          '/registre': (context) => const TsenaMoraRegistre(),
          '/tsenaMoraWelcome': (context) => TsenaMoraWelcome(),
          '/description': (context) => TsenaMoraViewDescription()
        },
        home: TsenaMoraWelcome(),
      )
    );
  }
}

