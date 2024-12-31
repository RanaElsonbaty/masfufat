import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/domain/model/store_setting_model.dart';

import '../domain/model/packages.dart';
import '../domain/repositories/store_setting_repository_interface.dart';

class StoreSettingController extends ChangeNotifier {
  final StoreSettingInterface storeSettingInterface;
  StoreSettingController({required this.storeSettingInterface});
   List<StoreSettingModel> _linkedAccountsList = [];
  List<StoreSettingModel> get linkedAccountsList => _linkedAccountsList;
  bool isLoading = false;
  Future getLinkedProduct() async {
    isLoading = true;
    _linkedAccountsList.clear();
    _linkedAccountsList=[];
    notifyListeners();
    ApiResponse apiResponse =
    await storeSettingInterface.getLinkedAccount(

    );
    _linkedAccountsList=[];
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _linkedAccountsList=[];
      isLoading = false;
      notifyListeners();
      apiResponse.response!.data.forEach((elm) {
        _linkedAccountsList.add(StoreSettingModel.fromJson(elm));
      });
      for (var element in _linkedAccountsList) {
        print(element.storeDetails);
      }
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
  Future unlinkLinkedAccount(bool salla) async {
    isLoading = true;
    _linkedAccountsList.clear();

    ApiResponse apiResponse =
    await storeSettingInterface.unlinkLinkedAccount(
        salla
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
    _activeSwitch=[];
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
  final List<Packages> _packages=[];
  List<Packages> get packages=>_packages;
  bool _showStoreSetting=true;
  bool get showStoreSetting=>_showStoreSetting;
  Future getPackages() async {

    ApiResponse apiResponse =
    await storeSettingInterface.packages(

    );
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {

      apiResponse.response!.data.forEach((elm) {
        _packages.add(Packages.fromJson(elm));
      });
      for (var element in _packages) {
        if(element.currentPack==true){
          if(element.name=="الباقة المجانية (للشراء فقط)"||element.id==17){
            _showStoreSetting=false;
          }else{
            print(element.name);
            _showStoreSetting=true;
          }
        }else {

        }
        notifyListeners();
      }
      notifyListeners();

    } else {

      if (apiResponse.error is String) {
      } else {}
    }
  }


}
