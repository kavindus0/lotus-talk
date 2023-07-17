import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotustalk/widgets/bubbleWidgets.dart';
import 'package:lotustalk/screens/login_screen.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreenID';
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late String messageWannaSend;

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // Add code after super
    getCurrentUser();
  }

  Future<void> messageStream() async {
    await for (var snap in _firestore.collection('messages').snapshots()) {
      for (var msg in snap.docs) {
        print(msg.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.back),
        actions: <Widget>[
          IconButton(
              icon: const Icon(CupertinoIcons.arrow_swap),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        title: const Text('🇱🇰 Chat'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot<Object?>>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final message = snapshot.data?.docs.reversed;
                  List<Widget> messageWidget = [];
                  for (var msgs in message as Iterable<dynamic>) {
                    final dynamic msgText = msgs.data()?['text'];
                    final dynamic msgSender = msgs.data()?['sender'];
                    final dynamic currentUser = msgSender;
                    final dynamic msgWidget0;
                    if (currentUser == loggedInUser.email.toString()) {
                      msgWidget0 =
                          messageBubble(msgSender: msgSender, msgText: msgText);
                    } else {
                      msgWidget0 = messageBubble2(
                          msgSender: msgSender, msgText: msgText);
                    }
                    messageWidget.add(msgWidget0);
                  }

                  return Expanded(
                      child: ListView(
                          reverse: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          children: messageWidget));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        messageWannaSend = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messageWannaSend,
                        'sender': loggedInUser.email
                      });

                      setState(() {
                        textEditingController.clear();
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
