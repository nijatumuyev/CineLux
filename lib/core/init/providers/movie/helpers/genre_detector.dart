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
import '../../../model/movie_model.dart';

genreDetectorGetMovies(String genre, WidgetRef ref, int index) {
  if (genre == LocaleKeys.genresMovies_Liked.locale()) {
    return ref.read(likeMovieServiceProvider.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Popular.locale()) {
    return ref.read(popularNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_TopRated.locale()) {
    return ref.read(topRatedNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_NowPlaying.locale()) {
    return ref.read(nowPlayingNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Upcoming.locale()) {
    return ref.read(upcomingNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Action.locale()) {
    return ref.read(actionNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Adventure.locale()) {
    return ref.read(adventureNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Animation.locale()) {
    return ref.read(animationNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Comedy.locale()) {
    return ref.read(comedyNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Crime.locale()) {
    return ref.read(crimeNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Documentary.locale()) {
    return ref.read(documentaryNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Drama.locale()) {
    return ref.read(dramaNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Family.locale()) {
    return ref.read(familyNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Fantasy.locale()) {
    return ref.read(fantasyNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_History.locale()) {
    return ref.read(historyNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Horror.locale()) {
    return ref.read(horrorNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Music.locale()) {
    return ref.read(musicNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Mystery.locale()) {
    return ref.read(mysteryNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Romance.locale()) {
    return ref.read(romanceNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_SciFi.locale()) {
    return ref.read(sciFiNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_TVMovie.locale()) {
    return ref.read(tvMovieNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_Thriller.locale()) {
    return ref.read(thrillerNotifier.notifier).getMovies();
  } else if (genre == LocaleKeys.genresMovies_War.locale()) {
    return ref.read(warNotifier.notifier).getMovies();
  } else {
    return ref.read(westernNotifier.notifier).getMovies();
  }
}

Future<List<Movie>?> genreDetectorFetchMovies(String genre, WidgetRef ref) {
  if (genre == LocaleKeys.genresMovies_Liked.locale()) {
    return ref.read(likeMovieServiceProvider.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Popular.locale()) {
    return ref.read(popularNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_TopRated.locale()) {
    return ref.read(topRatedNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_NowPlaying.locale()) {
    return ref.read(nowPlayingNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Upcoming.locale()) {
    return ref.read(upcomingNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Action.locale()) {
    return ref.read(actionNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Adventure.locale()) {
    return ref.read(adventureNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Animation.locale()) {
    return ref.read(animationNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Comedy.locale()) {
    return ref.read(comedyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Crime.locale()) {
    return ref.read(crimeNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Documentary.locale()) {
    return ref.read(documentaryNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Drama.locale()) {
    return ref.read(dramaNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Family.locale()) {
    return ref.read(familyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Fantasy.locale()) {
    return ref.read(fantasyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_History.locale()) {
    return ref.read(historyNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Horror.locale()) {
    return ref.read(horrorNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Music.locale()) {
    return ref.read(musicNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Mystery.locale()) {
    return ref.read(mysteryNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Romance.locale()) {
    return ref.read(romanceNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_SciFi.locale()) {
    return ref.read(sciFiNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_TVMovie.locale()) {
    return ref.read(tvMovieNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_Thriller.locale()) {
    return ref.read(thrillerNotifier.notifier).fetchMovies();
  } else if (genre == LocaleKeys.genresMovies_War.locale()) {
    return ref.read(warNotifier.notifier).fetchMovies();
  } else {
    return ref.read(westernNotifier.notifier).fetchMovies();
  }
}

genreDetectorHandleScroll(String genre, WidgetRef ref, int index) {
  if (genre == LocaleKeys.genresMovies_Liked.locale()) {
    return ref
        .read(likeMovieServiceProvider.notifier)
        .handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Popular.locale()) {
    return ref.read(popularNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_TopRated.locale()) {
    return ref.read(topRatedNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_NowPlaying.locale()) {
    return ref.read(nowPlayingNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Upcoming.locale()) {
    return ref.read(upcomingNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Action.locale()) {
    return ref.read(actionNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Adventure.locale()) {
    return ref.read(adventureNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Animation.locale()) {
    return ref.read(animationNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Comedy.locale()) {
    return ref.read(comedyNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Crime.locale()) {
    return ref.read(crimeNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Documentary.locale()) {
    return ref.read(documentaryNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Drama.locale()) {
    return ref.read(dramaNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Family.locale()) {
    return ref.read(familyNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Fantasy.locale()) {
    return ref.read(fantasyNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_History.locale()) {
    return ref.read(historyNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Horror.locale()) {
    return ref.read(horrorNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Music.locale()) {
    return ref.read(musicNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Mystery.locale()) {
    return ref.read(mysteryNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Romance.locale()) {
    return ref.read(romanceNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_SciFi.locale()) {
    return ref.read(sciFiNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_TVMovie.locale()) {
    return ref.read(tvMovieNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_Thriller.locale()) {
    return ref.read(thrillerNotifier.notifier).handleScrollWithIndex(index);
  } else if (genre == LocaleKeys.genresMovies_War.locale()) {
    return ref.read(warNotifier.notifier).handleScrollWithIndex(index);
  } else {
    return ref.read(westernNotifier.notifier).handleScrollWithIndex(index);
  }
}

genreDetectorWatch(String genre, WidgetRef ref) {
  if (genre == LocaleKeys.genresMovies_Liked.locale()) {
    return ref.watch(likeMovieServiceProvider);
  } else if (genre == LocaleKeys.genresMovies_Popular.locale()) {
    return ref.watch(popularNotifier);
  } else if (genre == LocaleKeys.genresMovies_TopRated.locale()) {
    return ref.watch(topRatedNotifier);
  } else if (genre == LocaleKeys.genresMovies_NowPlaying.locale()) {
    return ref.watch(nowPlayingNotifier);
  } else if (genre == LocaleKeys.genresMovies_Upcoming.locale()) {
    return ref.watch(upcomingNotifier);
  } else if (genre == LocaleKeys.genresMovies_Action.locale()) {
    return ref.watch(actionNotifier);
  } else if (genre == LocaleKeys.genresMovies_Adventure.locale()) {
    return ref.watch(adventureNotifier);
  } else if (genre == LocaleKeys.genresMovies_Animation.locale()) {
    return ref.watch(animationNotifier);
  } else if (genre == LocaleKeys.genresMovies_Comedy.locale()) {
    return ref.watch(comedyNotifier);
  } else if (genre == LocaleKeys.genresMovies_Crime.locale()) {
    return ref.watch(crimeNotifier);
  } else if (genre == LocaleKeys.genresMovies_Documentary.locale()) {
    return ref.watch(documentaryNotifier);
  } else if (genre == LocaleKeys.genresMovies_Drama.locale()) {
    return ref.watch(dramaNotifier);
  } else if (genre == LocaleKeys.genresMovies_Family.locale()) {
    return ref.watch(familyNotifier);
  } else if (genre == LocaleKeys.genresMovies_Fantasy.locale()) {
    return ref.watch(fantasyNotifier);
  } else if (genre == LocaleKeys.genresMovies_History.locale()) {
    return ref.watch(historyNotifier);
  } else if (genre == LocaleKeys.genresMovies_Horror.locale()) {
    return ref.watch(horrorNotifier);
  } else if (genre == LocaleKeys.genresMovies_Music.locale()) {
    return ref.watch(musicNotifier);
  } else if (genre == LocaleKeys.genresMovies_Mystery.locale()) {
    return ref.watch(mysteryNotifier);
  } else if (genre == LocaleKeys.genresMovies_Romance.locale()) {
    return ref.watch(romanceNotifier);
  } else if (genre == LocaleKeys.genresMovies_SciFi.locale()) {
    return ref.watch(sciFiNotifier);
  } else if (genre == LocaleKeys.genresMovies_TVMovie.locale()) {
    return ref.watch(tvMovieNotifier);
  } else if (genre == LocaleKeys.genresMovies_Thriller.locale()) {
    return ref.watch(thrillerNotifier);
  } else if (genre == LocaleKeys.genresMovies_War.locale()) {
    return ref.watch(warNotifier);
  } else {
    return ref.watch(westernNotifier);
  }
}
