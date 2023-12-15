// // ignore_forfile: public_member_api_docs, sort_constructors_first
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'package:cinelux/core/init/extensions/string_extensions.dart';
// import 'package:cinelux/core/init/language/locale_keys.g.dart';
// import 'package:cinelux/core/init/providers/providers.dart';
// import 'package:image_picker/image_picker.dart';

// import 'auth_listener.dart';

// User? user = FirebaseAuth.instance.currentUser;
// FirebaseStorage storage = FirebaseStorage.instance;
// final CollectionReference<Map<String, dynamic>> collection =
//     FirebaseFirestore.instance.collection('users');
// Reference profilePictureReference =
//     storage.ref().child("profilePictures/${user!.uid}");
// String time = DateTime.now().toString();
// File? xfile;

// //!Google sign in start
// signInWithGoogle({required BuildContext context}) async {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(
//             color: Color(0xfffe0000),
//           ),
//         );
//       });

//   //begin the interactive sign-in process
//   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
//   if (gUser != null) {
//     //obtain auth details from request
//     final GoogleSignInAuthentication gAuth = await gUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: gAuth.accessToken, idToken: gAuth.idToken);
//     //finally? lets sign in
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     UserMetadata metaData = FirebaseAuth.instance.currentUser!.metadata;
//     if (metaData.creationTime == metaData.lastSignInTime) {
//       createNewUserDB();
//     }
//     Future.delayed(const Duration(milliseconds: 500));
//     Get.back();
//     await GoogleSignIn().disconnect();
//     Get.off(const AuthListener());
//   } else {
//     Get.back();
//   }

//   //create a new credential for user
// }
// //!Google sign in end

// Future signUpWithEmailPassword(
//     {required String name,
//     required String email,
//     required String password,
//     required BuildContext context,
//     required WidgetRef ref}) async {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(
//             color: Color(0xfffe0000),
//           ),
//         );
//       });
//   final auth = FirebaseAuth.instance;

//   try {
//     await auth.createUserWithEmailAndPassword(email: email, password: password);
//     ref.read(signUpErrorProvider.notifier).update((state) => "");
//     ref.read(signUpSuccessProvider.notifier).update((state) => true);
//     final User user = auth.currentUser!;
//     await user.updateDisplayName(name);
//     await user.updatePhotoURL(
//         "https://cdn-icons-png.flaticon.com/512/6596/6596121.png");
//     createNewUserDB();
//     await auth.signInWithEmailAndPassword(email: email, password: password);
//   } on FirebaseAuthException catch (e) {
//     ref.read(signUpSuccessProvider.notifier).update((state) => false);
//     ref
//         .read(signUpErrorProvider.notifier)
//         .update((state) => LocaleKeys.authErrors_errorSignUp.locale());
//     debugPrint("Error: ${e.message}");
//   }

//   Future.delayed(const Duration(milliseconds: 500));
//   Get.back();
// }

// Future signInWithEmailAndPassword(
//     {required String email,
//     required String password,
//     required BuildContext context,
//     required WidgetRef ref}) async {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(
//             color: Color(0xfffe0000),
//           ),
//         );
//       });
//   final auth = FirebaseAuth.instance;
//   try {
//     await auth.signInWithEmailAndPassword(email: email, password: password);
//     ref.read(authErrorProvider.notifier).update((state) => "");
//     ref.read(signInSuccessProvider.notifier).update((state) => true);
//   } on FirebaseAuthException catch (e) {
//     debugPrint("Error: ${e.message}");
//     ref.read(signInSuccessProvider.notifier).update((state) => false);
//     ref
//         .read(authErrorProvider.notifier)
//         .update((state) => LocaleKeys.authErrors_errorLogin.locale());
//   }
//   Future.delayed(const Duration(milliseconds: 500));
//   Get.back();
// }

// Future logOut(BuildContext context) async {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(
//             color: Color(0xfffe0000),
//           ),
//         );
//       });

