import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/models/ColumnBoard.dart';
import 'package:firstapp/widgets/dragPostWidget.dart';
import 'package:firstapp/widgets/postWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../models/Post.dart';
import 'widgets.dart';

class listPostWidget extends StatelessWidget {
  listPostWidget(
      {super.key,
      required this.columnBoard,
      required this.boardIndex,
      required this.boardKey});

  ColumnBoard columnBoard;
  int boardIndex;
  String boardKey;

  void AcceptDrop(BuildContext context, Post data) {
    int indexPost = columnBoard.posts.indexWhere((element) => element == data);
    if (data.columnName == columnBoard.columns[boardIndex]) {
      return;
    }

    if (data.columnName != "Done") {
      FirebaseDatabase.instance
          .ref("columnboards/$boardKey/posts/$indexPost")
          .update({"columnName": columnBoard.columns[boardIndex]});
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text(
              "Are you sure that you want to move this post out of Done?"),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseDatabase.instance
                    .ref("columnboards/$boardKey/posts/$indexPost")
                    .update({"columnName": columnBoard.columns[boardIndex]});
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Post>(
      onAccept: (data) => AcceptDrop(context, data),
      builder: (context, candidateData, rejectedData) {
        FirebaseDatabase.instance.ref("boards/$boardKey/").update({
          "left": columnBoard.posts
              .where((element) => element.columnName != "Done")
              .length,
          "done": columnBoard.posts
              .where((element) => element.columnName == "Done")
              .length
        });
        return ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(
            columnBoard.posts.length,
            (postIndex) => columnBoard.columns[boardIndex] ==
                    columnBoard.posts[postIndex].columnName
                ? LongPressDraggable<Post>(
                    hapticFeedbackOnStart: true,
                    childWhenDragging: Container(),
                    data: columnBoard.posts[postIndex],
                    feedback: DragPostWidget(
                      post: columnBoard.posts[postIndex],
                    ),
                    child: PostWidget(
                      post: columnBoard.posts[postIndex],
                      removePostFunc: removePost,
                    ),
                  )
                : Container(),
          ),
        );
      },
    );
  }

  void removePost(context) {
    RemoePostDialog(
      columnBoard: columnBoard,
      index: boardIndex,
      boardKey: boardKey,
    ).PostDialog(context);
  }
}
