import 'package:firstapp/constants/textStyles.dart';
import 'package:firstapp/screens/boards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens.dart';
import '../constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      //primary: !isLandscape,
      appBar: AppBar(
        backgroundColor: kTopBarColor,
        actions: [
          IconButton(
            onPressed: () {
              print("object");
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: //const LoginPage(),
          Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/testavatar.png"),
              radius: 60,
            ),
            Text("Welcome [Name]!", style: defaultText),
            const Divider(
              color: Color.fromARGB(255, 120, 120, 120),
              height: 2,
              thickness: 1,
            ),
            Expanded(
              child: Boards(),
            ),
          ],
        ),
      ),
    );
  }
}
