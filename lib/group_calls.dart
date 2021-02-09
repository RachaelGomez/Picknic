
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


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
