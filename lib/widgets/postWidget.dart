import 'package:firstapp/models/ColumnBoard.dart';
import 'package:firstapp/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'widgets.dart';

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.post, required this.removePostFunc});

  Post post;
  Function removePostFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Text(post.description)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.green,
                child: CircleAvatar(
                  backgroundImage: Image.network(post.creator.Avatar!).image,
                  radius: 15,
                ),
              ),
              Container(
                color: Colors.red,
                child: Text("${post.creator.Username}"),
              ),
            ],
          ),
          TextButton(
            onPressed: () => removePostFunc(context),
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
