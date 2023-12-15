import 'package:cinelux/core/components/widgets/bottom_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikedMoviesScreen extends ConsumerStatefulWidget {
  const LikedMoviesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LikedMoviesScreenState();
}

class _LikedMoviesScreenState extends ConsumerState<LikedMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 32, 43),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 12, 32, 48),
          systemNavigationBarColor: Color.fromARGB(255, 12, 32, 48),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 32, 48),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Liked Movies",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19.sp),
        ),
      ),
      body: const Column(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
