import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/auth_service.dart';
import 'package:firstapp/constants/textStyles.dart';
import 'package:firstapp/screens/boardCreatePage.dart';
import 'package:firstapp/screens/boards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'postpage.dart';
import 'screens.dart';
import '../constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  get board => null;

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
              AuthService().signOut();
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
            Row(children: [
              CircleAvatar(
                backgroundImage:
                    Image.network(FirebaseAuth.instance.currentUser!.photoURL!)
                        .image,
                radius: 60,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => boardCreatePage(),
                    ),
                  );
                },
                child: Icon(
                  size: 40,
                  Icons.playlist_add_outlined,
                ),
              ),
            ]),
            Text("Welcome ${FirebaseAuth.instance.currentUser!.displayName!}",
                style: defaultText),
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
