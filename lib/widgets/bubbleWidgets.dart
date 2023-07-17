import 'package:flutter/material.dart';

class messageBubble extends StatelessWidget {
  const messageBubble({
    super.key,
    required this.msgSender,
    required this.msgText,
  });

  final String msgSender;
  final String msgText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            msgSender,
            style: const TextStyle(color: Colors.grey),
          ),
          Material(
            elevation: 5,
            color: Colors.blue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            //borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 9.0, horizontal: 18),
              child: Text(
                msgText,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class messageBubble2 extends StatelessWidget {
  const messageBubble2({
    super.key,
    required this.msgSender,
    required this.msgText,
  });

  final String msgSender;
  final String msgText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            msgSender,
            style: const TextStyle(color: Colors.grey),
          ),
          Material(
            elevation: 5,
            color: Colors.redAccent,
            borderRadius: const BorderRadius.only(
              //topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            //borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 9.0, horizontal: 18),
              child: Text(
                msgText,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
