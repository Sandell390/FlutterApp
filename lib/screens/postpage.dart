import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/models/ColumnBoard.dart';
import 'package:firstapp/models/User.dart';
import 'package:firstapp/models/board.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Post.dart';

class PostPage extends StatefulWidget {
  PostPage({super.key, required this.board});

  final Board board;

  @override
  State<PostPage> createState() => _PostPageState(board.key);
}

class _PostPageState extends State<PostPage> {
  _PostPageState(this.key);

  ScrollController _scrollController = ScrollController();

  final String? key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("nig"),
      ),
      backgroundColor: Color.fromARGB(255, 25, 27, 43),
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
              width: MediaQuery.of(context).size.width,
              child: Expanded(
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
                                  Post newpost = Post(
                                      columnName: columnBoard.columns[index1],
                                      title: "Nigger",
                                      description: "Nigger has 2 apples",
                                      creator:
                                          User(Username: "hej", Avatar: "asd"));
                                  columnBoard.posts.add(newpost);
                                  final Map<String, List<Map>> updates = {};
                                  updates['columnboards/$key/posts'] =
                                      List<Map>.from(columnBoard.posts
                                          .map((e) => e.toJson()));
                                  FirebaseDatabase.instance
                                      .ref()
                                      .update(updates);
                                });
                              },
                              child: Icon(
                                size: 40,
                                Icons.playlist_add_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: DragTarget<Post>(
                        onAccept: (data) {
                          setState(() {
                            int indexPost = columnBoard.posts
                                .indexWhere((element) => element == data);

                            FirebaseDatabase.instance
                                .ref("columnboards/$key/posts/$indexPost")
                                .update({
                              "columnName": columnBoard.columns[index1]
                            });
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
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
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    columnBoard.posts[index]
                                                        .description,
                                                    style:
                                                        TextStyle(fontSize: 10),
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
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(columnBoard
                                                      .posts[index]
                                                      .description)),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: Colors.green,
                                                  child: Icon(Icons.abc),
                                                ),
                                                Container(
                                                  color: Colors.red,
                                                  child: Text(
                                                      "${columnBoard.posts[index].creator.Username}"),
                                                ),
                                              ],
                                            )
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
            ),
          );
        },
      ),
    );
  }
}
