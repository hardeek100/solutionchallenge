import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solution Challenge"),
        centerTitle: true,
      ),
      body: Column(children: [
        Center(
          child: Text("This is the home page of the app."),
        )
      ],)
    );
  }
}