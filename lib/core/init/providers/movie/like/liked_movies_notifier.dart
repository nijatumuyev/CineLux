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

  CollectionReference<Movie> getCollection() {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("likedMovies")
        .withConverter(fromFirestore: (snapshot, _) {
      return Movie.fromJson(
        snapshot.data()!,
      );
    }, toFirestore: (model, _) {
      return model.toJson();
    });
    return collection;
  }

  Future<List<Movie>?> fetchMovies([int page = 1]) async {
    var querySnapshot = await getCollection().get();
    List<Movie> likedMovies = [];
    for (var element in querySnapshot.docs) {
      likedMovies.add(element.data());
    }

    for (Movie movie in likedMovies) {
      final String url =
          "https://api.themoviedb.org/3/movie/${movie.id}$apiKey&language=$langCode";
      try {
        final res = await Dio().get(url);
        if (res.statusCode == 200) {
          final json = res.data;
          Movie newMovie = Movie.fromJson(json);
          getCollection().doc(movie.id.toString()).set(newMovie);
        }
      } on MoviesException catch (e) {
        state = state.copyWith(errorMessage: e.message);
      }
    }

    querySnapshot = await getCollection().get();
    likedMovies = [];
    for (var element in querySnapshot.docs) {
      likedMovies.add(element.data());
    }

    return likedMovies;
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
    var findMovie =
        await getCollection().where("id", isEqualTo: movie.id).get();
    if (findMovie.docs.isEmpty) {
      return await getCollection().doc(movie.id.toString()).set(movie);
    } else {
      return await getCollection().doc(movie.id.toString()).delete();
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
