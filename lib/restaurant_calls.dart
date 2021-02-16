import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:picknic/Models/business.dart';

const String API_KEY = '_iDM48sJ0J6NzjPXTGMaFm4wGc3mIWuSyBEtbAZ0IkwFlbwQ_g9mt3l9384Ng41dCpJbsK7-55u8vBvlZgCQb7qPE_xh2LMhatkeoq4cXLCK5KyHHhVOk52UtYcYYHYx';
const Map<String, String> AUTH_HEADER = {"Authorization": "Bearer $API_KEY"};

// Future<http.Response> fetchRestaurantList (String url, String groupName) async {
//   Map data = {
//     'group_name': groupName,
//   };
//   //encode Map to JSON
//   var body = json.encode(data);
//
//   var response = await http.get('http://localhost:3000/groups/$groupName',
//     headers: {"Content-Type": "application/json"},
//   );
//
//
//   print("${response.statusCode}");
//   print("${response.body}");
//
//   return response;
// };

// Future<Business> fetchBusiness(businessId) async {
//   final response = await http.get('https://api.yelp.com/v3/businesses/' + businessId, headers: AUTH_HEADER);
//
//   if (response.statusCode == 200) {
//     print(Business.fromJson(jsonDecode(response.body)));
//     return Business.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load business');
//   }
//
// }