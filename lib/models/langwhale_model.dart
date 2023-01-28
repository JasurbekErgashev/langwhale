// To parse this JSON data, do
//
//     final langwhale = langwhaleFromJson(jsonString);

import 'dart:convert';

Map<String, Langwhale> langwhaleFromJson(String str) =>
    Map.from(json.decode(str))
        .map((k, v) => MapEntry<String, Langwhale>(k, Langwhale.fromJson(v)));

String langwhaleToJson(Map<String, Langwhale> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Langwhale {
  Langwhale({
    required this.title,
    required this.viewCount,
    required this.thumbnail,
    required this.duration,
    required this.categoryId,
    required this.id,
    required this.matchedStartTimes,
    required this.transcript,
  });

  String title;
  int viewCount;
  String thumbnail;
  int duration;
  int categoryId;
  String id;
  List<int> matchedStartTimes;
  Map<String, String> transcript;

  factory Langwhale.fromJson(Map<String, dynamic> json) => Langwhale(
        title: json["title"],
        viewCount: json["view_count"],
        thumbnail: json["thumbnail"],
        duration: json["duration"],
        categoryId: json["category_id"],
        id: json["id"],
        matchedStartTimes:
            List<int>.from(json["matched_start_times"].map((x) => x)),
        transcript: Map.from(json["transcript"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "view_count": viewCount,
        "thumbnail": thumbnail,
        "duration": duration,
        "category_id": categoryId,
        "id": id,
        "matched_start_times":
            List<dynamic>.from(matchedStartTimes.map((x) => x)),
        "transcript":
            Map.from(transcript).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
