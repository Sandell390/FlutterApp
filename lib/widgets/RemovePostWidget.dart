import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/models/ColumnBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RemoePostDialog extends StatelessWidget {
  RemoePostDialog(
      {super.key,
      required this.columnBoard,
      required this.index,
      required this.boardKey});

  ColumnBoard columnBoard;
  int index;
  String boardKey;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  PostDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) => AlertDialog(
            elevation: 20,
            title: const Text("Do you want to delete this post?"),
            actions: [
              TextButton(
                onPressed: () {
                  print(index);
                  columnBoard.posts.removeAt(index);
                  final Map<String, List<Map>> updates = {};
                  updates['columnboards/$boardKey/posts'] =
                      List<Map>.from(columnBoard.posts.map((e) => e.toJson()));
                  FirebaseDatabase.instance.ref().update(updates);
                  print("Ja");
                  const snackBar = SnackBar(
                    content: Text('You just deleted a post'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  print("nej");
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
            ],
          )),
    );
  }
}
