import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/providers/movie/categories/action_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/adventure_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/animation_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/comedy_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/crime_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/documentary_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/drama_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/family_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/fantasy_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/history_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/horror_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/music_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/mystery_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/now_playing_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/popular_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/romance_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/sci_fi_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/thriller_notification.dart';
import 'package:cinelux/core/init/providers/movie/categories/top_rated_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/tv_movie_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/upcoming_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/war_notifier.dart';
import 'package:cinelux/core/init/providers/movie/categories/western_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../language/locale_keys.g.dart';
import '../../../model/movie_model.dart';

Future<List<Movie>?> similarDetector(String genre, WidgetRef ref) {
  if (genre == LocaleKeys.genreNames_Popular.locale()) {
    ref.read(popularNotifier.notifier).stateClear();
    return ref.read(popularNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_TopRated.locale()) {
    ref.read(topRatedNotifier.notifier).stateClear();
    return ref.read(topRatedNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_NowPlaying.locale()) {
    ref.read(nowPlayingNotifier.notifier).stateClear();
    return ref.read(nowPlayingNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Upcoming.locale()) {
    ref.read(upcomingNotifier.notifier).stateClear();
    return ref.read(upcomingNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Action.locale()) {
    ref.read(actionNotifier.notifier).stateClear();
    return ref.read(actionNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Adventure.locale()) {
    ref.read(adventureNotifier.notifier).stateClear();
    return ref.read(adventureNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Animation.locale()) {
    ref.read(animationNotifier.notifier).stateClear();
    return ref.read(animationNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Comedy.locale()) {
    ref.read(comedyNotifier.notifier).stateClear();
    return ref.read(comedyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Crime.locale()) {
    ref.read(crimeNotifier.notifier).stateClear();
    return ref.read(crimeNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Documentary.locale()) {
    ref.read(documentaryNotifier.notifier).stateClear();
    return ref.read(documentaryNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Drama.locale()) {
    ref.read(dramaNotifier.notifier).stateClear();
    return ref.read(dramaNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Family.locale()) {
    ref.read(familyNotifier.notifier).stateClear();
    return ref.read(familyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Fantasy.locale()) {
    ref.read(fantasyNotifier.notifier).stateClear();
    return ref.read(fantasyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_History.locale()) {
    ref.read(historyNotifier.notifier).stateClear();
    return ref.read(historyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Horror.locale()) {
    ref.read(horrorNotifier.notifier).stateClear();
    return ref.read(horrorNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Music.locale()) {
    ref.read(musicNotifier.notifier).stateClear();
    return ref.read(musicNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Mystery.locale()) {
    ref.read(mysteryNotifier.notifier).stateClear();
    return ref.read(mysteryNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Romance.locale()) {
    ref.read(romanceNotifier.notifier).stateClear();
    return ref.read(romanceNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_SciFi.locale()) {
    ref.read(sciFiNotifier.notifier).stateClear();
    return ref.read(sciFiNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_TVMovie.locale()) {
    ref.read(tvMovieNotifier.notifier).stateClear();
    return ref.read(tvMovieNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_Thriller.locale()) {
    ref.read(thrillerNotifier.notifier).stateClear();
    return ref.read(thrillerNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genreNames_War.locale()) {
    ref.read(warNotifier.notifier).stateClear();
    return ref.read(warNotifier.notifier).fetchMovies();
  } else {
    ref.read(westernNotifier.notifier).stateClear();
    return ref.read(westernNotifier.notifier).fetchMovies();
  }
}
