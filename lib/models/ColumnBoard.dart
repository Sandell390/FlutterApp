import 'dart:convert';

import 'package:firstapp/models/User.dart';

import 'Post.dart';

class ColumnBoard {
  late List<String> columns;
  late List<Post> posts;
  ColumnBoard({required this.columns, required this.posts});

  ColumnBoard.fromJson(Map<String, dynamic> json) {
    columns = List<String>.from(json["columns"].map((e) => e.toString()));
    if (json['posts'] == null) {
      posts = <Post>[];
    } else {
      print(json['posts']);
      //Map<String, dynamic> map = json.d
      List<dynamic> list = json['posts'] as List<dynamic>;
      print(list);
      posts = parsePosts(list);
      print(posts);
    }
  }

  List<Post> parsePosts(List response) {
    return response.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['columns'] = columns;
    data['posts'] = List<dynamic>.from(posts.map((e) => e.toJson()));
    return data;
  }

  ColumnBoard.newBoard() {
    columns = ["Todo", "Working on", "Done", "Quality Control", "Backlog"];
    posts = [];
  }

  static List<ColumnBoard> generateColumn() {
    return [
      ColumnBoard(
        columns: ["Todo", "Working on", "Done", "Quality Control"],
        posts: Post.generatePosts(),
      ),
      ColumnBoard(
        columns: ["Todo", "Working on", "Done", "Quality Control"],
        posts: Post.generatePosts(),
      ),
      ColumnBoard(
        columns: ["Todo", "Working on", "Done", "Quality Control"],
        posts: Post.generatePosts(),
      ),
    ];
  }
}
