import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final BuildContext contx;

   CustomDialog({this.contx});

  final title = TextEditingController();
  final body = TextEditingController();
  final databaseReference = Firestore.instance;
  void createRecord(String title,String content) async {
//    await databaseReference.collection("Post")
//        .document("1")
//        .setData({
//      'title': title,
//      'content': content
//    });
    DocumentReference ref = await databaseReference.collection("Post")
        .add({
      'title': title,
      'content': content
    });
    print(ref.documentID);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
//          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                  margin: EdgeInsets.only(top:30),
                child: TextField(
                  onChanged: (text) {
                    print("First textfield $text");
                  },
                  controller: title,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Color(0xff38003D)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'title'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                  margin: EdgeInsets.only(top:30),
                child: TextField(
                  onChanged: (text) {
                    print("First textfield $body");
                  },
                  controller: body,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Color(0xff38003D)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'body'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          createRecord(title.text.toString(),body.text.toString());
                          Navigator.of(contx).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffb8bfbd)),
                          child: Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                    InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          print('Hello');
                          Navigator.of(contx).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffE90052)),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
