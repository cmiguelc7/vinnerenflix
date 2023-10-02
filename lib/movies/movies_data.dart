// To parse this JSON data, do
//
//     final responseData = responseDataFromJson(jsonString);

import 'dart:convert';

ResponseData responseDataFromJson(String str) =>
    ResponseData.fromJson(json.decode(str));

String responseDataToJson(ResponseData data) => json.encode(data.toJson());

class ResponseData {
  List<MoviesData> data;
  bool success;

  ResponseData({
    required this.data,
    required this.success,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        data: List<MoviesData>.from(
            json["data"].map((x) => MoviesData.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
      };
}

class MoviesData {
  List<Movie> movies;
  String category;

  MoviesData({
    required this.movies,
    required this.category,
  });

  factory MoviesData.fromJson(Map<String, dynamic> json) => MoviesData(
        movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
        category: json["category"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
        "category": category,
      };
}

class Movie {
  String plot;
  Type type;
  String year;
  String genre;
  String rated;
  String title;
  String actors;
  String awards;
  List<String> images;
  String poster;
  String writer;
  String imdbId;
  String country;
  String runtime;
  String director;
  String language;
  String released;
  Response response;
  String metascore;
  String imdbVotes;
  String imdbRating;
  String? totalSeasons;
  bool? comingSoon;

  Movie({
    required this.plot,
    required this.type,
    required this.year,
    required this.genre,
    required this.rated,
    required this.title,
    required this.actors,
    required this.awards,
    required this.images,
    required this.poster,
    required this.writer,
    required this.imdbId,
    required this.country,
    required this.runtime,
    required this.director,
    required this.language,
    required this.released,
    required this.response,
    required this.metascore,
    required this.imdbVotes,
    required this.imdbRating,
    this.totalSeasons,
    this.comingSoon,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        plot: json["Plot"],
        type: typeValues.map[json["Type"]]!,
        year: json["Year"],
        genre: json["Genre"],
        rated: json["Rated"],
        title: json["Title"],
        actors: json["Actors"],
        awards: json["Awards"],
        images: List<String>.from(json["Images"].map((x) => x)),
        poster: json["Poster"],
        writer: json["Writer"],
        imdbId: json["imdbID"],
        country: json["Country"],
        runtime: json["Runtime"],
        director: json["Director"],
        language: json["Language"],
        released: json["Released"],
        response: responseValues.map[json["Response"]]!,
        metascore: json["Metascore"],
        imdbVotes: json["imdbVotes"],
        imdbRating: json["imdbRating"],
        totalSeasons: json["totalSeasons"],
        comingSoon: json["ComingSoon"],
      );

  Map<String, dynamic> toJson() => {
        "Plot": plot,
        "Type": typeValues.reverse[type],
        "Year": year,
        "Genre": genre,
        "Rated": rated,
        "Title": title,
        "Actors": actors,
        "Awards": awards,
        "Images": List<dynamic>.from(images.map((x) => x)),
        "Poster": poster,
        "Writer": writer,
        "imdbID": imdbId,
        "Country": country,
        "Runtime": runtime,
        "Director": director,
        "Language": language,
        "Released": released,
        "Response": responseValues.reverse[response],
        "Metascore": metascore,
        "imdbVotes": imdbVotes,
        "imdbRating": imdbRating,
        "totalSeasons": totalSeasons,
        "ComingSoon": comingSoon,
      };
}

enum Response { TRUE }

final responseValues = EnumValues({"True": Response.TRUE});

enum Type { MOVIE, SERIES }

final typeValues = EnumValues({"movie": Type.MOVIE, "series": Type.SERIES});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
