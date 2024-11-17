import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment%20/domain/model/payment_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment%20/domain/services/payment_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/animated_custom_dialog_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../localization/language_constrants.dart';
import '../../../utill/images.dart';
import '../../checkout/widgets/order_place_dialog_widget.dart';
import '../../checkout/widgets/payment_method_bottom_sheet_widget.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../splash/domain/models/config_model.dart';

class PaymentController extends ChangeNotifier {
  final PaymentServiceInterface paymentServiceInterface;


  PaymentController({required this.paymentServiceInterface});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void getIsLoading(bool val, bool notify) {
    _isLoading = val;
    if (notify) {
      notifyListeners();
    }
  }

  String _apiKey = '';

  String get apiKey => _apiKey;

// get token
  Future getApiKey(BuildContext context) async {
    ConfigModel? configModel =
        Provider.of<SplashController>(context, listen: false).configModel!;
    if (configModel!=null) {
      // _apiKey='BxmEsVbst5n67F8_vtxMqNzUCKLz6CMnNBgFNlsjNSqh4LKzL1ge76ZCkSEWn5kpT1qgjEPjebxrgdgh1jEoBWbC4ESHbK7nKExX0TkHGVoQRQCV-tSpRws8wEA_1z7_g_6qi1y4dt1ledcOb1nJjxdc6d9Sr2xknxlSd1nwwgwCmf2c259-EPhgvaQwr642CzDWe588yrI_yU-m-4dlvOC4kPfQrYgLlWrnNCdDj_z4S_bj9w9sv3U0ypWTSrIqB19hU2DtR7OOia5dEhRXXaGkPeAT_y0_eNL2Jn2WmELbohFK2jH80eh0KIgBMPbznFYU-sU059ukpVuOMDZmwc-tzEqyrUQT1pCCPkSNZYxGpmxmoeOkvxeqSSoyzCnwrRZdp8ery8BWx_OCRCyN6T1yO4X02ZVBY6jbhnag6YxnHDs3VDw0K8s2wsLMFppNZtQT0HzmW4bIDUCy0y_wwJoH-WtQ4pWZxEeGEoEAbtk_8vTmZMhieoW-4SMH0NfIQ5IHoDr8wVWCzhhsGLNAvNDpmP35-6p0lDfNCoKWuPUN8J5Pj0oD80LcPfMZTd2CnezPMEjMlVZJnDUh6qYVxLXoFogjuV3O-uY4PUg0dJt14LBGnJCaxBGgREqXmxkodjB0BUvI_UgQLrJ5-R1Z9VME-yYrik44J4a7uqk9aDACrGIf';
      _apiKey = configModel.paymentMethods.fatoorah.apiKey;
    } else {
      _apiKey = "";
    }
    // _apiKey='rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL';
  }

  String _type = '';

  String get type => _type;
   String _id = '';

  String get id => _id;
void getOrderId(String id){
  _id=id;
  notifyListeners();

}
  void getType(String type) {
    _type = type;
  }

  MFInitiateSessionResponse? session;

  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;

  String cardNumber = "5453010000095489";
  String expiryMonth = "05";
  String expiryYear = "21";
  String securityCode = "100";
  String cardHolderName = "";

  double _amount = 0.00;

  double get amount => _amount;
  bool visibilityObs = false;
  MFCardPaymentView mfCardView =
      MFCardPaymentView(cardViewStyle: MFCardViewStyle());
  MFApplePayButton mfApplePayButton = MFApplePayButton();

