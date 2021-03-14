import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          print(snapshot);
          return SomethingWentWrong();
        }
        if(snapshot.connectionState == ConnectionState.done){
          return _addpost(context);
        }

        return Loading();
      },
    );

  }

  Widget _addpost(BuildContext context){
     return Scaffold(
      appBar: AppBar(title: Text("Add new item"), centerTitle: true,),
      body: _addpostBody(context),
    );
  }

  Widget _addpostBody(BuildContext context){
    final firestoreInstance = FirebaseFirestore.instance;

    final title = TextEditingController();
    final content = TextEditingController();
    return Column(
      children: [
          TextField(
            controller: title,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Title"
            )
          ),
          TextField(
            controller: content,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "content"
            )
          ),

          ElevatedButton(onPressed: () => {
            firestoreInstance.collection("contents").add(
              {
                "title": title.text,
                "content": content.text,
              }
            ).then((val) => print(val.id))

          }, child: Text("Add"))
      ]);
  }

  Widget _uploadImage(BuildContext context){
    File _imageFile;
    final picker = ImagePicker();

    Future getImage() async{
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState((){
        if(pickedFile != null){
          _imageFile = File(pickedFile.path);
        }else{
          print("No image selected");
        }
      });
    }
  }

  // Future uploadImageToFirebase(BuildContext context) async{
  //   String fileName = basename(_imageFile.path);

  // }

  
}




class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Loading"),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Something went wrong")
    );
  }
}