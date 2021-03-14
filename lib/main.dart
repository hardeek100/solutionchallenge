
import 'package:flutter/material.dart';
import 'package:onetest/addpost.dart';
import 'package:onetest/content.dart';
import 'package:onetest/home.dart';
import 'package:onetest/signin.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SignIn(),
      '/home' : (context) => Home(),
      '/content' : (context) => Content(),
      '/addpost': (context) => AddPost()
    }
  ));
}

