import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../main.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../profile/controllers/profile_contrroller.dart';
import '../controllers/store_setting_controller.dart';

class LinkWebView extends StatefulWidget {
  final String url;
  final String storeName;
  const LinkWebView({super.key, required this.url, required this.storeName});

  @override
  State<LinkWebView> createState() => _LinkWebViewState();
}

class _LinkWebViewState extends State<LinkWebView> {
  WebViewController? controller;
  String url = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.url;
    initData();
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
  String md5Convert = '';
  void initData() {
    url ='${AppConstants.baseUrl}/api/v1/auth/login_';
    md5Convert =
    '${generateMd5('${Provider.of<ProfileController>(context, listen: false).userInfoModel!.email}${Provider.of<ProfileController>(context, listen: false).userInfoModel!.id}')}${Provider.of<ProfileController>(context, listen: false).userInfoModel!.temporaryToken}';

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // if(progress==100){
            //   url='${AppConstants.baseUrl}/customer/auth/login';
            // }
            print('progress -------> $progress');
          },
          onPageStarted: (String url) {

            getLinkPage(url);
          },
          onPageFinished: (String url) async {
            // if(url=='${AppConstants.baseUrl}/customer/auth/login'){
            //   showCustomSnackBar(
            //       getTranslated('You_must_log_in_to_the_web_arrays_before_starting_the_binding_process', context),
            //       Get.context!,
            //       time: 3,
            //       isError: false,
            //       isToaster: false);
            // }
            getLinkPage(url);
            },
          onUrlChange: (change) {

            getLinkPage(change.url!);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(url),
          headers: {
            'Authorization':
            "Bearer ${Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}",
            'Access-token': md5Convert,
          }
      ).catchError((error) {
        print('catch error web view ---> $error ');
      }).then((value) {
        Provider.of<ProfileController>(context, listen: false)
            .getUserInfo(context);
        Provider.of<StoreSettingController>(context,listen: false)
            .getLinkedProduct(
        )
            .then((value) {
          Provider.of<StoreSettingController>(context,listen: false).getLen(
              Provider.of<StoreSettingController>(context,listen: false)
                  .linkedAccountsList.first.storeDetails!=null
          );
        });
      });

  }
  void getLinkPage(String url){

    if (url == '${AppConstants.baseUrl}/user-account') {
      if(widget.storeName=='salla'){
        controller!.loadRequest(Uri.parse('${AppConstants.baseUrl}/salla/oauth/redirect'));
      }else
      {
        controller!.loadRequest(Uri.parse('https://web.zid.sa/login'));
      }
    }else if(url.contains('https://accounts.salla.sa/callback/')){
      controller!.loadRequest(Uri.parse('https://s.salla.sa/apps'));

    }else if(url.contains('https://web.zid.sa/home')){
    // https://web.zid.sa/market/app/3852
    controller!.loadRequest(Uri.parse('https://web.zid.sa/market/app/3852'));

    }
    print(url);
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
        appBar:  CustomAppBar(title: '${getTranslated('Link_with', context)} ${widget.storeName}',
        onBackPressed: (){
          Provider.of<ProfileController>(context, listen: false)
              .getUserInfo(context);
          Provider.of<StoreSettingController>(context,listen: false)
              .getLinkedProduct(
          )
              .then((value) {
            Provider.of<StoreSettingController>(context,listen: false).getLen(
                Provider.of<StoreSettingController>(context,listen: false)
                    .linkedAccountsList.first.storeDetails!=null
            );
          });
          Navigator.pop(context);
        },

        ),
        body: WebViewWidget(controller: controller!));
  }
}
