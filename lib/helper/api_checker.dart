import 'dart:developer';

import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    // print(apiResponse.error);
    if(apiResponse.error == "Failed to load data - status code: 401") {
      Provider.of<AuthController>(Get.context!,listen: false).clearSharedData();
    }else if(apiResponse.response?.statusCode == 500||apiResponse.error=='internal server error'){
      showCustomSnackBar(getTranslated('internal_server_errors', Get.context!), Get.context!);
    }else if(apiResponse.error=='Too Many Requests'||apiResponse.response?.statusCode == 429){
      showCustomSnackBar(getTranslated('Too_Many_Requests', Get.context!), Get.context!);
    }

    else {

      log("==ff=>${apiResponse.error}");
      // String? errorMessage = apiResponse.error.toString();
      // if (apiResponse.error is String) {
      //   errorMessage = apiResponse.error.toString();
      // } else {
      //
      //   ErrorResponse errorResponse = ErrorResponse.fromJson(apiResponse.error);
      //   log(errorResponse.toString());
      // }
        showCustomSnackBar(apiResponse.error, Get.context!);

    }
  }
}