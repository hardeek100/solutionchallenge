import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';





class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var contenttitles = ['Science', 'Mathematics', 'Fashion', 'Arts', 'Languages', 'Computer Science', 'History'];




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return SomethingWentWrong();
        }
        if(snapshot.connectionState == ConnectionState.done){
          return _homeBuilder(context);
        }

        return Loading();
      }
    );
  }

  Widget _homeBuilder(BuildContext context){
    final String name = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Welcome " + name), centerTitle: true,),
      body: _homebody(context),
      drawer: _drawerbar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addpost');
        },
        child: Icon(Icons.add_circle),
      ),
    );
  }


  Widget _drawerbar(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Contexts"),
          ),
          Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:
              contenttitles.map( (contenttitle) => new ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(contenttitle),
                onTap: () => Navigator.pushNamed(context, '/content', arguments: contenttitle),
              )).toList(),
          ),
        )
    )
        ],
      )
    );
  }

  Widget _homebody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('contents').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();
          return _homeList(context, snapshot.data.docs);
      }
    );
  }

  Widget _homeList(BuildContext context, List<DocumentSnapshot> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top: 20),
      children: snapshot.map((data) => _homeListItem(context, data)).toList(),
    );
  }

  Widget _homeListItem(BuildContext context, DocumentSnapshot data){
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(children: [
          Text(record.title, style: TextStyle(fontSize: 30),),
          Text(record.content),
          Image.asset(record.media),
          Text(record.views.toString()),

          Image.asset(record.media)
        ],)

        ),
      
    );

  }

}



class Record{
  final String title;
  final String content;
  final String media;
  final int views;
  final DocumentReference ref;

  Record.fromMap(Map<String, dynamic> map , {this.ref})
    :assert(map['title'] != null),
    assert(map['content'] != null),
    assert(map['media'] != null),
    assert(map['views'] != null),
    title = map['title'],
    media = map['content'],
    content = map['media'],
    views = map['views'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data(), ref: snapshot.reference);

  @override
  String toString() => "Record<$title:$content:$media>";
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