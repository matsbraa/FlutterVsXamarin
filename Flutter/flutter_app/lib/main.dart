import 'package:flutter/material.dart';
import 'package:flutter_app/posts.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(primaryColor: Colors.white),
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(stops: [
            0,
            1
          ], colors: [
            Color.fromRGBO(255, 94, 98, 1),
            Color.fromRGBO(255, 153, 102, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  postButton(context)
                  ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )),
    );
  }

  CupertinoButton postButton(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(16),
      color: Colors.black,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Posts(posts: fetchPosts())),
        );
      },
      child: Text(
        'View Posts',
        style: TextStyle(
          color: Colors.white
        )
      )
    );
  }
}
