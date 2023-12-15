import 'package:flutter_riverpod/flutter_riverpod.dart';

//!Auth Providers Start
StateProvider<String> authErrorProvider = StateProvider<String>((ref) => "");
StateProvider<bool> signInSuccessProvider = StateProvider<bool>((ref) => false);
StateProvider<String> signUpErrorProvider = StateProvider<String>((ref) => "");
StateProvider<bool> signUpSuccessProvider = StateProvider<bool>((ref) => false);
//!Auth Providers End

// StateProvider<bool> uploadPictureProvider = StateProvider<bool>((ref) => false);
StateProvider<bool> isVideoPlaying = StateProvider<bool>((ref) => false);
