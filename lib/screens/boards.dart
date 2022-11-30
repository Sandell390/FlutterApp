import 'dart:convert';

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
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref("boards").onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        List list = snapshot.data!.snapshot.children.toList();
        List<Board> boards = <Board>[];
        list.forEach((element) {
          Map<String, dynamic> map = {};
          element.children.forEach(
              (element1) => map[element1.key.toString()] = element1.value);
          boards.add(Board.fromJson(map, element.key));
        });

        // Map<String, dynamic> map = {};
        // snapshot.data!.snapshot.children
        //     .forEach((element) => map[element.key.toString()] = element.value);
        // print(map);
        // Board board1 = Board.fromJson(map);
        // print(board1.title);
        //print(list.first);
        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.snapshot.children.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 5,
            crossAxisCount: 1,
          ),
          itemBuilder: (context, index) => boards[index].isLast == true
              ? _buildAddBoard()
              : _buildBoard(context, boards[index]),
        );
      },
    );
  }

  Widget _buildAddBoard() {
    return Text(
      "Add Task",
      style: defaultText,
    );
  }

  Widget _buildBoard(BuildContext context, Board board) {
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
  }
}
