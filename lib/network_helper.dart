import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models.dart';

const url = "localhost:3000/groups";

class GetGroup {
  String getPath() {
    return url;
  }

  Future<List<Groups>> getGroups() async {
    final res = await http.get(getPath());

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((groups) => new Groups.fromJson(groups)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}