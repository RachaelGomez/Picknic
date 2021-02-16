import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:picknic/models/restaurant.dart';

Future<http.Response> fetchRestaurantList () async {

  var response = await http.get('http://localhost:3000/restaurants/',
    headers: {"Content-Type": "application/json"},
  );


  print("${response.statusCode}");
  print("${response.body}");

  return response;
}

Future<List<Restaurant>> fetchRestaurant (restaurantName) async {
  List<Restaurant> list;




  var response = await http.get('http://localhost:3000/restaurants/restaurant_details?restaurant_name=$restaurantName',
      headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var rest = data["restaurant"] as List;
    print(rest);
    list = rest.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
  }



  print("${response.statusCode}");
  print("${response.body}");

  return list;
}

String getYelpId(restaurantName) {
  Future<http.Response> details = fetchRestaurant(restaurantName);
  String yelpId = details["yelp_id"]
}

