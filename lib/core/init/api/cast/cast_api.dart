import 'package:cinelux/core/init/model/main_cast_model.dart';
import 'package:cinelux/core/init/providers/movie/pagination/movies_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/app/constants.dart';
import '../../model/cast_model.dart';

Future<List<Cast>?> getMovieCast(int movieId) async {
  final url =
      "https://api.themoviedb.org/3/movie/${movieId.toString()}/credits$apiKey";
  try {
    final res = await Dio().get(url);
    if (res.statusCode == 200) {
      List<Cast>? castList = CastModel.fromJson(res.data).castList;

      return castList;
    }
  } on MoviesException catch (e) {
    debugPrint(e.message);
  }
  return [];
}
