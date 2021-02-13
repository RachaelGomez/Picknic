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
        )
      ]
      ),
    );
  }
}


