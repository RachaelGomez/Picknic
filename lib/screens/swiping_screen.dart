import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:picknic/first_screen.dart';
import 'package:picknic/screens/host_screen.dart';
import 'package:http/http.dart' as http;

class SwipeScreen extends StatefulWidget {
  final String currentGroup;
  const SwipeScreen({Key key, this.currentGroup}) : super(key: key);
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {

  List restaurants = [];
  List restaurantIds = [];


  @override
  void initState() {
    super.initState();
    this.fetchRestaurants(widget.currentGroup);
    //this.startDownloading();
  }

  fetchRestaurants(groupName) async {
    var url = "http://localhost:3000/groups/$groupName/restaurants";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        restaurants = items;
        print(restaurants);
      });
    } else {
      restaurants = [];
    }
    fetchRestaurantIds();
  }

  fetchRestaurantIds() async {
    for (int i=0; i < restaurants.length; i++) {
      restaurantIds.add(restaurants[i]['yelp_id']);
    }
    print(restaurantIds);
    return restaurantIds;
  }

  // void _addToList(List<dynamic> repoList) {
  //   if (mounted) {
  //     setState(() {
  //       _restaurantDetailsList.add(repoList);
  //     });
  //   }
  // }

  // Future<List<dynamic>> _fetchAndParse(String url) async {
  //   final response = await http.get(url);
  //   return json.decode(response.body);
  // }

  // void startDownloading() async {
  //   final String url = 'https://api.yelp.com/v3/businesses/';
  //
  //   restaurantIds.forEach((restaurant) {
  //     _fetchAndParse(url + restaurant).then(_addToList).catchError((err) {
  //       print('There was an error: $err');
  //     });
  //   });
  //   print(_restaurantDetailsList);
  // }




  // fetchRestaurantIds(currentGroup) async {
  //   await fetchRestaurants(widget.currentGroup);
  //   var restaurantYelpIds = <Map<String, dynamic>>[];
  //
  //   for (var restaurant in restaurants) {
  //     restaurantYelpIds.add(restaurant.yelp_id);
  //   }
  //   print(restaurantYelpIds);
  //   return restaurantYelpIds;
  // }


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
                child: Text(restaurantIds[index]),
              ),
              totalNum: restaurantIds.length,
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

  // Widget getTinderCard(item) {
  //   CardController controller;
  //   return TinderSwapCard(
  //       cardBuilder: (context, index) => Card(
  //         child: Text(restaurantIds[index]),
  //       ),
  //     totalNum: restaurantIds.length,
  //     swipeUp: true,
  //     swipeDown: true,
  //     orientation: AmassOrientation.BOTTOM,
  //     stackNum: 3,
  //     swipeEdge: 4.0,
  //     maxWidth: MediaQuery.of(context).size.width * 0.9,
  //     maxHeight: MediaQuery.of(context).size.width * 0.9,
  //     minWidth: MediaQuery.of(context).size.width * 0.8,
  //     minHeight: MediaQuery.of(context).size.width * 0.8,
  //     cardController: controller = CardController(),
  //     swipeUpdateCallback:
  //       (DragUpdateDetails details, Alignment align) {
  //         if (align.x < 0) {
  //           print("card is swiping left");
  //         } else if (align.x > 0) {
  //           print("card is swiping right");
  //         }
  //       }
  //   );
  // }

  // void _addToList(List<dynamic> repoList) {
  //   if (mounted) {
  //     setState(() {
  //       _restaurantDetailsList.add(repoList);
  //     });
  //   }
  //
  //   Future<List<dynamic>> _fetchAndParse(String url) async {
  //     final response = await http.get(url);
  //     return json.decode(response.body);
  //   }
  //
  //   void startDownloading() {
  //     final String url = 'https://api.yelp.com/v3/businesses/';
  //
  //     restaurants.forEach((restaurant) {
  //       _fetchAndParse(url + restaurant).then(_addToList).catchError((err) {
  //         print('There was an error: $err');
  //       });
  //     });
  //   }
}


