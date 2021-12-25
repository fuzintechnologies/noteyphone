// To parse this JSON data, do
//
//     final allLink = allLinkFromJson(jsonString);

import 'dart:convert';

AllLink allLinkFromJson(String str) => AllLink.fromJson(json.decode(str));

String allLinkToJson(AllLink data) => json.encode(data.toJson());

class AllLink {
  AllLink({
    required this.links,
  });

  List<Link> links;

  factory AllLink.fromJson(Map<String, dynamic> json) => AllLink(
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Link {
  Link({
    required this.id,
    required this.description,
    required this.url,
  });

  String id;
  String description;
  String url;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["_id"],
        description: json["description"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "url": url,
      };
}
