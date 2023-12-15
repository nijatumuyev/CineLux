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
import 'package:cinelux/core/init/providers/movie/like/liked_movies_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../language/locale_keys.g.dart';

genreClear(String genre, WidgetRef ref) {
  if (genre == LocaleKeys.genresMovies_Liked.locale()) {
    return ref.read(likeMovieServiceProvider.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Popular.locale()) {
    return ref.read(popularNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_TopRated.locale()) {
    return ref.read(topRatedNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_NowPlaying.locale()) {
    return ref.read(nowPlayingNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Upcoming.locale()) {
    return ref.read(upcomingNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Action.locale()) {
    return ref.read(actionNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Adventure.locale()) {
    return ref.read(adventureNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Animation.locale()) {
    return ref.read(animationNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Comedy.locale()) {
    return ref.read(comedyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Crime.locale()) {
    return ref.read(crimeNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Documentary.locale()) {
    return ref.read(documentaryNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Drama.locale()) {
    return ref.read(dramaNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Family.locale()) {
    return ref.read(familyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Fantasy.locale()) {
    return ref.read(fantasyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_History.locale()) {
    return ref.read(historyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Horror.locale()) {
    return ref.read(horrorNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Music.locale()) {
    return ref.read(musicNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Mystery.locale()) {
    return ref.read(mysteryNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Romance.locale()) {
    return ref.read(romanceNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_SciFi.locale()) {
    return ref.read(sciFiNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_TVMovie.locale()) {
    return ref.read(tvMovieNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_Thriller.locale()) {
    return ref.read(thrillerNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genresMovies_War.locale()) {
    return ref.read(warNotifier.notifier).stateClear();
  } else {
    return ref.read(westernNotifier.notifier).stateClear();
  }
}

genreClearFromMovieScreen(String genre, WidgetRef ref) {
  if (genre == LocaleKeys.genreNames_Popular.locale()) {
    return ref.read(popularNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_TopRated.locale()) {
    return ref.read(topRatedNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_NowPlaying.locale()) {
    return ref.read(nowPlayingNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Upcoming.locale()) {
    return ref.read(upcomingNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Action.locale()) {
    return ref.read(actionNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Adventure.locale()) {
    return ref.read(adventureNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Animation.locale()) {
    return ref.read(animationNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Comedy.locale()) {
    return ref.read(comedyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Crime.locale()) {
    return ref.read(crimeNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Documentary.locale()) {
    return ref.read(documentaryNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Drama.locale()) {
    return ref.read(dramaNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Family.locale()) {
    return ref.read(familyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Fantasy.locale()) {
    return ref.read(fantasyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_History.locale()) {
    return ref.read(historyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Horror.locale()) {
    return ref.read(horrorNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Music.locale()) {
    return ref.read(musicNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Mystery.locale()) {
    return ref.read(mysteryNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Romance.locale()) {
    return ref.read(romanceNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_SciFi.locale()) {
    return ref.read(sciFiNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_TVMovie.locale()) {
    return ref.read(tvMovieNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Thriller.locale()) {
    return ref.read(thrillerNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_War.locale()) {
    return ref.read(warNotifier.notifier).stateClear();
  } else {
    return ref.read(westernNotifier.notifier).stateClear();
  }
}
