import 'package:flutter/material.dart';

void main(){
  return runApp(MaterialApp(
    initialRoute: '/',
    routes:{
      '/': (context) => Login(),
      '/home': (context) => Home(),
      '/second':(context) => SubjectScreen(),

    }
    
  ));
}


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          left: true,
          right: true,
          top: true,
          bottom: true,
          minimum: const EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(decoration: const InputDecoration(hintText: "Email")),
                TextFormField(decoration: const InputDecoration(hintText: "password")),
                RaisedButton(onPressed: () => Navigator.pushNamed(context, '/home'), child: Text("Submit"))
              ],
            )
          ),
        )
      ) 
    );
  }
}


class SubjectScreen extends StatefulWidget {
  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {

  //static const routeName = '/second';
  
  @override
  Widget build(BuildContext context) {
    final Subject args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(args.name), centerTitle: true,),
      body: ListView(
        children: [
          Text(args.content),
          Image.asset("assets/test3.JPG")
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(onPressed: () => print("Add post"), label: Text("Add Post"), icon: Icon(Icons.add_a_photo),),
    );
  }
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  


  @override
  Widget build(BuildContext context) {

    


    return Scaffold(
      appBar: AppBar(
        title: Text("Solution challenge"),
        centerTitle: true
      ),
      body:
         ListView(
           children: [
           
            FlatButton(onPressed: () => Navigator.pushNamed(context, '/second', arguments: Subject("Science", "Science is great.")), child:  Image.asset("assets/test1.JPG")),
           
            FlatButton(onPressed: () => Navigator.pushNamed(context, '/second', arguments: Subject("Math", "Math is fun.")), child:  Image.asset("assets/test2.JPG"))
           ],
         ),

  floatingActionButton: FloatingActionButton.extended(onPressed: null, 
  label: Text("Add Post"),
  icon: Icon(Icons.add_a_photo_rounded)),
      
       
    );
  }
}


class Subject{
  final String name;
  final String content;

  Subject(this.name, this.content);
}