import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        children: [Text("Home"),
            Spacer(),
            IconButton(icon: Icon(Icons.logout) , onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');

            })
        ],
      ), centerTitle: true,),
      drawer: drawerBar(context),
      body: homeBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addpost');
        },
        child: Icon(Icons.add_circle),
      ),
    );
  }

  Widget drawerBar(BuildContext context){
    var contentTitles = ["Science", "Mathematics", "Fashion", "Arts", "Language", "Computer Science", "History"];
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Row(children: [
            Icon(Icons.book),
            Text("Subjects")
          ],)),
          Container(
            child: SingleChildScrollView(
              child: Column(children: 
                contentTitles.map((content) => ListTile(
                  title: Text(content),
                  onTap: () => Navigator.pushNamed(context, '/content', arguments: content),
                )).toList()
              ,),
            )
          )
        ],
      )
    );
  }

  Widget homeBody(BuildContext context){
    return buildCard(context);
  }

  
 Widget buildCard(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(alignment: Alignment.bottomLeft, children: [
                        Image.network('https://picsum.photos/250?image=9'),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("History"),
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("This is history class"),
                              Text("This is taught by Mr.Dang"),
                              Text("Please select the options below!"),
                            ]),
                      ),
                      ButtonBar(
                        //   alignment: MainAxisAlignment.center,
                        //   buttonHeight: 30,
                        //   buttonMinWidth: 40,
                        //   buttonPadding: EdgeInsets.all(10),
                        //   mainAxisSize: MainAxisSize.max,
                        //   overflowDirection: VerticalDirection.down,
                        //   overflowButtonSpacing: 10,

                        alignment:MainAxisAlignment.center,
                        buttonHeight:20,
                        buttonMinWidth:10,
                        buttonPadding: EdgeInsets.all(5.0),
                        mainAxisSize: MainAxisSize.max,
                        overflowDirection:VerticalDirection.down ,
                        overflowButtonSpacing:10,
                        children: <Widget>[
                          ElevatedButton(
                            child: Text("Upvote"),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                            child: Text("Reputation"),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                            child: Text("Request translate"),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                            child: Text("Share"),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
 }
}