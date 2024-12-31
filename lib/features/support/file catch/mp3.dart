import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final bool offline;
  final String? path;
  final double? width;

  const WaveBubble({
    super.key,
    this.width,
    this.isSender = false,
    this.path,
    this.offline = false,
  });

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  PlayerController controller = PlayerController();
  String filePath = '';
  bool isFileReady = false;
  String progress = '0%';
  bool error =false;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 5,
  );

  @override
  void initState() {
    super.initState();
    // controller. se(finishMode: FinishMode.stop);

    print(widget.path??'no');

    _preparePlayer();
    controller.addListener(() {

      controller.onCompletion.listen((_) {
        setState(() {
          // إعادة تعيين واجهة المستخدم عند انتهاء الصوت
          controller.stopPlayer();
        });
      });
  // controller.
    }
    );
  }

  Future<void> _preparePlayer() async {
    try {
      if (widget.offline) {
        // Handle offline file playback
        filePath = widget.path!;
        isFileReady = await File(filePath).exists();
      } else {
        print('_downloadFileIfNeeded');
        // Handle online file playback (download if necessary)
        filePath = await _downloadFileIfNeeded(widget.path!);
        isFileReady = true;
      }

      // Prepare player
      await controller.preparePlayer(
        path: filePath,
        shouldExtractWaveform: true,
      );


      setState(() {});
    } catch (e) {
      debugPrint("Error preparing player: $e");
      error=true;

    }
  }

  Future<String> _downloadFileIfNeeded(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = url.split('/').last;
    final localPath = "${directory.path}/$fileName";

    if (await File(localPath).exists()) {
print('exists file' );
      return localPath;
    }

    Dio dio = Dio();
    try {
      await dio.download(
        url,
        localPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = "${(received / total * 100).toStringAsFixed(0)}%";
            });
          }
        },
      );
    } catch (e) {
      debugPrint("Error downloading file: $e");
      error=true;
    }

    return localPath;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        color:  Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Download Progress Indicator
          progress != '0%' && progress != '100%'
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const CircularProgressIndicator(color: Colors.white),
                Text(
                  progress,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          )
              : const SizedBox.shrink(),
        // show error


          // Play/Pause Button
          if(error==false)
          if (isFileReady)
            IconButton(
              onPressed: () async {

                if (controller.playerState.isPlaying) {
                  // إيقاف المشغل إذا كان يعمل
                  try{
                    await controller.stopPlayer();

                  }catch(e){
                    debugPrint("Error stop player: $e");

                  }
                } else {
                  // إذا كان المشغل متوقفًا، قم بتهيئته وتشغيله
                  try {
                    await controller.preparePlayer(
                      path: filePath,
                      shouldExtractWaveform: true,
                    );
                    await controller.startPlayer(forceRefresh: true);
                  } catch (e) {
                    debugPrint("Error starting player: $e");
                    setState(() {
                      error = true;
                    });
                  }
                }

                setState(() {});
              },
              icon: Icon(
                controller.playerState.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),

          if(error)
            Text('record not available ',style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,fontSize: 12,color: Colors.white
            ),),
          // Waveform
          if(error==false)
          if (isFileReady)
            AudioFileWaveforms(
              size: const Size( 100, 40),
              playerController: controller,



              margin: const EdgeInsets.only(right: 10),
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: playerWaveStyle,
            ),
        ],
      ),
    );
  }
}
