import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:picknic/first_screen.dart';
import 'package:picknic/screens/host_screen.dart';
import 'package:http/http.dart' as http;
import 'package:picknic/Models/business.dart';
import 'package:picknic/sign_in.dart';
import 'package:picknic/votes_methods.dart';

class SwipeScreen extends StatefulWidget {
  final List restaurants;
  const SwipeScreen({Key key, this.restaurants}) : super(key: key);
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int cardIndex = 0;

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
        heightFactor: MediaQuery.of(context).size.height,
        child: Container(
          child: new TinderSwapCard(
              cardBuilder: (context, index) => Container(
                height: double.infinity,
                alignment: Alignment.center,
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Wrap(
                      children: <Widget> [
                        ListTile(
                          title: Text(
                              widget.restaurants[index]["restaurant_name"],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red)),
                          subtitle: Text(
                            "${widget.restaurants[index]["address_1"]} ${widget.restaurants[index]["city"]}, ${widget.restaurants[index]["state"]} ${widget.restaurants[index]["zipcode"]}",
                          ),
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
                              height: 20
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('Categories:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    for (var aliasTitle in widget.restaurants[index]["categories"]) Text(aliasTitle["title"]),
                                  ],
                                ),
                                Column(
                                  children: <Widget> [
                                    Text("Dining Options:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    for (var transaction in widget.restaurants[index]["transactions"]) Text(transaction.toUpperCase()),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15
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
              minHeight: MediaQuery.of(context).size.width * 2.9,
              cardController: controller = CardController(),
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {
                if (orientation == CardSwipeOrientation.LEFT) {
                  print("card is swiping left");
                  createVote(uid, widget.restaurants[index]["id"], false, 'localhost:3000');
                  setState(() {
                    cardIndex += 1;
                  });
                } else if (orientation == CardSwipeOrientation.RIGHT) {
                  print("card is swiping right");
                  createVote(uid, widget.restaurants[index]["id"], true, 'localhost:3000');
                  setState(() {
                    cardIndex += 1;
                  });
                }
              }
          ),
        ),
      ),
    );
  }



}


