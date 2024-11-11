import 'package:flutter/material.dart';
import 'Pages/register_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie review App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Movie Review App')),
        body: const SignInPage(),
      ),
    );
  }
}