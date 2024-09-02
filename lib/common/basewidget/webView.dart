import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main.dart';

class WepView extends StatefulWidget {
  final String? url;
  final bool? check;
  final bool? sub;
  final bool? create;
  final bool? storeSetting;
  const WepView(
      {super.key,
      this.url,
      this.check = true,
      this.sub = false,
      this.create = false,
      this.storeSetting = false});

  @override
  State<WepView> createState() => _WepViewState();
}

class _WepViewState extends State<WepView> {
  String md5Convert = '';
  @override
  void initState() {
    super.initState();
    initData();
  }

  WebViewController? controller;
  void initData() async {
    // cartProvider = Provider.of<CartProvider>(context,listen: false);
    // authProvider = Provider.of<AuthProvider>(context,listen: false);
    // splashProvider = Provider.of<SplashProvider>(context,listen: false);
    // linkedAccountProvider = Provider.of<LinkedAccountProvider>(context,listen: false);
    // subscriptionsProvider = Provider.of<SubscriptionsProvider>(context,listen: false);
    // profileProvider = Provider.of<ProfileProvider>(context,listen: false);
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
          onPageStarted: (String url) {
            print('page start -------> $url');

            // splashProvider!.getWepProgress(0,true);
          },
          onPageFinished: (String url) async {
            Provider.of<ProfileController>(Get.context!, listen: false)
                .getUserInfo(context);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!), headers: {
        'Authorization':
            "Bearer ${Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}",
        'Access-token': md5Convert,
      }).catchError((error) {
        print('catch error web view ---> $error ');
      }).then((value) {});
    // profileProvider!.getInitWebView(false,true);

    print('user info after convert ---> $md5Convert');
  }

  @override
  void dispose() {
    super.dispose();
  }
  // }

  String pageUrl = '';
  @override
  Widget build(BuildContext context) {
    // controller
    try {
      return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                // iconTheme: ,
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  getTranslated('profile', context)!,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
              ),
              body: WebViewWidget(controller: controller!)));
    } catch (e) {
      return Text(
        e.toString(),
        style: const TextStyle(fontSize: 30),
      );
    }
  }

  String generateMd5(String input) {
    // String password = '123';

    // Hash password
    final String hashed = BCrypt.hashpw(input, BCrypt.gensalt());

    print('Original Password: $input');
    print('Hashed Password: $hashed');
    return hashed.toString();
// return  stopwatch.elapsed;
    // return md5.convert(utf8.encode(input)).toString();
  }
}
