import 'package:cinelux/core/constants/app/constants.dart';
import 'package:cinelux/core/init/model/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../main.dart';
import '../pagination/movies_exception.dart';
import '../pagination/pagination.dart';

class LikeMovieServiceNotifier extends StateNotifier<Pagination> {
  LikeMovieServiceNotifier([Pagination? state])
      : super(state ?? Pagination.initial()) {
    getMovies();
  }

  final collection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("likedMovies");

  Future<List<Movie>?> fetchMovies([int page = 1]) async {
    var querySnapshot = await collection.get();
    List<int> movieIds = [];
    for (var element in querySnapshot.docs) {
      movieIds.add(int.tryParse(element.id)!);
    }

    List<Movie>? movies = [];

    for (int id in movieIds) {
      final String url =
          "https://api.themoviedb.org/3/movie/$id$apiKey&language=$langCode";
      try {
        final res = await Dio().get(url);
        if (res.statusCode == 200) {
          final json = res.data;
          if (res.data != null) {
            Movie movie = Movie.fromJson(json);
            movies.add(movie);
          }
        }
      } on MoviesException catch (e) {
        state = state.copyWith(errorMessage: e.message);
      }
    }

    return movies;
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

  Future<void> likeMovie(Movie movie) async {
    var findMovie = await collection.where("id", isEqualTo: movie.id).get();
    if (findMovie.docs.isEmpty) {
      return await collection.doc(movie.id.toString()).set({"id": movie.id});
    } else {
      return await collection.doc(movie.id.toString()).delete();
    }
  }
}

final likeMovieStreamProvider =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  var stream = FirebaseFirestore.instance
      .collection("users")
      .doc(userUid)
      .collection("likedMovies")
      .snapshots();
  return stream;
});

final likeMovieServiceProvider =
    StateNotifierProvider<LikeMovieServiceNotifier, Pagination>(
        (ref) => LikeMovieServiceNotifier());
