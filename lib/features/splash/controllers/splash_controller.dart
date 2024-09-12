
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/models/config_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/services/splash_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/models/config_guist_model.dart' as guest;

class SplashController extends ChangeNotifier {
  final SplashServiceInterface? splashServiceInterface;
  SplashController({required this.splashServiceInterface});

  ConfigModel? _configModel;
  guest.ConfigGuest? _configModelGuest;
  BaseUrls? _baseUrls;
  CurrencyList? _myCurrency;
  CurrencyList? _usdCurrency;
  CurrencyList? _defaultCurrency;
  int? _currencyIndex;
  bool _hasConnection = true;
  bool _fromSetting = false;
  bool _firstTimeConnectionCheck = true;
  bool _onOff = true;
  bool get onOff => _onOff;

  ConfigModel? get configModel => _configModel;
  guest.ConfigGuest? get configModelGuest => _configModelGuest;
  BaseUrls? get baseUrls => _baseUrls;
  CurrencyList? get myCurrency => _myCurrency;
  CurrencyList? get usdCurrency => _usdCurrency;
  CurrencyList? get defaultCurrency => _defaultCurrency;
  int? get currencyIndex => _currencyIndex;
  bool get hasConnection => _hasConnection;
  bool get fromSetting => _fromSetting;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  List<bool> isExpanded=[];
  Future<bool> initConfigGuest(BuildContext context) async {

    _hasConnection = true;
    ApiResponse apiResponse = await splashServiceInterface!.getConfigGuest();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _configModelGuest = guest.ConfigGuest.fromJson(apiResponse.response!.data);
      // _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;
      // String? currencyCode = splashServiceInterface!.getCurrency();

      // themeController.setThemeColor(
      //   primaryColor: ColorHelper.hexCodeToColor(_configModel?.primaryColorCode),
      //   secondaryColor: ColorHelper.hexCodeToColor(_configModel?.secondaryColorCode),
      // );

      // isExpanded= List.filled(_configModel!.faq.isNotEmpty?_configModel!.faq.length:0, false);
      // for(CurrencyList currencyList in _configModel!.currencyList) {
      //   if(currencyList.id == _configModel!.systemDefaultCurrency) {
      //     if(currencyCode == null || currencyCode.isEmpty) {
      //       currencyCode = currencyList.code;
      //     }
      //     _defaultCurrency = currencyList;
      //   }
      //   if(currencyList.code == 'USD') {
      //     _usdCurrency = currencyList;
      //   }
      // }
      // getCurrencyData(currencyCode);
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi( apiResponse);
      if(apiResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();

    return isSuccess;
  }

  Future<bool> initConfig(BuildContext context) async {

    _hasConnection = true;
    ApiResponse apiResponse = await splashServiceInterface!.getConfig();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _configModel = ConfigModel.fromJson(apiResponse.response!.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;
      String? currencyCode = splashServiceInterface!.getCurrency();

      // themeController.setThemeColor(
      //   primaryColor: ColorHelper.hexCodeToColor(_configModel?.primaryColorCode),
      //   secondaryColor: ColorHelper.hexCodeToColor(_configModel?.secondaryColorCode),
      // );

      isExpanded= List.filled(_configModel!.faq.isNotEmpty?_configModel!.faq.length:0, false);
      for(CurrencyList currencyList in _configModel!.currencyList) {
        if(currencyList.id == _configModel!.systemDefaultCurrency) {
          if(currencyCode == null || currencyCode.isEmpty) {
            currencyCode = currencyList.code;
          }
          _defaultCurrency = currencyList;
        }
        if(currencyList.code == 'USD') {
          _usdCurrency = currencyList;
        }
      }
      getCurrencyData(currencyCode);
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi( apiResponse);
      if(apiResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();

    return isSuccess;
  }


  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  void getCurrencyData(String? currencyCode) {
    for (var currency in _configModel!.currencyList) {
      if(currencyCode == currency.code) {
        _myCurrency = currency;
        _currencyIndex = _configModel!.currencyList.indexOf(currency);
        continue;
      }
    }
  }

  void getIsExpanded( int index,val){
    isExpanded[index] =val;
    notifyListeners();
  }
  void setCurrency(int index) {
    splashServiceInterface!.setCurrency(_configModel!.currencyList[index].code);
    getCurrencyData(_configModel!.currencyList[index].code);
    notifyListeners();
  }

  void initSharedPrefData() {
    splashServiceInterface!.initSharedData();
  }

  void setFromSetting(bool isSetting) {
    _fromSetting = isSetting;
  }

  bool? showIntro() {
    return splashServiceInterface!.showIntro();
  }

  void disableIntro() {
    splashServiceInterface!.disableIntro();
  }

  void changeAnnouncementOnOff(bool on){
    _onOff = !_onOff;
    notifyListeners();
  }
  bool _maintenanceMode=false;
  bool get maintenanceMode=>_maintenanceMode;
  Future getMaintenanceMode()async{
    try {
      ApiResponse apiResponse = await splashServiceInterface!.getMaintenanceMode();
      if(apiResponse.response!=null&&apiResponse.response!.statusCode==200){
        // print('asdasdasdaasdadasdasdadasdasdsdasd${apiResponse.response!.data['maintenance_mode']}');
        if(apiResponse.response!.data['maintenance_mode'].runtimeType ==int){
          _maintenanceMode=apiResponse.response!.data['maintenance_mode']==1?true:false;

        }else{
          _maintenanceMode=apiResponse.response!.data['maintenance_mode'];

        }
      }
    }catch(e){

    }
  }
  String _selectBank = 'select';
  String get selectBank => _selectBank;
  void getSelectBank(String select,bool notify) {
    _selectBank = select;
    if(notify){
      notifyListeners();}
  }
  String iBAN ='';
  String bankAccountNumber ='';
  String bankName ='';
  void getDeatils(String name,String cardID){
    for (var element in _configModel!.paymentMethods.bankTransfer.banks) {
      if(element.name==name||element.accountNumber==cardID){
          bankAccountNumber=element.accountNumber;
          iBAN=element.iban;
          bankName=element.name;
      }
    }
    notifyListeners();
  }
  XFile ?bankTransferImage;
  void pickImage() async {

  try{
    bankTransferImage = await ImagePicker().pickImage(
        imageQuality: 100, source: ImageSource.gallery);
  }catch(e){

  }
    notifyListeners();
  }


}
