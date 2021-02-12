import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:picknic/first_screen.dart';


class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Group Created!'),
    actions: <Widget>[
    IconButton(
    icon: const Icon(Icons.home),
    onPressed: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) {
    return FirstScreen();
    },
    ),
    );
    },
    )
    ]
    ),

    );}
}