//   final auth = FirebaseAuth.instance;
//   try {
//     await Future.delayed(const Duration(milliseconds: 700))
//         .then((value) => auth.signOut());
//   } on FirebaseAuthException catch (e) {
//     debugPrint("Error: ${e.message}");
//   }
//   Get.back();
// }

// void createNewUserDB() {
//   collection.doc(user!.uid).set(
//     {
//       'id': user!.uid,
//       'email': user!.email,
//       'displayName': user!.displayName,
//       'photoUrl': user!.photoURL,
//       'signUpTime': user!.metadata.creationTime,
//       'bio': '',
//       'appPin': '',
//       'likedGenres': [],
//       'likedMovies': {},
//       'watchHistory': {},
//       'friends': {},
//     },
//     SetOptions(merge: true),
//   );
// }

// deleteProfile() async {
//   await FirebaseFirestore.instance
//       .collection("users")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .delete();
//   await FirebaseStorage.instance
//       .ref()
//       .child("profilePictures/${FirebaseAuth.instance.currentUser!.uid}")
//       .delete();
//   await FirebaseAuth.instance.currentUser!.delete();
// }

// updateProfile({
//   required String name,
//   required String bio,
//   required String email,
//   required BuildContext context,
//   required WidgetRef ref,
// }) async {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       });

//   try {
//     await user!.updateDisplayName(name);
//     await user!.updateEmail(email);
//     ref.read(authErrorProvider.notifier).update((state) => "");
//     await collection.doc(user!.uid).set(
//       {
//         "displayName": name,
//         "bio": bio,
//         "email": email,
//       },
//       SetOptions(merge: true),
//     );
//   } on FirebaseAuthException {
//     ref
//         .read(authErrorProvider.notifier)
//         .update((state) => LocaleKeys.validators_emailWrong.locale());
//   }
//   Get.back();
// }

// addWatchHistory() {
//   final time = DateTime.now().toString();
//   collection.doc(user!.uid).set(
//     {
//       "watchHistory": {"movieID": time}
//     },
//     SetOptions(merge: true),
//   );
// }

// addLikedMovies() {
//   collection.doc(user!.uid).set(
//     {
//       "likedMovies": {"movieID": time}
//     },
//     SetOptions(merge: true),
//   );
// }

// uploadImage(WidgetRef ref, StateProvider<bool> progresIndicator) async {
//   final image = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//     maxWidth: 512,
//     maxHeight: 512,
//     imageQuality: 75,
//   );

//   ref.read(progresIndicator.notifier).update((state) => !state);
//   if (image != null) {
//     xfile = File(image.path);
//   } else {
//     ref.read(progresIndicator.notifier).update((state) => !state);
//   }
//   if (xfile != null) {
//     await profilePictureReference.putFile(xfile!);
//     String fileUrl = await profilePictureReference.getDownloadURL();
//     try {
//       await collection.doc(user!.uid).update({'photoUrl': fileUrl});
//       await user!.updatePhotoURL(fileUrl);
//       ref.read(progresIndicator.notifier).update((state) => !state);
//     } catch (e) {
//       ref.read(progresIndicator.notifier).update((state) => !state);
//     }
//   } else {
//     ref.read(progresIndicator.notifier).update((state) => !state);
//   }
// }




// //!------------------------------------------------------------------



// // void themeModeSwitch() {
// //   User user = FirebaseAuth.instance.currentUser!;
// //   collection.doc(user.uid).update({'darkMode': false});
// // }

// // Future<bool> getThemeModeFromDB(WidgetRef ref) async {
// //   Query query = collection.where("id", isEqualTo: user.uid);
// //   QuerySnapshot querySnapshot = await query.get();
// //   final docData =
// //       querySnapshot.docs.map((doc) => doc.data()).map((e) => e as Map);
// //   bool mode = docData.toList()[0]["darkMode"];
// //   return mode;
// // }

//   // bool mode(Function getMode) async {
//   //   bool mode = await getThemeModeFromDB(userRef);
//   //   return mode;
//   // }

//   //!Parse JWT idToken into a Map
