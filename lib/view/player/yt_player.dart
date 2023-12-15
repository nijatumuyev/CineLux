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
  // @override
  // void initState() {
  //   widget.controller!.addListener(() {
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //   super.initState();
  // }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller!.pause();
  }

  @override
  void dispose() {
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
            overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
      },
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
      },
      player: YoutubePlayer(
        thumbnail: Container(
          color: Colors.black,
          width: 1.sw,
          height: 1.sh,
        ),
        // thumbnail: CachedNetworkImage(imageUrl: movie.backdropPath!),
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
            bufferedColor: Colors.grey.shade700,
            handleColor: Colors.red,
            playedColor: Colors.red),
        controller: widget.controller!,
        actionsPadding: EdgeInsets.only(top: 20.h),
        topActions: [
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown
              ]);
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
              widget.controller!.pause();
              Get.back();
            },
            iconSize: 30.r,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 0,
          ),
          Expanded(
            child: Text(
              movie.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
        onEnded: (metaData) {
          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
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
