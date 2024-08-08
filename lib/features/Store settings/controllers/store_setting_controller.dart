import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/domain/model/store_setting_model.dart';

import '../domain/repositories/store_setting_repository_interface.dart';

class StoreSettingController extends ChangeNotifier {
  final StoreSettingInterface storeSettingInterface;
  StoreSettingController({required this.storeSettingInterface});
  final List<StoreSettingModel> _linkedAccountsList = [];
  List<StoreSettingModel> get linkedAccountsList => _linkedAccountsList;
  bool isLoading = false;
  Future getLinkedProduct() async {
    isLoading = true;
    _linkedAccountsList.clear();

    ApiResponse apiResponse =
    await storeSettingInterface.getLinkedAccount(

    );
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      isLoading = false;
      notifyListeners();
      // print('asdasdasdas${apiResponse.response!.data}');
      apiResponse.response!.data.forEach((elm) {
        _linkedAccountsList.add(StoreSettingModel.fromJson(elm));
      });
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();

      if (apiResponse.error is String) {
      } else {}
    }
  }
  bool ?_isSucsses=false;
  bool ?get isSucsses=>_isSucsses;
  Future unlinkLinkedAccount() async {
    isLoading = true;
    _linkedAccountsList.clear();

    ApiResponse apiResponse =
    await storeSettingInterface.unlinkLinkedAccount(

    );
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      isLoading = false;
      notifyListeners();
      _isSucsses=true;

      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      _isSucsses=false;

      notifyListeners();

      if (apiResponse.error is String) {
      } else {}
    }
  }

  List<bool> _activeSwitch = [];
  List<bool> get activeSwitch => _activeSwitch;
  void getLen(bool isLink) {
    _activeSwitch = List.filled(_linkedAccountsList.isNotEmpty?_linkedAccountsList.length:100, false);
    if(isLink==true){
      _activeSwitch.first=true;
    }
    // notifyListeners();
  }

  void getActive(bool value, int index) {
    _activeSwitch[index] = value;
    notifyListeners();
  }
}
