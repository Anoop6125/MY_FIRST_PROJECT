//please change the import packages according to your folder and file name
import 'package:flutter/material.dart';
import 'package:new_project/splash_screen.dart';
import'package:new_project/login_page.dart';
import 'package:new_project/movieapp.dart';     
                                                       
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: SplashScreen() , 
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => MovieScreen(),
      },
    );
  }
}
