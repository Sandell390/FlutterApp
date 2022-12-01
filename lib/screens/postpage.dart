// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/models/ColumnBoard.dart';
import 'package:firstapp/models/board.dart';
import 'package:firstapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../models/Post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.board});

  final Board board;

  @override
  State<PostPage> createState() => _PostPageState(board.key, board.title);
}

class _PostPageState extends State<PostPage> {
  _PostPageState(this.key, this.boardName);

  final ScrollController _scrollController = ScrollController();

  final String? key;
  final String boardName;

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text(boardName),
      ),
      backgroundColor: const Color.fromARGB(255, 25, 27, 43),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref('columnboards/$key').onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          print(snapshot.data!.snapshot.value);
          Map<String, dynamic> map = {};
          snapshot.data!.snapshot.children.forEach(
              (element1) => map[element1.key.toString()] = element1.value);
          ColumnBoard columnBoard = ColumnBoard.fromJson(map);

          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: columnBoard.columns.length,
            itemBuilder: (context, index1) => Container(
              width: isLandscape
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.width,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    width: 400,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 50,
                    //color: Colors.amber[600],
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            columnBoard.columns[index1],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                NewPostDialog(
                                  boardKey: key!,
                                  columnBoard: columnBoard,
                                  index: index1,
                                ).PostDialog(context);
                              });
                            },
                            child: const Icon(
                              size: 40,
                              Icons.playlist_add_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: isLandscape
                        ? MediaQuery.of(context).size.height / 1.9
                        : MediaQuery.of(context).size.height / 1.3,
                    child: DragTarget<Post>(
                      onAccept: (data) {
                        setState(() {
                          int indexPost = columnBoard.posts
                              .indexWhere((element) => element == data);
                          if (data.columnName == columnBoard.columns[index1]) {
                            return;
                          }

                          if (data.columnName != "Done") {
                            FirebaseDatabase.instance
                                .ref("columnboards/$key/posts/$indexPost")
                                .update({
                              "columnName": columnBoard.columns[index1]
                            });
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
                                          .ref(
                                              "columnboards/$key/posts/$indexPost")
                                          .update({
                                        "columnName":
                                            columnBoard.columns[index1]
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("Cancel"),
                                  ),
                                ]),
                          );
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        FirebaseDatabase.instance.ref("boards/$key/").update({
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
                            (index) => columnBoard.columns[index1] ==
                                    columnBoard.posts[index].columnName
                                ? LongPressDraggable<Post>(
                                    hapticFeedbackOnStart: true,
                                    childWhenDragging: Container(),
                                    data: columnBoard.posts[index],
                                    feedback: Container(
                                      width: 200,
                                      height: 100,
                                      color: Colors.amber[400],
                                      margin: const EdgeInsets.only(
                                          bottom: 10, left: 5, right: 5),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  columnBoard
                                                      .posts[index].description,
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      color: Colors.amber[400],
                                      margin: const EdgeInsets.only(
                                          bottom: 10, left: 5, right: 5),
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(columnBoard
                                                    .posts[index].description)),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                color: Colors.green,
                                                child: CircleAvatar(
                                                  backgroundImage:
                                                      Image.network(columnBoard
                                                              .posts[index]
                                                              .creator
                                                              .Avatar!)
                                                          .image,
                                                  radius: 15,
                                                ),
                                              ),
                                              Container(
                                                color: Colors.red,
                                                child: Text(
                                                    "${columnBoard.posts[index].creator.Username}"),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              RemoePostDialog(
                                                columnBoard: columnBoard,
                                                index: index,
                                                boardKey: key!,
                                              ).PostDialog(context);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
