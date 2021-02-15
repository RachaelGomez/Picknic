// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Business businessFromJson(String str) => Business.fromJson(json.decode(str));

String businessToJson(Business data) => json.encode(data.toJson());

class Business {
  Business({
    this.id,
    this.alias,
    this.name,
    this.imageUrl,
    this.isClaimed,
    this.isClosed,
    this.url,
    this.phone,
    this.displayPhone,
    this.reviewCount,
    this.categories,
    this.rating,
    this.location,
    this.coordinates,
    this.photos,
    this.price,
    this.hours,
    this.transactions,
    this.specialHours,
  });

  String id;
  String alias;
  String name;
  String imageUrl;
  bool isClaimed;
  bool isClosed;
  String url;
  String phone;
  String displayPhone;
  int reviewCount;
  List<Category> categories;
  double rating;
  Location location;
  Coordinates coordinates;
  List<String> photos;
  String price;
  List<Hour> hours;
  List<dynamic> transactions;
  List<SpecialHour> specialHours;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["id"],
    alias: json["alias"],
    name: json["name"],
    imageUrl: json["image_url"],
    isClaimed: json["is_claimed"],
    isClosed: json["is_closed"],
    url: json["url"],
    phone: json["phone"],
    displayPhone: json["display_phone"],
    reviewCount: json["review_count"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    rating: json["rating"].toDouble(),
    location: Location.fromJson(json["location"]),
    coordinates: Coordinates.fromJson(json["coordinates"]),
    photos: List<String>.from(json["photos"].map((x) => x)),
    price: json["price"],
    hours: List<Hour>.from(json["hours"].map((x) => Hour.fromJson(x))),
    transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
    specialHours: List<SpecialHour>.from(json["special_hours"].map((x) => SpecialHour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "alias": alias,
    "name": name,
    "image_url": imageUrl,
    "is_claimed": isClaimed,
    "is_closed": isClosed,
    "url": url,
    "phone": phone,
    "display_phone": displayPhone,
    "review_count": reviewCount,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "rating": rating,
    "location": location.toJson(),
    "coordinates": coordinates.toJson(),
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "price": price,
    "hours": List<dynamic>.from(hours.map((x) => x.toJson())),
    "transactions": List<dynamic>.from(transactions.map((x) => x)),
    "special_hours": List<dynamic>.from(specialHours.map((x) => x.toJson())),
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

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Hour {
  Hour({
    this.open,
    this.hoursType,
    this.isOpenNow,
  });

  List<Open> open;
  String hoursType;
  bool isOpenNow;

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    open: List<Open>.from(json["open"].map((x) => Open.fromJson(x))),
    hoursType: json["hours_type"],
    isOpenNow: json["is_open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open": List<dynamic>.from(open.map((x) => x.toJson())),
    "hours_type": hoursType,
    "is_open_now": isOpenNow,
  };
}

class Open {
  Open({
    this.isOvernight,
    this.start,
    this.end,
    this.day,
  });

  bool isOvernight;
  String start;
  String end;
  int day;

  factory Open.fromJson(Map<String, dynamic> json) => Open(
    isOvernight: json["is_overnight"],
    start: json["start"],
    end: json["end"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "is_overnight": isOvernight,
    "start": start,
    "end": end,
    "day": day,
  };
}

class Location {
  Location({
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.zipCode,
    this.country,
    this.state,
    this.displayAddress,
    this.crossStreets,
  });

  String address1;
  String address2;
  String address3;
  String city;
  String zipCode;
  String country;
  String state;
  List<String> displayAddress;
  String crossStreets;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    address1: json["address1"],
    address2: json["address2"],
    address3: json["address3"],
    city: json["city"],
    zipCode: json["zip_code"],
    country: json["country"],
    state: json["state"],
    displayAddress: List<String>.from(json["display_address"].map((x) => x)),
    crossStreets: json["cross_streets"],
  );

  Map<String, dynamic> toJson() => {
    "address1": address1,
    "address2": address2,
    "address3": address3,
    "city": city,
    "zip_code": zipCode,
    "country": country,
    "state": state,
    "display_address": List<dynamic>.from(displayAddress.map((x) => x)),
    "cross_streets": crossStreets,
  };
}

class SpecialHour {
  SpecialHour({
    this.date,
    this.isClosed,
    this.start,
    this.end,
    this.isOvernight,
  });

  DateTime date;
  dynamic isClosed;
  String start;
  String end;
  bool isOvernight;

  factory SpecialHour.fromJson(Map<String, dynamic> json) => SpecialHour(
    date: DateTime.parse(json["date"]),
    isClosed: json["is_closed"],
    start: json["start"],
    end: json["end"],
    isOvernight: json["is_overnight"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "is_closed": isClosed,
    "start": start,
    "end": end,
    "is_overnight": isOvernight,
  };
}
