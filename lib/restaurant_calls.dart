import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<http.Response> fetchRestaurantList (String url, String groupName) async {
  Map data = {
    'group_name': groupName,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.get('http://localhost:3000/groups/$groupName',
    headers: {"Content-Type": "application/json"},
  );


  print("${response.statusCode}");
  print("${response.body}");

  return response;
}

