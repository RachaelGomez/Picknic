import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:picknic/first_screen.dart';
import 'package:picknic/screens/host_screen.dart';
import 'package:http/http.dart' as http;

class SwipeScreen extends StatefulWidget {
  final List restaurantIds;
  const SwipeScreen({Key key, this.restaurantIds}) : super(key: key);
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      appBar: AppBar(title: const Text('Start Swiping'), actions: <Widget>[
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
        ),
       ]
      ),
      body: new Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: new TinderSwapCard(
              cardBuilder: (context, index) => Card(
                child: Text(widget.restaurantIds[index]),
              ),
              totalNum: widget.restaurantIds.length,
              swipeUp: true,
              swipeDown: true,
              orientation: AmassOrientation.BOTTOM,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.width * 0.9,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.width * 0.8,
              cardController: controller = CardController(),
              swipeUpdateCallback:
                  (DragUpdateDetails details, Alignment align) {
                if (align.x < 0) {
                  print("card is swiping left");
                } else if (align.x > 0) {
                  print("card is swiping right");
                }
              }
          ),
        ),
      ),
    );
  }
  
}


