// To parse this JSON data, do
//
//     final searchResponseData = searchResponseDataFromJson(jsonString);

import 'dart:convert';

import '../movies/movies_data.dart';

SearchResponseData searchResponseDataFromJson(String str) =>
    SearchResponseData.fromJson(json.decode(str));

String searchResponseDataToJson(SearchResponseData data) =>
    json.encode(data.toJson());

class SearchResponseData {
  List<MoviesData> data;
  bool success;

  SearchResponseData({
    required this.data,
    required this.success,
  });

  factory SearchResponseData.fromJson(Map<String, dynamic> json) =>
      SearchResponseData(
        data: List<MoviesData>.from(
            json["data"].map((x) => MoviesData.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
      };
}
