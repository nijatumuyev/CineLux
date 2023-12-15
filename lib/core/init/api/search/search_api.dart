import 'dart:async';
import 'package:cinelux/core/constants/app/constants.dart';
import 'package:cinelux/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/movie_model.dart';

FutureOr<Iterable<Movie?>> searchMovie(String query) async {
  String url =
      "https://api.themoviedb.org/3/search/movie$apiKey&query=${query.toLowerCase()}&language=$langCode";
  try {
    final res = await Dio().get(url);
    if (res.statusCode == 200) {
      List<Movie> results = [];

      for (int i = 0; i < res.data["results"].length; i++) {
        Movie movie = Movie.fromJson(res.data["results"][i]);
        results.add(movie);
      }

      return results;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return [];
}
