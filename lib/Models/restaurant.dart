import 'dart:convert';

Restaurant restaurantFromJson(String str) => Restaurant.fromJson(json.decode(str));
String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant
{Restaurant({
  this.id,
  this.groupId,
  this.yelpId,
  this.restaurantName,

});

int id;
String restaurantName;
String yelpId;
int groupId;


factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
id: json["id"],
groupId: json["group_id"],
yelpId: json["yelp_id"],
restaurantName: json["restaurant_name"]
);

Map<String, dynamic> toJson() => {
"id": id,
  "group_id": groupId,
  "yelp_id": yelpId,
  "restaurant_name": restaurantName,
};
}