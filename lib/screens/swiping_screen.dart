import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:picknic/first_screen.dart';
import 'package:picknic/screens/host_screen.dart';
import 'package:http/http.dart' as http;
import 'package:picknic/Models/business.dart';

class SwipeScreen extends StatefulWidget {
  final List restaurants;
  const SwipeScreen({Key key, this.restaurants}) : super(key: key);
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  static const String API_KEY = '_iDM48sJ0J6NzjPXTGMaFm4wGc3mIWuSyBEtbAZ0IkwFlbwQ_g9mt3l9384Ng41dCpJbsK7-55u8vBvlZgCQb7qPE_xh2LMhatkeoq4cXLCK5KyHHhVOk52UtYcYYHYx';
  static const Map<String, String> AUTH_HEADER = {"Authorization": "Bearer $API_KEY"};

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      appBar: AppBar(title: Text('Start Swiping'), actions: <Widget>[
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
              cardBuilder: (context, index) => Container(
                alignment: Alignment.center,
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget> [
                        ListTile(
                          title: Text(
                              widget.restaurants[index]["restaurant_name"],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red)),
                        ),
                        Column(
                          children: <Widget> [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0)
                              ),
                              child: Image.network(
                                widget.restaurants[index]["image_url"],
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                                height: 50
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text('Categories:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    for (var aliasTitle in widget.restaurants[index]["categories"]) Text(aliasTitle["title"]),
                                  ],
                                ),
                                Column(
                                  children: <Widget> [
                                    for (var transaction in widget.restaurants[index]["transactions"]) Text(transaction.toUpperCase()),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ),
              totalNum: widget.restaurants.length,
              swipeUp: true,
              swipeDown: true,
              orientation: AmassOrientation.BOTTOM,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.width * 3.0,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.width * 0.8,
              cardController: controller = CardController(),
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {
                if (orientation == CardSwipeOrientation.LEFT) {
                  print("card is swiping left");
                } else if (orientation == CardSwipeOrientation.RIGHT) {
                  print("card is swiping right");
                }
              }
          ),
        ),
      ),
    );
  }



}


