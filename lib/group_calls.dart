
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'group.dart';


Future<http.Response> createGroup (String uid, String url, groupName) async {


  Map data = {
    'host_id': uid,
    'group_name': groupName
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post('http://$url/groups',
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

Future<Group> fetchGroups () async {
  final response = await http.get('http://localhost:3000/groups');
  if (response.statusCode == 200) {
    return Group.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load groups');
  }
}