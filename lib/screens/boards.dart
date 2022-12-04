import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/constants/colors.dart';
import 'package:firstapp/constants/textStyles.dart';
import 'package:firstapp/models/board.dart';
import 'package:firstapp/screens/postpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_database/firebase_database.dart';

class Boards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: FirebaseDatabase.instance.ref("boards").onValue,
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) return const Text('Loading...');
    //     List list = snapshot.data!.snapshot.children.toList();
    //     List<Board> boards = <Board>[];
    //     list.forEach((element) {
    //       Map<String, dynamic> map = {};
    //       element.children.forEach(
    //           (element1) => map[element1.key.toString()] = element1.value);
    //       boards.add(Board.fromJson(map, element.key));
    //     });

    // Map<String, dynamic> map = {};
    // snapshot.data!.snapshot.children
    //     .forEach((element) => map[element.key.toString()] = element.value);
    // print(map);
    // Board board1 = Board.fromJson(map);
    // print(board1.title);
    //print(list.first);
    return FutureBuilder(
        future: GetBoards(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading...");
          }

          return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 5,
                crossAxisCount: 1,
              ),
              itemBuilder: (context, index) =>
                  _buildBoard(context, snapshot.data![index]!));
          //   return GridView.builder(
          //   shrinkWrap: true,
          //   itemCount:
          //   gr: const SliverGridDelegateWithFixedCrossAxisCount(
          //     childAspectRatio: 5,
          //     crossAxisCount: 1,
          //   ),
          //   itemBuilder: (context, index) => _buildBoard(context, index),
          // );
        }));
    //},
    //);
  }

  Widget _buildAddBoard() {
    return Text(
      "Add Task",
      style: defaultText,
    );
  }

  Widget _buildBoard(BuildContext context, String boardID) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance.ref("boards/$boardID").onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading");
          print(snapshot.data!.snapshot.value);
          Map<String, dynamic> map = {};
          snapshot.data!.snapshot.children.forEach(
              (element1) => map[element1.key.toString()] = element1.value);
          Board board = Board.fromJson(map, boardID);

          return TextButton(
            style: TextButton.styleFrom(foregroundColor: kTextButtonColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostPage(board: board),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconData(board.iconData, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text(board.title!),
                    flex: 8,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 70,
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        child: Text("Left: " + board.left.toString()),
                      ),
                      Container(
                        width: 70,
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.amber,
                        ),
                        child: Text("Done: " + board.done.toString()),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<List<String?>> GetBoards() async {
    User user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/${user.uid}/boards').get();
    print(snapshot.children.first.key);
    if (snapshot.exists) {
      List<String?> list = <String>[];
      snapshot.children.forEach((element) {
        list.add(element.key);
      });
      return list;
    }
    return <String>[];
  }
}
