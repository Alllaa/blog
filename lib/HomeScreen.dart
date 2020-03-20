import 'dart:async';

import 'package:blogusingfirestore/CustomDialog.dart';
import 'package:blogusingfirestore/PostDetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("Post");

  Color gradientStart = Colors.deepPurple[700];
  Color gradientEnd = Colors.deepPurple[500];

  passData(DocumentSnapshot snap)
  {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>PostDetails(snapshot: snap,)));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Blog App"),
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint("Search btn preesed"),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              debugPrint("add btn preesed");
              showDialog(
                context: context,
                builder:(BuildContext context) => CustomDialog(contx: context,),


              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Alaa Flutter Channel"),
              accountEmail: Text("Leraning android, flutter & coding"),
            ),
            ListTile(
              title: Text("First Option"),
              leading: Icon(
                Icons.cake,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text("Second Option"),
              leading: Icon(
                Icons.search,
                color: Colors.redAccent,
              ),
            ),
            ListTile(
              title: Text("Third Option"),
              leading: Icon(
                Icons.cached,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text("forth Option"),
              leading: Icon(
                Icons.menu,
                color: Colors.green,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            ListTile(
              title: Text("Close"),
              trailing: Icon(
                Icons.close,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0, 1.0],
          ),
        ),
        child: ListView.builder(
          itemCount: snapshot.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.0,
              color: Colors.transparent.withOpacity(0.1),
              margin: EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: Text(
                        snapshot[index].data["title"][0],
                      ),
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Container(
                      width: 210,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              snapshot[index].data["title"],
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                            ),
                            onTap: ()
                            {
                              passData(snapshot[index]);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot[index].data["content"],
                            style: TextStyle(fontSize: 14,
                            color: Colors.white70),
                            maxLines: 2,
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
