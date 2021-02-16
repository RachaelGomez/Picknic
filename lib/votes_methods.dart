import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<http.Response> createVote (String uid, int restaurantId, bool isRight, String url) async {


  Map data = {
    "user_id": uid,
    "restaurant_id": restaurantId,
    "is_right": isRight
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post('http://$url/votes',
      headers: {"Content-Type": "application/json"},
      body: body
  );

  // String groupId = groupName['id'];

  // createRestaurants(url, groupId);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}