  // init my fatotra
  initiate(BuildContext context) async {
  try{
    print('api key ----> $apiKey');
    await MFSDK.init(apiKey, MFCountry.SAUDIARABIA, MFEnvironment.TEST);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initSession(context);
      await initiatePayment();
    });
  }catch(e){
print('error initiate ===== $e');

  }
  }

  log(Object object) {
    var json = const JsonEncoder.withIndent('  ').convert(object);
    debugPrint(json);
  }

  // Send Payment
  // sendPayment() async {
  //   var request = MFSendPaymentRequest(
  //       invoiceValue: amount,
  //
  //       customerName: "Customer name",
  //       notificationOption: MFNotificationOption.LINK);
  //   await MFSDK
  //       .sendPayment(request, MFLanguage.ENGLISH)
  //       .then((value) => log(value))
  //       .catchError((error) => {log(error)});
  // }

  // Initiate Payment
  initiatePayment() async {
    var request = MFInitiatePaymentRequest(
      invoiceAmount: amount,
      currencyIso: MFCurrencyISO.SAUDIARABIA_SAR,

    );

    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH,)
        .then((value) => {
              log(value),
              paymentMethods.addAll(value.paymentMethods!),
              for (int i = 0; i < paymentMethods.length; i++)
                isSelected.add(false)
            })
        .catchError((error) {
          return {log('error initiatePayment ---->${error.message}')};
        });
  }

  // Execute Regular Payment
  executeRegularPayment(int paymentMethodId) async {
    var request = MFExecutePaymentRequest(
        paymentMethodId: paymentMethodId, invoiceValue: amount);
    request.displayCurrencyIso = displayCurrencyIso;

    await MFSDK
        .executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
          log(invoiceId);
        })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  //Execute Direct Payment
  executeDirectPayment(int paymentMethodId, bool isToken) async {
    var request = MFExecutePaymentRequest(
      paymentMethodId: paymentMethodId,
      invoiceValue: amount,
    );
    request.displayCurrencyIso = displayCurrencyIso;

    var token = isToken ? "TOKEN210282" : null;
    var mfCardRequest = isToken
        ? null
        : MFCard(
            cardHolderName: cardHolderName,
            number: cardNumber,
            expiryMonth: expiryMonth,
            expiryYear: expiryYear,
            securityCode: securityCode,
          );

    var directPaymentRequest = MFDirectPaymentRequest(
        executePaymentRequest: request, token: token, card: mfCardRequest);
    log(directPaymentRequest);

    await MFSDK
        .executeDirectPayment(directPaymentRequest, MFLanguage.ENGLISH,
            (invoiceId) {
          debugPrint("-----------$invoiceId------------");
          log(invoiceId);
        })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Payment Enquiry
  getPaymentStatus(String key) async {
    MFGetPaymentStatusRequest request =
        MFGetPaymentStatusRequest(key: key, keyType: MFKeyType.INVOICEID);

    await MFSDK
        .getPaymentStatus(request, MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Token
  cancelToken() async {
    await MFSDK
        .cancelToken("Put your token here", MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Recurring Payment
  cancelRecurringPayment() async {
    await MFSDK
        .cancelRecurringPayment("Put RecurringId here", MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // get payment method by my fatora
  setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          visibilityObs = paymentMethods[index].isDirectPayment!;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else {
        isSelected[i] = false;
      }
    }
  }

  // executePayment() {
  //   if (selectedPaymentMethodIndex == -1) {
  //   } else {
  //     if (paymentMethods[selectedPaymentMethodIndex].isDirectPayment!) {
  //       if (cardNumber.isEmpty ||
  //           expiryMonth.isEmpty ||
  //           expiryYear.isEmpty ||
  //           securityCode.isEmpty) {
  //       } else {
  //         executeDirectPayment(
  //             paymentMethods[selectedPaymentMethodIndex].paymentMethodId!,
  //             false);
  //       }
  //     } else {
  //       executeRegularPayment(
  //           paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
  //     }
  //   }
  // }

  // card design
  MFCardViewStyle cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.cardHeight = 200;
    cardViewStyle.hideCardIcons = false;
    cardViewStyle.input?.inputMargin = 3;
    cardViewStyle.label?.display = true;
    // cardViewStyle..
    cardViewStyle.input?.borderRadius =12;
    cardViewStyle.input?.fontFamily = MFFontFamily.TimesNewRoman;
    cardViewStyle.label?.fontWeight = MFFontWeight.Light;
    return cardViewStyle;
  }

  // init to get session id
  initSession(BuildContext context) async {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest();

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH,)
        .then((value) => loadEmbeddedPayment(value, context))
        .catchError((error) {
      showCustomSnackBar(getTranslated('pay_dis', Get.context!), Get.context!,time: 5,isError: true);

          return {log('error initSession ----> ${error.message}')};
        });
  }

  // load card view
  loadCardView(MFInitiateSessionResponse session) async {
    try {
      await mfCardView.load(session, (bin) {
        log(bin);
      });
    } catch (e) {
      print('mf Card View error ---> $e');
    }
  }

  // load every payment method
  loadEmbeddedPayment(
      MFInitiateSessionResponse session, BuildContext context) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: amount);
    executePaymentRequest.displayCurrencyIso = displayCurrencyIso;
    if (Platform.isIOS) {
      applePayPayment(session, Get.context!);
      MFApplepay.setupApplePay(
          session, executePaymentRequest, MFLanguage.ENGLISH);
    }
    try {
      await loadCardView(session);
    } catch (e) {
      print('load card view error ---> $e');
    }

  }

  // openPaymentSheet() {
  //   if (Platform.isIOS) {
  //     MFApplepay.executeApplePayPayment()
  //         .then((value) => log(value))
  //         .catchError((error) => {log(error.message)});
  //   }
  // }

  // get amount form main screens
  getAmount(double val,{bool notify=true}) {
    _amount = val;
    if(notify){
    notifyListeners();
    }
  }

  // update apple pay amount
  updateAmount() {
    if (Platform.isIOS) MFApplepay.updateAmount(_amount);
  }

  // only ref apple pay
  refApplePay(BuildContext context) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: amount);
    executePaymentRequest.displayCurrencyIso = displayCurrencyIso;

    await mfApplePayButton.applePayPayment(
        executePaymentRequest, MFLanguage.ENGLISH, (invoiceId) {
      log(invoiceId);
    }).then((value) {
      checkPayment(
          value.invoiceId.toString(),
          value.invoiceReference.toString(),
          '11',
          amount.toString(),
          type,
          id,
          context);
    }).catchError((error) {
      log(error.message);
    });
  }

  // init apple pay and ref it
  applePayPayment(
      MFInitiateSessionResponse session, BuildContext context) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: amount);
    executePaymentRequest.displayCurrencyIso = displayCurrencyIso;

    await mfApplePayButton
        .displayApplePayButton(
            session, executePaymentRequest, MFLanguage.ENGLISH)
        .then((value) => {
              // value.
              log(value),
              mfApplePayButton
                  .executeApplePayButton(null, (invoiceId) => log(invoiceId))
                  .then((value) {
                checkPayment(
                    value.invoiceId.toString(),
                    value.invoiceReference.toString(),
                    '11',
                    amount.toString(),
                    type,
                    id,
                    context);
                initiateSession();
                return log(value);
              }).catchError((error) => {log(error.message)})
            })
        .catchError((error) => {log(error.message)});
  }

  // init session id for each buy
  initiateSession() async {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest();
    await MFSDK
        .initiateSession(initiateSessionRequest, (bin) {
          log(bin);
        })
        .then((value) => {log(value)})
        .catchError((error) => {log(error.message)});
  }

  // pay fun (connect with my fatora then check if payment done or not)
 Future<bool> pay(BuildContext context) async {
   print(amount);

    var executePaymentRequest = MFExecutePaymentRequest(invoiceValue: amount);
    executePaymentRequest.displayCurrencyIso = displayCurrencyIso;
    await mfCardView.pay(executePaymentRequest, MFLanguage.ENGLISH,
        (invoiceId) {
      debugPrint("-----------$invoiceId------------");
      log(invoiceId);

    }).then((value)async {
      // mfCardView.

      print('pay invoiceId ----> ${value.invoiceId}');
      getPaymentStatus(value.invoiceId!.toString());
   // try{
     await   checkPayment(
         value.invoiceId.toString(),
         value.invoiceReference.toString(),
         '6',
         amount.toString(),
         type,
         id,
         context).then((value) {
       _callback(true,'نجح الدفع','',type=='wallet_charge'?true:false);

         });

      initiateSession();
      return true;
    }).catchError((error) async{
print('asdasdasldjhasdljashdlajsdhlajsdhaljshdlahjd}');
    try{
      await initiate(context);
      notifyListeners();
      print('pay error message ----> ${error.message}');
      if (error.message
          .toString()
          .compareTo('Card details are invalid or missing!') ==
          0) {
        showCustomSnackBar(
            getTranslated('Card_details_are_invalid_or_missing', Get.context!),
            Get.context!,
            isError: true);
      } else {
        showCustomSnackBar(getTranslated(error.message, Get.context!), Get.context!,
            isError: true);
        initiateSession();
      }
      return false;
    }catch(e){
      return false;

    }
    });
   return false;

  }

  // check payment result by api with my fatoora
  Future checkPayment(
      String invoiceId,
      String invoiceReference,
      String paymentMethod,
      String paymentAmount,
      String type,
      String id,

      BuildContext context) async {
  PaymentModel paymentModel =PaymentModel(invoiceId, invoiceReference, paymentMethod, paymentAmount, type,id);
ApiResponse response= await paymentServiceInterface.checkPayment(paymentModel);

if(response.response!=null&&response.response!.statusCode==201||response.response!.statusCode==200){
  print(response.response!.data);
  _callback(true,'نجح الدفع','',type=='wallet_charge'?true:false);
  return true;
}else{
  print(response.error);

  _callback(false,'فشل الدفع','',type=='wallet_charge'?true:false);
  return false;


}
  }

  validate() async {
    await mfCardView
        .validate()
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
    // mfCardView.
  }

  Widget build(BuildContext context, bool wallet, bool applePay) {
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());

    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
    mfApplePayButton.applePayStyle!.height = 45;
    return embeddedCardView(wallet, applePay);
  }

  Widget embeddedCardView(bool wallet, bool applePay) {
    return SizedBox(
      height: applePay == false ? 200 : 70,

      child: Column(
        children: [
          wallet == true
              ? Consumer<OrderController>(
                  builder: (context, order, child) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: TextEditingController(),
                            // focusNode: balanceNode,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                            ),
                            // keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.done,
                            textDirection: TextDirection.ltr,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // FilteringTextInputFormatter.
                              FilteringTextInputFormatter.allow(
                                  RegExp("[1-1234567890-9]"))
                            ],
                            decoration: const InputDecoration(
                              // enabledBorder: InputBorder.none,
                              border: InputBorder.none,

                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              hintText: "الرصيد المراد شحنه",

                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),

                            onSaved: (val) {},
                            onChanged: (value) {
                              // MFInitiateSessionResponse se
                              // Provider.of<CheckoutController>(context,
                              // listen: false)
                              //     .getPrice(value);

                              if (value != '') {
                                getAmount((double.parse(value) /
                                    Provider.of<SplashController>(context,
                                            listen: false)
                                        .myCurrency!
                                        .exchangeRate));
                                updateAmount();
                                refApplePay(context);
                                initiate(context);
                              }
                            },
                            onFieldSubmitted: (value) {
                              // Provider.of<CheckoutController>(context,
                              // listen: false)
                              //     .getPrice(value);

                              if (value != '') {
                                getAmount((double.parse(value) /
                                    Provider.of<SplashController>(context,
                                            listen: false)
                                        .myCurrency!
                                        .exchangeRate));
                                updateAmount();
                                refApplePay(context);
                              }
                            },
                          ),
                        ),
                      ))
              : const SizedBox.shrink(),
          SizedBox(
              height: applePay == false ? 200 : 70,
              child: applePay == false ? mfCardView : applePayView()),

          // elevatedButton("Pay", pay),
        ],
      ),
    );
  }

  // apple apy view
  Widget applePayView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
          child: SizedBox(
            height: 50,
            child: mfApplePayButton,
          ),
        )
      ],
    );
  }

  List<PaymentMethod> _paymentMethod = [];

  List<PaymentMethod> get paymentMethod => _paymentMethod;

