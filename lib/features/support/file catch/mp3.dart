import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_document/my_files/init.dart';
import 'package:path_provider/path_provider.dart';

// import '../../../provider/auth_provider.dart';
// import '../../../provider/support_ticket_provider.dart';
import '../../../utill/app_constants.dart';

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final bool ofline;
  final int? index;
  final String? path;
  final double? width;
  final Directory appDirectory;

  const WaveBubble({
    super.key,
    required this.appDirectory,
    this.width,
    this.index,
    this.isSender = false,
    this.path,
    this.ofline = false,
  });

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;
  bool isCheck = false;
  String _platformVersion = '0';
  String filePath = '';

  PlayerController controller = PlayerController();
  // late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );
  Future<String?> downloadFile(
      {String? filePath, String? url, String? token}) async {
    // CancelToken cancelToken = CancelToken();
    String countryCode = '';
    Dio dio = Dio();
    dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout =  const Duration(seconds: 60)
      ..options.receiveTimeout =  const Duration(seconds: 60)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        AppConstants.langKey:
            countryCode == 'US' ? 'en' : countryCode.toLowerCase(),
      };
    await dio.downloadUri(
      Uri.parse(url!),
      filePath,
      // options: Options(headers: {}),
      onReceiveProgress: (count, total) {
        debugPrint('---Download----Rec: $count, Total: $total');
        setState(() {
          _platformVersion = "${((count / total) * 100).toStringAsFixed(0)}%";
        });
      },
    );
    _platformVersion = '0';
    isCheck = true;
    getDownloadFile();
    _preparePlayer();
    setState(() {});
    return filePath;
  }

  Future getDownloadFile() async {
    String url = widget.path!;
    final name = await OpenDocument.getNameFile(url: url);

    final path = await OpenDocument.getPathDocument();

    setState(() {
      filePath = "$path/$name";
    });
    print('getDownloadFile => $filePath');
    bool isChecked = await OpenDocument.checkDocument(filePath: filePath);

    setState(() {
      isCheck = isChecked;
    });
    if (isCheck) {
      _preparePlayer();
    }
    print('OpenDocument checkDocument => $isCheck');
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<SupportTicketProvider>(context, listen: false)
    //     .initialiseControllers();
    print('asasasasaaaaaaaaaaaaaaaaaaaa${widget.path!}');
    print('asasasasaaaaaaaaaaaaaaaaaaaa${widget.isSender}');
    if (widget.isSender == true) {
      // print('asdasdasdasd${widget.isSender}');
      getDownloadFile().then((value) {
        _preparePlayer();
      });
      isCheck = true;
    } else {
      // getDownloadFile();
    }
    _preparePlayer();
  }

  void _preparePlayer() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();

    print('filePath => $filePath');
    print('widget.path => ${widget.path}');
    print('widget.appDirectory.path => ${appDirectory.path}');
    try {
      controller.preparePlayer(
        path: widget.ofline == false
            ? widget.isSender == true
                ? filePath
                : widget.path!
            : filePath,
        shouldExtractWaveform: widget.index?.isEven ?? true,
      );
    } catch (e) {
      print('preparePlayer => $e');
    }
    print('asdasdadas$filePath');
    try {
      if (widget.index?.isOdd ?? false) {
        controller.extractWaveformData(
          path: filePath,
          noOfSamples: playerWaveStyle.getSamplesForWidth(widget.width ?? 400),
        );
      }
    } catch (e) {
      print('extractWaveformData => $e');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF343145),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              _platformVersion != '0'
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
                  : const SizedBox.shrink(),
              _platformVersion != '0'
                  ? Positioned(
                left: _platformVersion != '100%' ? 16 : 14,
                top: 18,
                child: Text(
                  _platformVersion,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              )
                  : const SizedBox.shrink(),
            ],
          ),
          _platformVersion == '0'
              ? widget.isSender == false
              ? IconButton(
            onPressed: () async {
              controller.playerState.isPlaying
                  ? await controller.pausePlayer()
                  : await controller.startPlayer(
                finishMode: FinishMode.pause,
              );
              setState(() {});
            },
            icon: Icon(
              controller.playerState.isPlaying
                  ? Icons.stop
                  : Icons.play_arrow,
            ),
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
              : !isCheck
              ? InkWell(
              onTap: () async {
                String? url = widget.path!;
                final name =
                await OpenDocument.getNameFile(
                    url: url);

                final path =
                await OpenDocument.getPathDocument();

                filePath = "$path/$name";
                if (!isCheck) {
                  print('adadasdsdasdasd');
                  // downloadFile(
                  //     url: url,
                  //     filePath: filePath,
                      // token: Provider.of<AuthProvider>(
                      //     context,
                      //     listen: false)
                      //     .getUserToken());
                }
              },
              child: const Icon(
                Icons.download,
                size: 30,
                color: Colors.white,
              ))
              : IconButton(
            onPressed: () async {
              controller.playerState.isPlaying
                  ? await controller.pausePlayer()
                  : await controller.startPlayer(
                finishMode: FinishMode.pause,
              );
              setState(() {});
            },
            icon: Icon(
              controller.playerState.isPlaying == true
                  ? Icons.stop
                  : Icons.play_arrow,
            ),
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
              : const SizedBox.shrink(),
          // _platformVersion == '0'
          //     ? widget.isSender == false && widget.ofline == true
          //         ? !isCheck
          //             ? InkWell(
          //                 onTap: () async {
          //                   String? url = widget.path!;
          //                   final name =
          //                       await OpenDocument.getNameFile(
          //                           url: url);
          //
          //                   final path =
          //                       await OpenDocument.getPathDocument();
          //
          //                   filePath = "$path/$name";
          //                   if (!isCheck) {
          //                     print('adadasdsdasdasd');
          //                     downloadFile(
          //                         url: url,
          //                         filePath: filePath,
          //                         token: Provider.of<AuthProvider>(
          //                                 context,
          //                                 listen: false)
          //                             .getUserToken());
          //                   }
          //                 },
          //                 child: Icon(
          //                   Icons.download,
          //                   size: 30,
          //                 ))
          //             : SizedBox()
          //         : SizedBox()
          //     : SizedBox.shrink(),
          // Spacer(),
          Expanded(
            child: AudioFileWaveforms(
              size: const Size(500, 20),

              playerController: controller,
              margin: const EdgeInsets.only(right: 10),
              waveformType: WaveformType.fitWidth,

              backgroundColor: Colors.black,
              // decoration: BoxDecoration(
              //
              // ),

              playerWaveStyle: playerWaveStyle,
            ),
          ),
          // if (widget.isSender) const SizedBox(width: 10),
          // if (widget.isSender)
          //   InkWell(
          //       onTap: () {
          //         support.refreshWave();
          //         file = null;
          //         // setState(() {});
          //         // controller.setRefresh(refresh)
          //       },
          //       child: Icon(
          //         Icons.cancel_outlined,
          //         size: 20,
          //       )),
          // if (widget.isSender) const SizedBox(width: 10),
        ],
      ),
    );
  }
}
