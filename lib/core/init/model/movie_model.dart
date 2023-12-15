import 'dart:math';

import 'package:cinelux/core/constants/app/constants.dart';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/language/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class Movie {
  int? id;
  bool? video;
  bool? adult;
  String? title;
  String? originalLanguage;
  String? backdropPath;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  double? voteAverage;
  int? voteCount;
  List<int> genreIds = [];
  List<String> genres = [];
  String genreView = "";

  Movie({
    required this.id,
    required this.video,
    required this.adult,
    required this.title,
    required this.originalLanguage,
    required this.backdropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    required this.genres,
    required this.genreView,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    video = json["video"];
    adult = json["adult"];
    title = json["title"];
    voteCount = json["vote_count"] + Random().nextInt(100);
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"] ?? "null";
    backdropPath =
        "https://image.tmdb.org/t/p/original/${json["backdrop_path"]}";
    posterPath = "https://image.tmdb.org/t/p/w500/${json["poster_path"]}";
    overview = json["overview"] ?? "null";
    releaseDate = json["release_date"] ?? "null";
    voteAverage =
        double.parse((json["vote_average"] ?? 0).toDouble().toStringAsFixed(1));
    late final int genreIdsLength;
    if (json["genre_ids"] != null) {
      genreIdsLength =
          json["genre_ids"].isNotEmpty ? json["genre_ids"].length : 0;
      for (int i = 0; i < genreIdsLength; i++) {
        genreIds.add(json["genre_ids"][i]);
      }
    } else {
      genreIdsLength = json["genres"].isNotEmpty ? json["genres"].length : 0;
      for (int i = 0; i < genreIdsLength; i++) {
        json["genres"][i].forEach((key, value) {
          if (key == "id") genreIds.add(value);
        });
      }
    }

    // final int genreIdsLength =
    //     json["genre_ids"].isNotEmpty ? json["genre_ids"].length : 0;
    // for (int i = 0; i < genreIdsLength; i++) {
    //   genreIds.add(json["genre_ids"][i]);
    // }
    genres = genreIdsLength != 0 ? genreConverter(genreIds) : [];
    for (int i = 0; i < genres.length; i++) {
      if (i == 0) {
        genreView = genres[i];
      } else {
        genreView = "$genreView, ${genres[i]}";
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> movieData = {};
    movieData['id'] = id;
    movieData['video'] = video;
    movieData['adult'] = adult;
    movieData['title'] = title;
    movieData['vote_count'] = voteCount;
    movieData['original_language'] = originalLanguage;
    movieData['original_title'] = originalTitle;
    movieData['backdrop_path'] = backdropPath;
    movieData['poster_path'] = posterPath;
    movieData["overview"] = overview;
    movieData["release_date"] = releaseDate;
    movieData["vote_average"] = voteAverage;
    movieData["genre_ids"] = genreIds;
    movieData["genres"] = genres;
    movieData["genre_view"] = genreView;
    return movieData;
  }

  Future<String> getVideoId(int movieId) async {
    const String baseUrl = "https://api.themoviedb.org/3/movie/";
    final String videoUrl = "$baseUrl$movieId/videos$apiKey&language=$langCode";
    try {
      final res = await Dio().get(videoUrl);
      if (res.statusCode == 200) {
        final Map<String, dynamic> data = res.data;
        final List results = data["results"];
        if (results.isNotEmpty) {
          final Iterable keyMap = results.map((e) => e["key"]);
          final String key = keyMap.toList()[0];
          return key;
        } else {
          return "";
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }

  List<String> genreConverter(List<int> genres) {
    List<String> genreNames = [];
    genreMap.forEach((key, value) {
      if (genres.contains(value)) {
        genreNames.add(key);
      }
    });
    return genreNames;
  }

  Map<String, dynamic> genreMap = {
    LocaleKeys.genreNames_Action.locale(): 28,
    LocaleKeys.genreNames_Adventure.locale(): 12,
    LocaleKeys.genreNames_Animation.locale(): 16,
    LocaleKeys.genreNames_Comedy.locale(): 35,
    LocaleKeys.genreNames_Crime.locale(): 80,
    LocaleKeys.genreNames_Documentary.locale(): 99,
    LocaleKeys.genreNames_Drama.locale(): 18,
    LocaleKeys.genreNames_Family.locale(): 10751,
    LocaleKeys.genreNames_Fantasy.locale(): 14,
    LocaleKeys.genreNames_History.locale(): 36,
    LocaleKeys.genreNames_Horror.locale(): 27,
    LocaleKeys.genreNames_Music.locale(): 10402,
    LocaleKeys.genreNames_Mystery.locale(): 9648,
    LocaleKeys.genreNames_Romance.locale(): 10749,
    LocaleKeys.genreNames_SciFi.locale(): 878,
    LocaleKeys.genreNames_TVMovie.locale(): 10770,
    LocaleKeys.genreNames_Thriller.locale(): 53,
    LocaleKeys.genreNames_War.locale(): 10752,
    LocaleKeys.genreNames_Western.locale(): 37,
  };
}
