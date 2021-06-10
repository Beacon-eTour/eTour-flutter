import 'package:eTour_flutter/global/etour_button.dart';
import 'package:eTour_flutter/global/etour_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class VideoPage extends StatefulWidget {
  final String? introVideoUrl;

  const VideoPage({Key? key, this.introVideoUrl}) : super(key: key);
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController? _yController;
  VideoPlayerController? _vController;
  var videoUrl;
  late var isYoutubeVideo;

  @override
  void initState() {
    super.initState();
    videoUrl = widget.introVideoUrl;
    if (videoUrl.contains('youtube')) {
      isYoutubeVideo = true;
      videoUrl = YoutubePlayerController.convertUrlToId(videoUrl);

      _yController = YoutubePlayerController(
        initialVideoId: videoUrl,
        params: YoutubePlayerParams(
          showControls: false,
          showFullscreenButton: true,
        ),
      );
    } else {
      isYoutubeVideo = false;
      _vController = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {
            //_vController.play();
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isYoutubeVideo
              ? YoutubeValueBuilder(
                  controller: _yController,
                  builder: (context, value) {
                    return Stack(
                      children: [
                        !value.isReady ? ETourLoadingIndicator() : Container(),
                        YoutubePlayerIFrame(
                          controller: _yController,
                          aspectRatio: 16 / 9,
                        ),
                      ],
                    );
                  },
                )
              : _vController?.value.isInitialized ?? false
                  ? Material(
                      child: InkWell(
                        onTap: () => setState(() {
                          _vController?.value.isPlaying ?? false
                              ? _vController?.pause()
                              : _vController?.play();
                        }),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: _vController!.value.aspectRatio,
                              child: VideoPlayer(_vController!),
                            ),
                            if (!_vController!.value.isPlaying)
                              Positioned.fill(
                                  child: Icon(
                                Icons.pause,
                                size: 50,
                              )),
                          ],
                        ),
                      ),
                    )
                  : Center(child: ETourLoadingIndicator()),
          SizedBox(
            height: 16,
          ),
          ETourButton(
              titleTranslationKey: 'on_boarding_take_me_to_tour',
              action: () async {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_yController != null) _yController?.close();
    if (_vController != null) _vController?.dispose();
  }
}
