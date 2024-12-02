import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/domain/models/transaction_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/domain/models/wallet_bonus_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/domain/services/wallet_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';

class WalletController extends ChangeNotifier {
  final WalletServiceInterface walletServiceInterface;
  WalletController({required this.walletServiceInterface});


  bool _isLoading = false;
  bool _firstLoading = false;
  bool _isConvert = false;
  bool get isConvert => _isConvert;
  bool get isLoading => _isLoading;
  bool get firstLoading => _firstLoading;
  int? _transactionPageSize;
  int? get transactionPageSize=> _transactionPageSize;
  TransactionModel? _walletTransactionModel;
  TransactionModel? get walletTransactionModel => _walletTransactionModel;



  Future<void> getTransactionList(BuildContext context, int offset, String type, {bool reload = true}) async {
    if(reload || offset == 1){
      _walletTransactionModel = null;
    }
    ApiResponse apiResponse = await walletServiceInterface.getWalletTransactionList(offset, type);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      if(offset == 1) {
        // print(apiResponse.response!.data);
        _walletTransactionModel = TransactionModel.fromJson(apiResponse.response!.data);

      }else {
        _walletTransactionModel?.offset  = TransactionModel.fromJson(apiResponse.response!.data).offset;
        _walletTransactionModel?.totalWalletBalance  = TransactionModel.fromJson(apiResponse.response!.data).totalWalletBalance;
        _walletTransactionModel?.totalWalletTransactio  = TransactionModel.fromJson(apiResponse.response!.data).totalWalletTransactio;
        _walletTransactionModel?.walletTransactioList?.addAll(TransactionModel.fromJson(apiResponse.response!.data).walletTransactioList ?? []);

      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  void showBottomLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }
  Future <void> addFundToWallet(String amount, String paymentMethod) async {
    _isConvert = true;
    notifyListeners();
    ApiResponse apiResponse = await walletServiceInterface.addFundToWallet(amount, paymentMethod);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isConvert = false;
      // Navigator.pushReplacement(Get.context!, MaterialPageRoute(builder: (_) =>
          // AddFundToWalletScreen(url: apiResponse.response!.data['redirect_link'])));
    }else if (apiResponse.response?.statusCode == 202){
      showCustomSnackBar("Minimum= ${PriceConverter.convertPrice(Get.context!, apiResponse.response?.data['minimum_amount'].toDouble())} and Maximum=${PriceConverter.convertPrice(Get.context!, apiResponse.response?.data['maximum_amount'].toDouble())}" , Get.context!);
    }else{
      _isConvert = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }



  WalletBonusModel? walletBonusModel;
  Future<void> getWalletBonusBannerList() async {
    ApiResponse apiResponse = await walletServiceInterface.getWalletBonusBannerList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      walletBonusModel = WalletBonusModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }


  List<String> types = ['all_Transaction','order_transactions','order_refund', 'converted_from_loyalty_point', 'added_via_payment_method',  'add_fund_by_admin','subscription_fees'];
  List<String> filterTypes = ["all_Transaction", "Purchase_orders", "Retrieve_orders", 'Loyalty_points_transferred_to_wallet_balance', 'Charging_wallet_balance_by_payment_methods', 'Adding_credit_by_platform_management',"subscription_fees"];
void clearFilter(){
   selectedFilterType = 'all_Transaction';
   selectedIndexForFilter = 0;

}
  String selectedFilterType = 'all_Transaction';
  int selectedIndexForFilter = 0;
  void setSelectedFilterType(String type, int index, {bool reload = true}){
    selectedIndexForFilter = index;
    String apiType='';
    if(type == filterTypes[0]){
      selectedFilterType = filterTypes[0];
      apiType = types[0];
    }else if(type == filterTypes[1]){
      selectedFilterType = filterTypes[1];
      apiType = types[1];
    }else if(type == filterTypes[2]){
      selectedFilterType = filterTypes[2];
      apiType = types[2];
    }else if(type == filterTypes[3]){
      selectedFilterType = filterTypes[3];
      apiType = types[3];
    }else if(type == filterTypes[4]){
      selectedFilterType = filterTypes[4];
      apiType = types[4];
    }else if(type == filterTypes[5]){
      apiType = types[5];
      selectedFilterType = filterTypes[5];
    }else if(type == filterTypes[6]){
      selectedFilterType = filterTypes[6];
      apiType = types[6];
    }
    getTransactionList(Get.context!, 1, apiType, reload: true);

    if(reload){
      notifyListeners();
    }

  }



}
