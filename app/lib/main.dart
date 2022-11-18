import 'package:flutter/material.dart';
import 'package:wyld_card/presentation/main_page/index_main_page.dart';


// TODO: https://stackoverflow.com/questions/45235570/how-to-use-bottomnavigationbar-with-navigator
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: const IndexMainPage(),
    );
  }
}

