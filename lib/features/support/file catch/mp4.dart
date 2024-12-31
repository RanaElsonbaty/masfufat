import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Mp4Widget extends StatefulWidget {
  final bool isSend;
  final File file;
  final bool min;
  final double height;
  final double width;
  const Mp4Widget({super.key, this.isSend = false, required this.file, required this.min, required this.height, required this.width});

  @override
  State<Mp4Widget> createState() => _Mp4WidgetState();
}

class _Mp4WidgetState extends State<Mp4Widget> {
  VideoPlayerController? videoController;
  bool isReady = false;
  bool isVideoPlay = false;
  void getVideo() {
    print(widget.file.path);
    if (widget.isSend) {
      print('widget file path =>${widget.file.path} // ${widget.isSend}');
      // if (mounted) {
        videoController =
            VideoPlayerController.networkUrl(Uri.parse(widget.file.path),)
              ..initialize().then((_) async {
                await videoController!.setVolume(1);
                videoController!.pause();
                isReady = true;

                setState(() {});
              });
      // }
    } else {
      if (mounted) {
        videoController = VideoPlayerController.file(widget.file)
          ..initialize().then((_) async {
            // _.
            print('widget file path =>${widget.file.path} // ${widget.isSend}');
            await videoController!.setVolume(1);

            videoController!.pause();
            isReady = true;
            setState(() {});
          });
      }
    }
  }

  @override
  void initState() {
    print('video get path');
    getVideo();
    super.initState();
  }

  @override
  void dispose() {
    videoController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return videoController!.value.isInitialized
        ? InkWell(
            onTap:widget.min==true?null: () {
                if (isVideoPlay == false) {
                  videoController!.play();
                } else {
                  videoController!.pause();
                }
                isVideoPlay = !isVideoPlay;
                setState(() {});
              print('isVideoPlay => $isVideoPlay');
            },
            child: Stack(
              children: [
                SizedBox(
                  height:widget.height,
                  width: widget.width,
                  child: AspectRatio(
                    aspectRatio: videoController!.value.aspectRatio,
                    child: VideoPlayer(

                      videoController!,
                    ),
                  ),
                ),
                Visibility(
                  visible:widget.min==false&& isVideoPlay == false,
                  child: Positioned(
                    left: 0,
                    right: 0,
                    top: widget.width/4.9,
                    // padding:  EdgeInsets.only(top: widget.width/5,left: 0,right: 0),
                    child: Icon(
                      isVideoPlay ? Icons.stop : Icons.play_arrow,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
          )
        : Center(
            child: SizedBox(
              height: 40,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}
