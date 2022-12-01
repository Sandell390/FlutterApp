import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/models/ColumnBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Post.dart';
import '../models/User.dart';

class NewPostDialog extends StatelessWidget {
  NewPostDialog(
      {super.key,
      required this.columnBoard,
      required this.boardKey,
      required this.index});

  ColumnBoard columnBoard;
  int index;
  String boardKey;

  TextEditingController descriptionValue = TextEditingController();
  TextEditingController titleValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void PostDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            children: [
              Text("Title"),
              TextField(
                controller: titleValue,
              ),
              Text("Description"),
              TextField(
                controller: descriptionValue,
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  fba.User user = fba.FirebaseAuth.instance.currentUser!;

                  Post newpost = Post(
                      columnName: columnBoard.columns[index],
                      title: titleValue.text,
                      description: descriptionValue.text,
                      creator: User(
                          Username: user.displayName, Avatar: user.photoURL));
                  columnBoard.posts.add(newpost);
                  final Map<String, List<Map>> updates = {};
                  updates['columnboards/$boardKey/posts'] =
                      List<Map>.from(columnBoard.posts.map((e) => e.toJson()));
                  FirebaseDatabase.instance.ref().update(updates);

                  Navigator.of(context).pop();
                },
                child: Text("Save")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"))
          ],
        );
      },
    );
  }
}
