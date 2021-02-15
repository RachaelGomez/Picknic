import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<http.Response> fetchRestaurantList () async {

  var response = await http.get('http://localhost:3000/restaurants/',
    headers: {"Content-Type": "application/json"},
  );


  print("${response.statusCode}");
  print("${response.body}");

  return response;
}

