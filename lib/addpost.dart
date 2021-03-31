import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File image;
  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addPostBody(context)
    );
  }

  Widget addPostBody(BuildContext context){
    final title = TextEditingController();
    final content = TextEditingController();
    final String author = ModalRoute.of(context).settings.arguments;
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    final picker = ImagePicker();

    Future<void> getImage() async{
      final file = await picker.getImage(source: ImageSource.gallery);
      setState((){
        if(file != null){
          image = File(file.path);
        }else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("No Files picked")));
        }
      });
    }

    Future<void> uploadImage() async {
      try {
       
       var upload =  await firebase_storage.FirebaseStorage.instance
            .ref('assets/' + image.toString());
        firebase_storage.UploadTask task = upload.putFile(image);
        task.then((res){
          imageUrl = res.ref.getDownloadURL().toString();
        });
      } on firebase_core.FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Cannot upload file to cloud")));
      }
    }

    Future<void> addPost(){
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);

      return posts.add({
        'title' : title.text,
        'content' : content.text
      });
    }

    return SafeArea(
      child: 
      Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,

        children: [
          image == null ? Text("No image selected") : Image.file(image, width: 100, height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
            ElevatedButton.icon(onPressed: (){
                getImage();
            }, icon: Icon(Icons.select_all), label: Text("Select media"),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),)
            )
          ],),

         TextField(
          controller: title,
          obscureText: false,
          decoration: InputDecoration(
            icon: Icon(Icons.title_rounded),
            hintText: "Title",
            helperText: "Post Title",
            border: OutlineInputBorder(),
          ),
        ),

         
        TextField(
            controller: content,
            obscureText: false,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              icon: Icon(Icons.book),
              hintText: "Content",
              helperText: "Post Content",
              border: OutlineInputBorder(),
            ),
        ),
        

        ElevatedButton.icon(onPressed: (){
            uploadImage();
        }, icon: Icon(Icons.add), label: Text("Add Post"))
    ],),
      )
    );
     }
}