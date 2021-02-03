// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.total,
    this.businesses,
    this.region,
  });

  int total;
  List<Business> businesses;
  Region region;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    total: json["total"],
    businesses: List<Business>.from(json["businesses"].map((x) => Business.fromJson(x))),
    region: Region.fromJson(json["region"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
    "region": region.toJson(),
  };
}

class Business {
  Business({
    this.rating,
    this.price,
    this.phone,
    this.id,
    this.alias,
    this.isClosed,
    this.categories,
    this.reviewCount,
    this.name,
    this.url,
    this.coordinates,
    this.imageUrl,
    this.location,
    this.distance,
    this.transactions,
  });

  int rating;
  String price;
  String phone;
  String id;
  String alias;
  bool isClosed;
  List<Category> categories;
  int reviewCount;
  String name;
  String url;
  Center coordinates;
  String imageUrl;
  Location location;
  double distance;
  List<String> transactions;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    rating: json["rating"],
    price: json["price"],
    phone: json["phone"],
    id: json["id"],
    alias: json["alias"],
    isClosed: json["is_closed"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    reviewCount: json["review_count"],
    name: json["name"],
    url: json["url"],
    coordinates: Center.fromJson(json["coordinates"]),
    imageUrl: json["image_url"],
    location: Location.fromJson(json["location"]),
    distance: json["distance"].toDouble(),
    transactions: List<String>.from(json["transactions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "price": price,
    "phone": phone,
    "id": id,
    "alias": alias,
    "is_closed": isClosed,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "review_count": reviewCount,
    "name": name,
    "url": url,
    "coordinates": coordinates.toJson(),
    "image_url": imageUrl,
    "location": location.toJson(),
    "distance": distance,
    "transactions": List<dynamic>.from(transactions.map((x) => x)),
  };
}

class Category {
  Category({
    this.alias,
    this.title,
  });

  String alias;
  String title;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    alias: json["alias"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "alias": alias,
    "title": title,
  };
}

class Center {
  Center({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Center.fromJson(Map<String, dynamic> json) => Center(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Location {
  Location({
    this.city,
    this.country,
    this.address2,
    this.address3,
    this.state,
    this.address1,
    this.zipCode,
  });

  String city;
  String country;
  String address2;
  String address3;
  String state;
  String address1;
  String zipCode;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    city: json["city"],
    country: json["country"],
    address2: json["address2"],
    address3: json["address3"],
    state: json["state"],
    address1: json["address1"],
    zipCode: json["zip_code"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "address2": address2,
    "address3": address3,
    "state": state,
    "address1": address1,
    "zip_code": zipCode,
  };
}

class Region {
  Region({
    this.center,
  });

  Center center;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    center: Center.fromJson(json["center"]),
  );

  Map<String, dynamic> toJson() => {
    "center": center.toJson(),
  };
}
