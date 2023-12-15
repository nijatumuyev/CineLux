// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cinelux/core/init/extensions/string_extensions.dart';
import 'package:cinelux/core/init/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../language/locale_keys.g.dart';
import '../../providers/providers.dart';
import 'auth_listener.dart';

final userServiceProvider =
    StateNotifierProvider<UserServiceNotifier, UserModel?>(
        (ref) => UserServiceNotifier());

class UserServiceNotifier extends StateNotifier<UserModel?> {
  UserServiceNotifier() : super(null);

//! Get user document from firestore
  DocumentReference<UserModel> getUserDocument() {
    final userDocument = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter(fromFirestore: (snapshot, _) {
      return UserModel.fromJson(
        snapshot.data()!,
      );
    }, toFirestore: (model, _) {
      return model.toJson();
    });

    return userDocument;
  }

//!--------------------------------------------------------

  //! --- Get user from firestore
  Future<UserModel>? getUserData() async {
    var userSnapshot = await getUserDocument().get();
    UserModel? user = userSnapshot.data();
    return user!;
  }
  //! ----------------------------

  //!Google sign in start
  Future<void> signInWithGoogle({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xfffe0000),
            ),
          );
        });

    //begin the interactive sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser != null) {
      //obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      //finally? lets sign in
      await FirebaseAuth.instance.signInWithCredential(credential);

      var findUser = await FirebaseFirestore.instance
          .collection('users')
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (findUser.docs.isEmpty) {
        final UserModel user = UserModel(
          id: FirebaseAuth.instance.currentUser!.uid,
          displayName: FirebaseAuth.instance.currentUser!.displayName,
          email: FirebaseAuth.instance.currentUser!.email,
          bio: "",
          photoUrl: FirebaseAuth.instance.currentUser!.photoURL,
          appPin: "",
          signUpTime: FirebaseAuth.instance.currentUser!.metadata.creationTime,
        );

        addUserDetailsToFireStore(user);
      }

      final UserModel? newUser = await getUserData();
      state = newUser!;
      Get.back();
      await GoogleSignIn().disconnect();
      Get.off(const AuthListener());
    } else {
      Get.back();
    }

    //create a new credential for user
  }
//!Google sign in end

//! Sign up  with email and password
  Future<void> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xfffe0000),
            ),
          );
        });
    final auth = FirebaseAuth.instance;
    File photoFile = await getImageFileFromAssets();

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ref.read(signUpErrorProvider.notifier).update((state) => "");
      ref.read(signUpSuccessProvider.notifier).update((state) => true);

      Reference profilePictureReference = FirebaseStorage.instance
          .ref()
          .child("profilePictures/${auth.currentUser!.uid}");
      await profilePictureReference.putFile(photoFile);
      String photoURL = await profilePictureReference.getDownloadURL();
      await auth.currentUser!.updateDisplayName(name);
      await auth.currentUser!.updatePhotoURL(photoURL);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final UserModel user = UserModel(
        id: FirebaseAuth.instance.currentUser!.uid,
        displayName: FirebaseAuth.instance.currentUser!.displayName,
        email: FirebaseAuth.instance.currentUser!.email,
        bio: "",
        photoUrl: FirebaseAuth.instance.currentUser!.photoURL,
        appPin: "",
        signUpTime: FirebaseAuth.instance.currentUser!.metadata.creationTime,
      );

      addUserDetailsToFireStore(user);
      final UserModel? newUser = await getUserData();
      state = newUser!;
    } on FirebaseAuthException catch (e) {
      ref.read(signUpSuccessProvider.notifier).update((state) => false);
      ref
          .read(signUpErrorProvider.notifier)
          .update((state) => e.message.toString());
      debugPrint("Error: ${e.message}");
    }
    Get.back();
  }
//! --------------------------------

//! Sign in with email and password
  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xfffe0000),
            ),
          );
        });
    final auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final UserModel? user = await getUserData();
      state = user!;
      ref.read(authErrorProvider.notifier).update((state) => "");
      ref.read(signInSuccessProvider.notifier).update((state) => true);
    } on FirebaseAuthException catch (e) {
      debugPrint("Error: ${e.message}");
      ref.read(signInSuccessProvider.notifier).update((state) => false);
      ref
          .read(authErrorProvider.notifier)
          .update((state) => LocaleKeys.authErrors_errorLogin.locale());
    }
    Future.delayed(const Duration(milliseconds: 250));
    Get.back();
  }
//! -------------------------------

//! Log out
  Future<void> logOut(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xfffe0000),
            ),
          );
        });

    final auth = FirebaseAuth.instance;
    try {
      await Future.delayed(const Duration(milliseconds: 700))
          .then((value) => auth.signOut());
    } on FirebaseAuthException catch (e) {
      debugPrint("Error: ${e.message}");
    }
    Get.back();
  }
//! -------

//! Delete Account Permanently
  Future<void> deleteProfile(BuildContext context) async {
    await getUserDocument().delete();
    await FirebaseStorage.instance
        .ref()
        .child("profilePictures/${FirebaseAuth.instance.currentUser!.uid}")
        .delete();
    await FirebaseAuth.instance.currentUser!.delete();
    logOut(context);
  }
//! ----------------------------

//! Update Account
  Future<void> updateProfile({
    required String name,
    required String bio,
    required String email,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      ref.read(authErrorProvider.notifier).update((state) => "");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {
          "displayName": name,
          "bio": bio,
          "email": email,
        },
        SetOptions(merge: true),
      );
      final UserModel? user = await getUserData();
      state = user!;
    } on FirebaseAuthException {
      ref
          .read(authErrorProvider.notifier)
          .update((state) => LocaleKeys.validators_emailWrong.locale());
    }
    Get.back();
  }
//! --------------

//! Add user details to firestore
  Future<void> addUserDetailsToFireStore(UserModel user) async {
    await getUserDocument().set(
      user,
      SetOptions(merge: true),
    );
  }
//!------------------------------

//! Upload Image
  Future<void> uploadImage(
      WidgetRef ref, StateProvider<bool> progresIndicator) async {
    File? xfile;
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    ref.read(progresIndicator.notifier).update((state) => !state);
    if (image != null) {
      xfile = File(image.path);
    } else {
      ref.read(progresIndicator.notifier).update((state) => !state);
    }
    if (xfile != null) {
      Reference profilePictureReference = FirebaseStorage.instance
          .ref()
          .child("profilePictures/${FirebaseAuth.instance.currentUser!.uid}");
      await profilePictureReference.putFile(xfile);
      String fileUrl = await profilePictureReference.getDownloadURL();
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'photoUrl': fileUrl});
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(fileUrl);
        final UserModel? user = await getUserData();
        state = user!;
        ref.read(progresIndicator.notifier).update((state) => !state);
      } catch (e) {
        ref.read(progresIndicator.notifier).update((state) => !state);
      }
    } else {
      ref.read(progresIndicator.notifier).update((state) => !state);
    }
  }
//! ------------

//!----Get image file from assets
  Future<File> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/default-avatar.png');

    final file =
        File('${(await getTemporaryDirectory()).path}/default-avatar.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
//!------------------------------
}