// get payment method
  Future getPaymentMethod(BuildContext context, String type,{bool notify=true}) async {
    _paymentMethod = [];
    ConfigModel configModel =
        Provider.of<SplashController>(context, listen: false).configModel!;
    if (configModel.paymentMethods.fatoorah.enabled == 1) {
      _paymentMethod.add(PaymentMethod(configModel.paymentMethods.fatoorah.name,
          configModel.paymentMethods.fatoorah.logo, 0));
    }
    if (configModel.paymentMethods.fatoorah.enabled == 1 && Platform.isIOS) {
      _paymentMethod.add(PaymentMethod('Apple_pay', Images.applePay, 1));
    }
    if (configModel.paymentMethods.cashOnDelivery.enabled && type != 'wallet_charge') {
      _paymentMethod.add(PaymentMethod(
          configModel.paymentMethods.cashOnDelivery.name,
          configModel.paymentMethods.cashOnDelivery.logo,
          2));
    }
    if (configModel.paymentMethods.bankTransfer.enabled == 1 &&
        type != 'wallet_charge') {
      _paymentMethod.add(PaymentMethod(
          configModel.paymentMethods.bankTransfer.name,
          configModel.paymentMethods.bankTransfer.logo,
          3));
    }
    if (configModel.paymentMethods.wallet.enabled && type != 'wallet_charge') {
      _paymentMethod.add(PaymentMethod(configModel.paymentMethods.wallet.name,
          configModel.paymentMethods.wallet.logo, 4));
    }
    if (configModel.paymentMethods.delayed.enabled && type != 'wallet_charge') {
      _paymentMethod.add(PaymentMethod(configModel.paymentMethods.delayed.name,
          configModel.paymentMethods.delayed.logo, 5));
    }
    for (var element in _paymentMethod) {
      print('_paymentMethod name --> ${element.name}');
    }
   if(notify){
     notifyListeners();
   }
  }

  String _displayCurrencyIso = '';

  String get displayCurrencyIso => _displayCurrencyIso;
  bool _isEnable = false;

  bool get isEnable => _isEnable;

  void getCurrencyIso(CurrencyList currency, BuildContext context) {
    if (currency.code == 'USD') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;
      _isEnable = false;
    } else if (currency.code == 'BDT') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;
      _isEnable = false;
    } else if (currency.code == 'INR') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;
      _isEnable = false;
    } else if (currency.code == 'EUR') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

      _isEnable = false;
    } else if (currency.code == 'JPY') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;
      _isEnable = false;
    } else if (currency.code == 'SAR') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;
      _isEnable = true;
    } else if (currency.code == 'AED') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

      _isEnable = false;
    } else if (currency.code == 'KWD') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

      _isEnable = false;
    } else if (currency.code == 'BHD') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

      _isEnable = false;
    } else if (currency.code == 'OMR') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

      _isEnable = false;
    } else if (currency.code == 'EGP') {
      _displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

      _isEnable = false;
    }
    notifyListeners();
    print('_displayCurrencyIso ---> $_displayCurrencyIso');
  }
  void _callback(bool isSuccess, String message, String orderID, bool createAccount) async {

    if(isSuccess) {
      if(type=='order'){
        Provider.of<CartController>(Get.context!,listen: false).getCartData(Get.context!);
      }
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
      showAnimatedDialog(Get.context!, OrderPlaceDialogWidget(
        icon: Icons.check,
        title: getTranslated(createAccount ? 'The_balance_has_been_added_successfully' : 'order_placed', Get.context!),
        description:createAccount?'': getTranslated('your_order_placed', Get.context!),
        isFailed: false,
      ), dismissible: false, willFlip: true);
    }else {
      showCustomSnackBar(message, Get.context!, isToaster: true);
    }
  }

}
