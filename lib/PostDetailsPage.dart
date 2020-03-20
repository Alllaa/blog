import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatefulWidget {
  DocumentSnapshot snapshot;

  PostDetails({this.snapshot});

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
        backgroundColor: Colors.green,
      ),
      body: Card(
        elevation: 10.0,
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(
                      widget.snapshot.data["title"][0],
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.snapshot.data["title"],
                    style: TextStyle(fontSize: 22, color: Colors.green),
                  ),

                ],
              ),
            ),
            SizedBox(height: 7,),
            Container(
              margin: EdgeInsets.all(1),
              child: Text(
                widget.snapshot.data["content"],
                style: TextStyle(
                  fontSize:18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
