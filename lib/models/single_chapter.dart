// To parse this JSON data, do
//
//     final singlechapter = singlechapterFromJson(jsonString);

import 'dart:convert';

Singlechapter singlechapterFromJson(String str) =>
    Singlechapter.fromJson(json.decode(str));

String singlechapterToJson(Singlechapter data) => json.encode(data.toJson());

class Singlechapter {
  Singlechapter({
    required this.data,
  });

  Data data;

  factory Singlechapter.fromJson(Map<String, dynamic> json) => Singlechapter(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.description,
    required this.links,
  });

  String id;
  String name;
  String description;
  List<String> links;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        links: List<String>.from(json["links"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "links": List<dynamic>.from(links.map((x) => x)),
      };
}
