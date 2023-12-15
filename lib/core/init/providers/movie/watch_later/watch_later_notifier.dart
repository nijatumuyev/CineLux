import 'package:cinelux/core/init/model/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchLaterServiceNotifier extends StateNotifier<Movie?> {
  WatchLaterServiceNotifier() : super(null);

  CollectionReference<Movie> getCollection() {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("watchLater")
        .withConverter(fromFirestore: (snapshot, _) {
      return Movie.fromJson(
        snapshot.data()!,
      );
    }, toFirestore: (model, _) {
      return model.toJson();
    });
    return collection;
  }

  Future<void> addToWatchLater(Movie movie) async {
    var findMovie =
        await getCollection().where("id", isEqualTo: movie.id).get();
    if (findMovie.docs.isEmpty) {
      return await getCollection().doc(movie.id.toString()).set(movie);
    } else {
      return await getCollection().doc(movie.id.toString()).delete();
    }
  }
}

final watchLaterStreamProvider =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  var stream = FirebaseFirestore.instance
      .collection("users")
      .doc(userUid)
      .collection("watchLater")
      .snapshots();
  return stream;
});

final watchLaterServiceProvider =
    StateNotifierProvider<WatchLaterServiceNotifier, Movie?>(
        (ref) => WatchLaterServiceNotifier());
