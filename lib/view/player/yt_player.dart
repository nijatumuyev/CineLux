import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/init/model/movie_model.dart';

class YTPlayer extends ConsumerStatefulWidget {
  final Movie? movie;
  final YoutubePlayerController? controller;
  const YTPlayer({required this.movie, required this.controller, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _YTPlayerState();
}

class _YTPlayerState extends ConsumerState<YTPlayer> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: false,
    ));
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller!.pause();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(255, 12, 32, 48),
    ));
    widget.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie!;
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);
      },
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
      },
      player: YoutubePlayer(
        thumbnail: CachedNetworkImage(imageUrl: movie.backdropPath!),
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
            bufferedColor: Colors.grey.shade700,
            handleColor: Colors.red,
            playedColor: Colors.red),
        controller: widget.controller!,
        actionsPadding: EdgeInsets.only(top: 20.h),
        topActions: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              movie.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
        onEnded: (metaData) {
          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            systemNavigationBarColor: Color.fromARGB(255, 12, 32, 48),
          ));
          Get.back();
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Center(
            child: SizedBox(height: 0.90.sh, child: player),
          )),
        );
      },
    );
  }
}
