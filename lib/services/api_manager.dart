import 'package:http/http.dart' as http;
import 'package:picknic/constants/strings.dart';

class APiManager {
  void getRestaurants() async {
    var client = http.Client();

    var response = await client.get(Strings.searchUrl);
    if(response.statusCode == 200) {
      var jsonString = response.body;

    }
  }
}