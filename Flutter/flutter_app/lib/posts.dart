import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app/postDetail.dart';

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return parsePosts(response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  public factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class Posts extends StatelessWidget {
  final Future<List<Post>> posts;

  Posts({this.posts});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.hasData
                    ? PostList(posts: snapshot.data)
                    : Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class PostList extends StatelessWidget {
  final List<Post> posts;

  PostList({this.posts});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return new GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostDetail(
                            post: fetchPost(index + 1),
                          )),
                ),
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(posts[index].id.toString()),
                        flex: 1,
                      ),
                      Expanded(
                        child: Text(posts[index].title),
                        flex: 9,
                      )
                    ],
                  )),
            ]));
      },
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.black),
    );
  }
}
