// ignore_for_file: use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotustalk/screens/chat_screen.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'regScreenID';
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.white,
        child: const SpinKitWaveSpinner(
          waveColor: Color(0xFF03B2A8),
          trackColor: Color(0xFFF863BB),
          color: Colors.purple,
          size: 100.0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.purple,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          // shadowColor: Colors.white,
          // foregroundColor: Colors.white,
          // surfaceTintColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: 'Image',
                  child: Image.asset('images/720pic.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                obscuringCharacter: '●',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Hero(
                  tag: 'regbut01',
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        // print('email: $email *** password: $password');
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          _isLoading = false;
                          Navigator.pushNamed(context, ChatScreen.id);
                        } catch (e) {
                          print(e);
                        }
                        //Implement registration functionality.
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
