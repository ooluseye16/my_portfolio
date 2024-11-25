import 'package:flutter/material.dart';
import 'package:my_portfolio/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oluseye Obitola',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: false,
        fontFamily: 'Montserrat',
        // textTheme: GoogleFonts.latoTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      home: const HomePage(),
    );
  }
}
