import 'package:flutter/material.dart';
import 'package:lotustalk/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lotustalk/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Hero(
                    tag: 'Image',
                    child: SizedBox(
                      height: 120.0,
                      child: Image.asset('images/720pic.png'),
                    ),
                  ),
                  Expanded(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 50.0,
                          //fontFamily: agni,
                          color: Color(0xFF060626)),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText('Lotus Talk'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MajorButtonWidget(
                heroTag: 'logbut01',
                inputText: 'Log In',
                pushID: LoginScreen.id),
            MajorButtonWidget(
              heroTag: 'regbut01',
              inputText: 'Register',
              pushID: RegistrationScreen.id,
            ),
          ],
        ),
      ),
    );
  }
}

class MajorButtonWidget extends StatelessWidget {
  late var heroTag;
  late var pushID;
  late var inputText;

  MajorButtonWidget({
    super.key,
    @required this.heroTag,
    @required this.pushID,
    @required this.inputText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Hero(
        tag: heroTag,
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 5.0,
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6110A7),
                  Color(0xFF5B027B)
                ], // Change the colors to fit your needs
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, pushID);
              },
              minWidth: 200.0,
              height: 42.0,
              child: Text(
                inputText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
