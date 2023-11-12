import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  String activity;
  String type;
  double participants;
  double price;
  String link;
  String key;
  double accessibility;

  Post({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    activity: json["activity"],
    type: json["type"],
    participants: json["participants"],
    price: json["price"]?.toDouble(),
    link: json["link"],
    key: json["key"],
    accessibility: json["accessibility"],
  );

  Map<String, dynamic> toJson() => {
    "activity": activity,
    "type": type,
    "participants": participants,
    "price": price,
    "link": link,
    "key": key,
    "accessibility": accessibility,
  };
}
