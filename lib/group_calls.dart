
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<http.Response> updateUser (String uid, String url, groupName) async {

  Map data = {

    'group_name': groupName

  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.patch('http://$url/users/$uid',
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}


Future<http.Response> createGroup (String uid, String url, groupName, String name) async {


  Map data = {
    'host_id': uid,
    'group_name': groupName,
    'host_name': name
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post('http://$url/groups',
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return updateUser(uid, url, groupName);

  // print("${response.statusCode}");
  // print("${response.body}");
  // return response;
}

Future<http.Response> fetchCurrentGroup (String groupName, String url) async {

  Map data = {
    'group_name': groupName,
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.get('http://$url/groups/$groupName',
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return updateUser(uid, url, groupName);
}
