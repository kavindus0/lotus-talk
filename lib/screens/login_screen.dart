import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lotustalk/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreenID';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _isLoading = false;
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
        extendBodyBehindAppBar: true,
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
        backgroundColor: const Color(0xFFFFFFFF),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Hero(
                    tag: 'Image',
                    child: SizedBox(
                      // height: 200.0,
                      child: Image.asset('images/720pic.png'),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
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
                        //Do something with the user input.
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2.0),
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
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
                        tag: 'logbut01',
                        child: Material(
                          color: Colors.lightBlueAccent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              _isLoading = true;
                              try {
                                var user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  _isLoading = false;
                                  Navigator.pushNamed(context, ChatScreen.id);
                                }
                              } catch (e) {
                                print(e);
                              }
                              //Implement login functionality.
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: const Text(
                              'Log In',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
