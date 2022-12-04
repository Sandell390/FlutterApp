import 'package:firstapp/widgets/postWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/Post.dart';

class DragPostWidget extends StatelessWidget {
  DragPostWidget({super.key, required this.post});

  Post post;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      color: Colors.amber[400],
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            flex: 2,
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  post.description,
                  style: const TextStyle(fontSize: 10),
                )),
          ),
        ],
      ),
    );
  }
}
