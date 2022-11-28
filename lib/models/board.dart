import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Board {
  IconData? iconData;
  String? title;
  bool? isInString;
  num? left;
  num? done;
  bool? isLast;
  Board(
      {this.iconData,
      this.title,
      this.isInString,
      this.done,
      this.left,
      this.isLast = false});

  static List<Board> generateBoard() {
    return [
      Board(
          iconData: Icons.abc,
          title: 'Hej me123d dig',
          isInString: true,
          done: 144,
          left: 4),
      Board(
          iconData: Icons.abc_rounded,
          title: 'Hej m12441212ed dig',
          isInString: false,
          done: 10,
          left: 4),
      Board(
          iconData: Icons.zoom_in,
          title: 'Hej med 4676dig',
          isInString: false,
          done: 10,
          left: 4),
      Board(
          iconData: Icons.work_outline_rounded,
          title: 'Hej med 8586dig',
          isInString: false,
          done: 10,
          left: 4),
      Board(
          iconData: Icons.access_alarm,
          title: 'Hej me74889d dig',
          isInString: true,
          done: 10,
          left: 4),
      Board(
          iconData: Icons.accessible_outlined,
          title:
              'Hej med 078978diasjkdhaskfhaksjfhakjfhaskjfhaskfjhaskfjashfkjashfkjashfkasjfhkasjfhaskjfaskjfhasksfakssfhkasjfhaksfhasskfhaskfjhasskfjhaskfhakjfhaksjfhhkassjfhkasjfhaksjfhhaksfhkasg',
          isInString: false,
          done: 10,
          left: 4),
      Board(
          iconData: Icons.work,
          title: 'Hej med dig',
          isInString: true,
          done: 10,
          left: 4),
      Board(isLast: true),
    ];
  }
}
