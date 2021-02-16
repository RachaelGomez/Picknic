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

Future<String> fetchRestaurant (restaurantName) async {
  Restaurant list;
  String link = 'http://localhost:3000/restaurants/restaurant_details?restaurant_name=$restaurantName';




  var response = await http
      .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
  print(response.body);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    // var rest = data['restaurant'] as List;
    // print(rest);
    // list = rest.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
    list = Restaurant.fromJson(data);
    print(list.yelpId);
  }



  print("${response.statusCode}");
  print("${response.body}");

  return list.yelpId;
}


Future<http.Response> createDetails (yelpId) async {

  Map data = {
    'yelp_id': await yelpId,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post('http://localhost:3000/details',
      headers: {"Content-Type": "application/json"},
      body: body
  );


  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

