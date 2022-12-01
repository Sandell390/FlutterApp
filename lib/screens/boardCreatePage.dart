import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstapp/models/ColumnBoard.dart';
import 'package:firstapp/models/board.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

const List<IconData> icons = [
  Icons.add_task,
  Icons.agriculture,
  Icons.wysiwyg,
  Icons.work_rounded,
  Icons.widgets,
  Icons.whatshot,
  Icons.wb_cloudy,
  Icons.android,
  Icons.article
];

class boardCreatePage extends StatefulWidget {
  boardCreatePage({super.key});

  State<boardCreatePage> createState() => _boardCreatePage();
}

class _boardCreatePage extends State<boardCreatePage> {
  TextEditingController titleController = TextEditingController();
  IconData iconData = icons.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giga nigga"),
      ),
      body: Column(
        children: [
          Text("Title: "),
          TextField(
            controller: titleController,
          ),
          DropdownButton(
            value: iconData,
            items: icons.map<DropdownMenuItem<IconData>>((IconData value) {
              return DropdownMenuItem<IconData>(
                value: value,
                child: Icon(value),
              );
            }).toList(),
            onChanged: (IconData? value) {
              // This is called when the user selects an item.
              setState(() {
                iconData = value!;
              });
            },
          ),
          TextButton(
              onPressed: () {
                final newPostKey =
                    FirebaseDatabase.instance.ref("boards").push().key;

                Board board = Board(
                    key: newPostKey!,
                    iconData: iconData.codePoint,
                    title: titleController.text,
                    done: 0,
                    left: 0);

                User user = FirebaseAuth.instance.currentUser!;

                final Map<String, Map> updates = {};
                updates['/boards/$newPostKey'] = board.toJson();
                updates['/columnboards/$newPostKey'] =
                    ColumnBoard.newBoard().toJson();

                FirebaseDatabase.instance.ref().update(updates);
                FirebaseDatabase.instance
                    .ref("/users/${user.uid}/boards/$newPostKey")
                    .set(true);
              },
              child: Text("Create"))
        ],
      ),
    );
  }
}
