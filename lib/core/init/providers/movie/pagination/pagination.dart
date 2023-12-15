import 'package:flutter/foundation.dart';
import '../../../model/movie_model.dart';

class Pagination {
  final List<Movie>? movies;
  final int? page;
  final String? errorMessage;

  Pagination({this.movies, this.page, this.errorMessage});

  Pagination.initial()
      : movies = [],
        errorMessage = "",
        page = 1;

  bool get refreshError => errorMessage != '' && movies!.length <= 20;
  Pagination copyWith({
    List<Movie>? movies,
    int? page,
    String? errorMessage,
  }) {
    return Pagination(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'Pagination(movies: $movies, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pagination &&
        listEquals(other.movies, movies) &&
        other.page == page &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => movies.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}
