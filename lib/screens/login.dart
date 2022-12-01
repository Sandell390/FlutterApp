import 'package:firstapp/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "Welcome to the best app ever made",
                style: GoogleFonts.openSans(
                    color: kTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: ElevatedButton(
                onPressed: () {
                  AuthService().signInWithGoogle();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => kButtonColor)),
                child: Text(
                  "Login in with Google",
                  style: GoogleFonts.openSans(
                      color: kTextButtonColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                  "When you login with google you agree to our Terms and service!",
                  style: GoogleFonts.openSans(
                      color: kTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
