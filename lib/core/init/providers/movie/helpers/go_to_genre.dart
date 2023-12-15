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
import 'package:cinelux/view/genre/genre_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../language/locale_keys.g.dart';

goToGenre(String genre, WidgetRef ref) async {
  late String genreMovies;
  if (genre == LocaleKeys.genreNames_Popular.locale()) {
    genreMovies = LocaleKeys.genresMovies_Popular.locale();
    ref.read(popularNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_TopRated.locale()) {
    genreMovies = LocaleKeys.genresMovies_TopRated.locale();
    ref.read(topRatedNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_NowPlaying.locale()) {
    genreMovies = LocaleKeys.genresMovies_NowPlaying.locale();
    ref.read(nowPlayingNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Upcoming.locale()) {
    genreMovies = LocaleKeys.genresMovies_Upcoming.locale();
    ref.read(upcomingNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Action.locale()) {
    genreMovies = LocaleKeys.genresMovies_Action.locale();
    ref.read(actionNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Adventure.locale()) {
    genreMovies = LocaleKeys.genresMovies_Adventure.locale();
    ref.read(adventureNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Animation.locale()) {
    genreMovies = LocaleKeys.genresMovies_Animation.locale();
    ref.read(animationNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Comedy.locale()) {
    genreMovies = LocaleKeys.genresMovies_Comedy.locale();
    ref.read(comedyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Crime.locale()) {
    genreMovies = LocaleKeys.genresMovies_Crime.locale();
    ref.read(crimeNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Documentary.locale()) {
    genreMovies = LocaleKeys.genresMovies_Documentary.locale();
    ref.read(documentaryNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Drama.locale()) {
    genreMovies = LocaleKeys.genresMovies_Drama.locale();
    ref.read(dramaNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Family.locale()) {
    genreMovies = LocaleKeys.genresMovies_Family.locale();
    ref.read(familyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Fantasy.locale()) {
    genreMovies = LocaleKeys.genresMovies_Fantasy.locale();
    ref.read(fantasyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_History.locale()) {
    genreMovies = LocaleKeys.genresMovies_History.locale();
    ref.read(historyNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Horror.locale()) {
    genreMovies = LocaleKeys.genresMovies_Horror.locale();
    ref.read(horrorNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Music.locale()) {
    genreMovies = LocaleKeys.genresMovies_Music.locale();
    ref.read(musicNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Mystery.locale()) {
    genreMovies = LocaleKeys.genresMovies_Mystery.locale();
    ref.read(mysteryNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Romance.locale()) {
    genreMovies = LocaleKeys.genresMovies_Romance.locale();
    ref.read(romanceNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_SciFi.locale()) {
    genreMovies = LocaleKeys.genresMovies_SciFi.locale();
    ref.read(sciFiNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_TVMovie.locale()) {
    genreMovies = LocaleKeys.genresMovies_TVMovie.locale();
    ref.read(tvMovieNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_Thriller.locale()) {
    genreMovies = LocaleKeys.genresMovies_Thriller.locale();
    ref.read(thrillerNotifier.notifier).stateClear();
  } else if (genre == LocaleKeys.genreNames_War.locale()) {
    genreMovies = LocaleKeys.genresMovies_War.locale();
    ref.read(warNotifier.notifier).stateClear();
  } else {
    genreMovies = LocaleKeys.genresMovies_Western.locale();
    ref.read(westernNotifier.notifier).stateClear();
  }

  return Get.to(GenreScreen(
    genre: genreMovies,
  ));
}
