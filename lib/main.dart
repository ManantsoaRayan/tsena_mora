import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tsena_mora/view_models/user_view_model.dart';
import 'package:tsena_mora/view_models/product_view_model.dart';
import 'package:tsena_mora/views/home_view.dart';
import 'package:tsena_mora/views/login_view.dart';
import 'package:tsena_mora/views/register_view.dart';
import 'package:tsena_mora/views/welcome_view.dart';
import 'package:tsena_mora/views/favorites_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: MaterialApp(
        initialRoute: "/welcome",
        routes: {
          '/login': (context) => const LoginView(),
          '/register': (context) => const RegisterView(),
          '/welcome': (context) => const WelcomeView(),
          '/home': (context) => const HomeView(),
          '/favorites': (context) => const FavoritesView(),
        },
        home: HomeView(),
      ),
    );
  }
}
