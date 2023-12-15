import 'package:cinelux/core/constants/app/constants.dart';
import 'package:cinelux/core/init/model/movie_model.dart';
import 'package:cinelux/core/init/providers/movie/pagination/pagination.dart';
import 'package:cinelux/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pagination/movies_exception.dart';

class SciFiNotifier extends StateNotifier<Pagination> {
  SciFiNotifier([Pagination? state]) : super(state ?? Pagination.initial()) {
    getMovies();
  }

  Future<List<Movie>?> fetchMovies([int page = 1]) async {
    const String genre = "/discover/movie";

    final String url =
        "$baseUrl$genre$apiKey&with_genres=878&page=$page&language=$langCode";

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
    } on MoviesException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    }
    return [];
  }

  Future<void> getMovies() async {
    try {
      final movies = await fetchMovies(state.page!);

      state = state.copyWith(
          movies: [...?state.movies, ...?movies], page: state.page! + 1);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 20 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 20;

    if (requestMoreData && pageToRequest + 1 >= state.page!) {
      getMovies();
    }
  }

  Future<void> stateClear() async {
    state = Pagination.initial();
    await getMovies();
  }
}

final sciFiNotifier =
    StateNotifierProvider<SciFiNotifier, Pagination>((ref) => SciFiNotifier());
