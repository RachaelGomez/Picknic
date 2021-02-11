import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<http.Response> createRestaurants (String url, groupId) async {
  Map data = {
    'id': groupId
  };

  var body = json.encode(data);

  var response = await http.post('http://$url/restaurants/create',
      headers: {'Content-Type': "application/json"},
      body: body
  );
  return response;
}