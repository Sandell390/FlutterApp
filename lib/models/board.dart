import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Board {
  late int index;
  late String? key;
  late int iconData;
  late String title;
  late num left;
  late num done;
  late bool isLast;
  Board({
    this.key,
    required this.iconData,
    required this.title,
    required this.done,
    required this.left,
    this.isLast = false,
  });

  Board.fromJson(Map<String, dynamic> json, String _key) {
    title = json["title"];
    key = _key;
    left = json["left"];
    done = json["done"];
    isLast = false;
    iconData = json["iconData"] ?? Icons.abc.codePoint;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['done'] = done;
    data['left'] = left;
    data['isLast'] = false;
    data['iconData'] = iconData;
    return data;
  }
}
