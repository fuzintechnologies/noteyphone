// To parse this JSON data, do
//
//     final chapter = chapterFromJson(jsonString);

import 'dart:convert';

Chapter chapterFromJson(String str) => Chapter.fromJson(json.decode(str));

String chapterToJson(Chapter data) => json.encode(data.toJson());

class Chapter {
  Chapter({
    required this.count,
    required this.chapters,
  });

  int count;
  List<ChapterElement> chapters;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        count: json["count"],
        chapters: List<ChapterElement>.from(
            json["chapters"].map((x) => ChapterElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class ChapterElement {
  ChapterElement({
    required this.id,
    required this.name,
    required this.description,
    required this.links,
  });

  String id;
  String name;
  String description;
  List<String> links;

  factory ChapterElement.fromJson(Map<String, dynamic> json) => ChapterElement(
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
