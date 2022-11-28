import 'package:firstapp/constants/colors.dart';
import 'package:firstapp/constants/textStyles.dart';
import 'package:firstapp/models/board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Boards extends StatelessWidget {
  final boardList = Board.generateBoard();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: boardList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 5,
        crossAxisCount: 1,
      ),
      itemBuilder: (context, index) => boardList[index].isLast == true
          ? _buildAddBoard()
          : _buildBoard(context, boardList[index]),
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
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              board.iconData,
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
