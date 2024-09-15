import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_document/my_files/my_files_screen.dart';
import 'package:open_document/open_document.dart';
import 'package:open_document/open_document_exception.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/images.dart';

class DocxAndXlsxFile extends StatefulWidget {
  final File file;
  final bool isSend;
  final String fileName;
  const   DocxAndXlsxFile(
      {super.key,  required this.file, this.isSend = false, required this.fileName});

  @override
  State<DocxAndXlsxFile> createState() => _DocxAndXlsxFileState();
}

class _DocxAndXlsxFileState extends State<DocxAndXlsxFile> {
  String _platformVersion = '0';
  bool isCheck = false;
  Future<String?> downloadFile(
      {String? filePath, String? url, String? token}) async {
    // CancelToken cancelToken = CancelToken();
    String countryCode = '';
    setState(() {
      _platformVersion = '0%';
    });

    Dio dio = Dio();
    dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
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
    setState(() {});
    return filePath;
  }

  void getPermissionStatus() async {
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      print('permissionStatus isDenied => ${permissionStatus.isDenied}');

      await Permission.storage.request();

      // I noticed that sometimes popup won't show after user press deny
      // so I do the check once again but now go straight to appSettings
      if (permissionStatus.isDenied) {
        print('permissionStatus isDenied => ${permissionStatus.isDenied}');

        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      print(
          'permissionStatus isPermanentlyDenied => ${permissionStatus.isPermanentlyDenied}');
      await openAppSettings();
    } else {}
  }

  void getDownloadFile() async {
    String url = widget.file.path;
    final name = await OpenDocument.getNameFile(url: url);

    final path = await OpenDocument.getPathDocument();

    String? filePath = "$path/$name";
    bool isChecked = await OpenDocument.checkDocument(filePath: filePath);

    setState(() {
      isCheck = isChecked;
    });
    print('OpenDocument checkDocument => $isCheck');
  }

  bool error = false;
  void initPlatformState() async {
    String url = widget.file.path;
    final name = await OpenDocument.getNameFile(url: url);

    final path = await OpenDocument.getPathDocument();

    String? filePath = "$path/$name";

    // final isCheck = await OpenDocument.checkDocument(filePath: filePath);

    try {
      filePath = await downloadFile(filePath: filePath, url: url);
    } on OpenDocumentException catch (e) {
      setState(() {
        error = true;
      });
      debugPrint("ERROR: ${e.errorMessage}");
      filePath = 'Failed to get platform version.';
    }
  }

  @override
  void initState() {
    getPermissionStatus();

    getDownloadFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async  {
        if (!isCheck) {
          initPlatformState();
        } else {
          try {
            final permissionStatus = await Permission.storage.status;

            if (permissionStatus.isDenied &&
                permissionStatus.isPermanentlyDenied) {
            } else {
              String? filePath = '';

              String url = widget.file.path;
              final name = await OpenDocument.getNameFile(url: url);

              final path = await OpenDocument.getPathDocument();

              filePath = "$path/$name";
              if (Platform.isIOS){
                await OpenDocument.openDocument(filePath: filePath);

              }else{
                await OpenFile.open(filePath);

              }

              if (widget.isSend) {
                filePath = widget.file.path;
              }
              if (Platform.isAndroid) {
                Navigator.push(
                    Get.context!,
                    MaterialPageRoute(
                      builder: (context) => MyFilesScreen(
                          filePath: filePath!,
                          error: const Icon(
                            Icons.error,
                            size: 100,
                          ),
                          // lastPath: [filePath],
                          loading: const CircularProgressIndicator()),
                    ));
              }
            }
          } on OpenDocumentException catch (e) {
            setState(() {
              error = true;
            });
            print('asdasdasdasdadsasdas =>${e.errorMessage}');
          }
        }
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: Container(
          // height: 60,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // textDirection: TextDirection.rtl,
            children: [
              const SizedBox(
                width: 10,
              ),
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
                  isCheck == false
                      ? _platformVersion != '0'
                          ? Positioned(
                              left: _platformVersion != '100%' ? 16 : 14,
                              top: 18,
                              child: Text(
                                _platformVersion,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            )
                          : const Icon(
                              Icons.download,
                              color: Colors.white,
                              size: 25,
                            )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(

                 Images.word
                   ,
                height: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  widget.fileName,
                  overflow: TextOverflow.ellipsis,
                  // textDirection: TextDirection.ltr,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
