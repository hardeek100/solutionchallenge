import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignIn"),),
      body: _signInBody(context),
    );
  }

  Widget _signInBody(BuildContext context){
    final usernameCtr = TextEditingController();
    final passwordCtr = TextEditingController();
    return ListView(
      children: [
          TextField(
            controller: usernameCtr,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "User name"
            )
          ),
          TextField(
            controller: passwordCtr,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "password"
            )
          ),
          ElevatedButton(onPressed: (){
            if(usernameCtr.text == "hardik" && passwordCtr.text == "test123"){
              Navigator.pushReplacementNamed(context, '/home', arguments: usernameCtr.text);
            }else{
              passwordCtr.text = "";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("User not found. Please try again."),
                )
              );
            }
          }, child: Text("Submit"))
      ]
    );
  }
}