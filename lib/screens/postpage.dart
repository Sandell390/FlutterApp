// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/models/ColumnBoard.dart';
import 'package:firstapp/models/board.dart';
import 'package:firstapp/widgets/postWidget.dart';
import 'package:firstapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../models/Post.dart';
import '../widgets/listPostWidget.dart';

class PostPage extends StatelessWidget {
  PostPage({super.key, required this.board});

  final Board board;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final String? boardKey = board.key;
    final String boardName = board.title;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text(boardName),
      ),
      backgroundColor: const Color.fromARGB(255, 25, 27, 43),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref('columnboards/$boardKey').onValue,
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
            itemBuilder: (context, boardIndex) => Container(
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
                            columnBoard.columns[boardIndex],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              NewPostDialog(
                                boardKey: boardKey!,
                                columnBoard: columnBoard,
                                index: boardIndex,
                              ).PostDialog(context);
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
                    child: listPostWidget(
                        boardIndex: boardIndex,
                        boardKey: boardKey!,
                        columnBoard: columnBoard),
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
