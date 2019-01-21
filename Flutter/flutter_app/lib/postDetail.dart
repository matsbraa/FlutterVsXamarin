import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/posts.dart';

Future<Post> fetchPost(int id) async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/$id');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return parsePost(response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Post parsePost(String responseBody) {
  final parsed = json.decode(responseBody);

  return new Post.fromJson(parsed);
}

class PostDetail extends StatelessWidget {
  final Future<Post> post;

  PostDetail({this.post});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.hasData
                        ? PostDetailView(post: snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner
                  return CircularProgressIndicator();
                })),
      ),
    );
  }
}

class PostDetailView extends StatelessWidget {
  final Post post;

  PostDetailView({this.post});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(text: TextSpan(text: post.title, style: TextStyle(color: Colors.black)))
    );
  }
}
