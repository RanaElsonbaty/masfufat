import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/app_constants.dart';
import '../../profile/controllers/profile_contrroller.dart';

class JsDart extends StatefulWidget {
  const JsDart({super.key});

  @override
  State<JsDart> createState() => _JsDartState();
}

class _JsDartState extends State<JsDart> {
  WebViewController? controller;
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // url = '';
    // press();
    initData();
  }

  String generateMd5(String input) {
    final String hashed = BCrypt.hashpw(input, BCrypt.gensalt());
    return hashed.toString();
  }

  String md5Convert = '';

  void initData() async {
    url = '${AppConstants.baseUrl}/api/v1/auth/login_';
    md5Convert =
        '${generateMd5('${Provider.of<ProfileController>(context, listen: false).userInfoModel!.email}${Provider.of<ProfileController>(context, listen: false).userInfoModel!.id}')}${Provider.of<ProfileController>(context, listen: false).userInfoModel!.temporaryToken}';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('progress -------> $progress');
          },
          onPageStarted: (String url) async{
            print(url);


          },
          onHttpError: (HttpResponseError error){
            print('----> ${error.response!}');
          },
          onPageFinished: (String url) async {

          },
          onUrlChange: (change) {
            print(change.url);
          },

          onWebResourceError: (WebResourceError error) {
            print(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(AppConstants.baseUrl)

      );
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    controller!.reload();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(
          title: 'تجربه كومو تتبع الطلب مغلقه حاليا',
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        body:           Container(
            child: WebViewWidget(controller: controller!)),
    );

  }

}
