import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Page'),
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (context, index) {
          return Container(
            height: 100,
            color: Colors.red,
          );
        }),
      ),
    );
  }
}
