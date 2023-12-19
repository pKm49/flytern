import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoViewer extends StatefulWidget {
  const FullScreenVideoViewer({super.key});

  @override
  State<FullScreenVideoViewer> createState() => _FullScreenVideoViewerState();
}

class _FullScreenVideoViewerState extends State<FullScreenVideoViewer> {
  var getArguments = Get.arguments;
  String videoUrl = "";

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoUrl = getArguments[0];

    initializeVideo(videoUrl);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: screenwidth,
          height: screenheight,
          child: Column(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: screenwidth,
                    height: screenheight - (screenwidth * .15), 
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              Container(
                padding: flyternMediumPaddingAll.copyWith(bottom: 0, top: 0),
                margin: flyternLargePaddingVertical,
                height: screenwidth * .15,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Wrap the play or pause in a call to `setState`. This ensures the
                        // correct icon is shown.
                        setState(() {
                          // If the video is playing, pause it.
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            // If the video is paused, play it.
                            _controller.play();
                          }
                        });
                      },
                      // Display the correct icon depending on the state of the player.
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: screenwidth*.1,
                      ),
                    ),
                    addHorizontalSpace(flyternSpaceSmall),
                    Expanded(
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          backgroundColor: Colors.white,
                          // bufferedColor: Colors.yellow,
                          playedColor: flyternPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  initializeVideo(String videoUrl) {
    final Uri _url = Uri.parse(videoUrl!);

    _controller = VideoPlayerController.networkUrl(_url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _initializeVideoPlayerFuture.then((_) => setState(() {
          _controller.play();
        }));

    _controller.addListener(() {
      if (_controller.value.hasError) {
        print(_controller.value.errorDescription);
      }
    });
  }
}
