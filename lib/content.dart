import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  
  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar:  AppBar(title: Text(name),),
      body: Text("Content body")
    );
  }
}