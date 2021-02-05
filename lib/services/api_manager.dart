import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picknic/constants/strings.dart';
import 'package:picknic/models/yelp_info.dart';

class APiManager {
  Future<Welcome> getRestaurants() async {
    var client = http.Client();
    var welcomeModel = null;

    try {
      var response = await client.get(Strings.searchUrl);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        var welcomeModel = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return welcomeModel;
    }

    return welcomeModel;
  }
}