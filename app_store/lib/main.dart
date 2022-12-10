import 'package:ecomshop/pages/home_page.dart';
import 'package:ecomshop/pages/login_page.dart';
import 'package:ecomshop/pages/product_page.dart';
import 'package:ecomshop/pages/register_page.dart';
import 'package:ecomshop/utils/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _res = await SharedService.isLoggedIn();
  if (_res) {
    _defaultHome = const HomePage();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweet Cake',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => _defaultHome,
        '/login': (BuildContext context) => const LoginPage(),
        '/register': (BuildContext context) => const RegisterPage(),
        '/products': (BuildContext context) => const ProductsPage()
      },
    );
  }
}
