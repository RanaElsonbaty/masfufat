import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/domain/models/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/domain/models/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/domain/models/social_login_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/domain/services/auth_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
// Add this for path operations

import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_webservice/places.dart' as places;
import 'package:location/location.dart';

class AuthController with ChangeNotifier {
  final AuthServiceInterface authServiceInterface;
  AuthController( {required this.authServiceInterface});
  final TextEditingController companyName = TextEditingController();
  final TextEditingController licenseHolderName = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FocusNode fNameFocus = FocusNode();
  final FocusNode lNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  // sec
  final TextEditingController commercialRegistrationNo = TextEditingController();
  final TextEditingController taxNumber = TextEditingController();
  final TextEditingController storeLink = TextEditingController();
  final TextEditingController governorate = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController lan = TextEditingController();
  final TextEditingController lot = TextEditingController();
  File? storeImage;
  File? commercialRegisterImage;
  File? certificateImage;
  final TextEditingController walletCouponCode = TextEditingController();

  final FocusNode commercialRegistrationNoFocus = FocusNode();
  final FocusNode taxNumberFocus = FocusNode();
  final FocusNode storeLinkFocus = FocusNode();
  final FocusNode governorateFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode lanFocus = FocusNode();
  final FocusNode lotFocus = FocusNode();
  final FocusNode walletCouponCodeFocus = FocusNode();

  void pickImage(bool isRemove,int? index,File file) async {
// print('asdasdadsasd${file.path}');

// File files = File(file.path);
// String fileName = files.path.;
//
// print(fileName);
if(isRemove) {
      if(index != null){
      }
    }else {
      if(index==0){
      storeImage =file;
      // await ImagePicker().pickImage(imageQuality: 40, source: ImageSource.gallery,requestFullMetadata: true);
      }else if(index ==1){
        commercialRegisterImage =file;

        // await ImagePicker().pickImage(imageQuality: 40, source: ImageSource.gallery);

      }else {
        certificateImage = file;
        // await ImagePicker().pickImage(imageQuality: 40, source: ImageSource.gallery);

      }
      // pickedImageFileStored.addAll(_pickedImageFiles);
    }
    notifyListeners();

  }

int _pageIndex=0;
int get pageIndex=>_pageIndex;
void initPageIndex (bool first){
  _pageIndex =first?0:1;
  notifyListeners();
  }


  bool _isLoading = false;
  bool? _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  bool _isAcceptTerms = false;
  bool get isAcceptTerms => _isAcceptTerms;


  String countryDialCode = '+966';
  void setCountryCode( String countryCode, {bool notify = true}){
    countryDialCode  = countryCode;
    if(notify){
      // notifyListeners();
    }
  }

  updateSelectedIndex(int index, {bool notify = true}){
    _selectedIndex = index;
    if(notify){
      notifyListeners();
    }

  }


  bool get isLoading => _isLoading;
  bool? get isRemember => _isRemember;

  void updateRemember() {
    _isRemember = !_isRemember!;
    notifyListeners();
  }

  Future<void> socialLogin(SocialLoginModel socialLogin, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authServiceInterface.socialLogin(socialLogin.toJson());
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      _isLoading = false;
      Map map = apiResponse.response!.data;
      String? message = '', token = '', temporaryToken= '';
      try{
        message = map['error_message'];
        token = map['token'];
        temporaryToken = map['temporary_token'];
      }catch(e){
        message = null;
        token = null;
        temporaryToken = null;
      }

      if(token != null){
        authServiceInterface.saveUserToken(token);
        await authServiceInterface.updateDeviceToken();
        // setCurrentLanguage(Provider.of<LocalizationController>(Get.context!, listen: false).getCurrentLanguage()??'en');
      }
      callback(true, token,temporaryToken,message );
    } else {
      _isLoading = false;
     ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    print(register.toJson());
    ApiResponse apiResponse = await authServiceInterface.registration(register.toJson());
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      print(apiResponse.response!.data);
      Map map = apiResponse.response!.data;
      String? temporaryToken = '', token = '', message = '';
      try{
        message = map["message"];
        token = map["token"];
        temporaryToken = map["temporary_token"];
      }catch(e){
        message = null;
        token = null;
        temporaryToken = null;
      }
      if(token != null && token.isNotEmpty){
        print('token ------> $token');
       await authServiceInterface.saveUserToken(token);
        await authServiceInterface.updateDeviceToken();
       notifyListeners();
        callback(true, token, temporaryToken, message);

      }
      notifyListeners();
    }else{
      Map map = apiResponse.response!.data;

      callback(false, '', '', '${map['errors'][0]['code']} ${map['errors'][0]['message']}');
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }



  Future logOut() async {
  try{
    ApiResponse apiResponse = await authServiceInterface.logout();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

    }
  }catch(e){

  }
  }

  // Future<void> setCurrentLanguage(String currentLanguage) async {
  //   ApiResponse apiResponse = await authServiceInterface.setLanguageCode(currentLanguage);
  //   if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  //
  //   }
  // }



  Future<void> login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authServiceInterface.login(loginBody.toJson());
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      clearGuestId();
      Map map = apiResponse.response!.data;
      String? temporaryToken = '', token = '', message = '';
      try{
        message = map["message"];
        token = map["token"];
        temporaryToken = map["temporary_token"];
      }catch(e){
        message = null;
        token = null;
        temporaryToken = null;
      }
      if(token != null && token.isNotEmpty){
        authServiceInterface.saveUserToken(token);
        await authServiceInterface.updateDeviceToken();
      }
      callback(true, token, temporaryToken, message);
      notifyListeners();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  Future<void> updateToken(BuildContext context) async {
    ApiResponse apiResponse = await authServiceInterface.updateDeviceToken();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }


  Future<ApiResponse> sendOtpToEmail(String email, String temporaryToken, {bool resendOtp = false}) async {
    _isPhoneNumberVerificationButtonLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    if(resendOtp){
      apiResponse = await authServiceInterface.resendEmailOtp(email,temporaryToken);
    }else{
      apiResponse = await authServiceInterface.sendOtpToEmail(email,temporaryToken);
    }
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      resendTime = (apiResponse.response!.data["resend_time"]);
    } else {
     ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> verifyEmail(String email, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authServiceInterface.verifyEmail(email, _verificationCode, token);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      authServiceInterface.saveUserToken(apiResponse.response!.data['token']);
      await authServiceInterface.updateDeviceToken();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  int resendTime = 0;

  Future<ResponseModel> sendOtpToPhone(String phone, String temporaryToken,{bool fromResend = false}) async {
    _isPhoneNumberVerificationButtonLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    if(fromResend){
      apiResponse = await authServiceInterface.resendPhoneOtp(phone, temporaryToken);
    }else{
      apiResponse = await authServiceInterface.sendOtpToPhone(phone, temporaryToken);
    }
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data["token"],true);
      resendTime = (apiResponse.response!.data["resend_time"]);
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }
      responseModel = ResponseModel( errorMessage,false);
    }
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> verifyPhone(String phone, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authServiceInterface.verifyPhone(phone, token, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    }
    else {
      _isPhoneNumberVerificationButtonLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> verifyOtpForResetPassword(String email,String otp) async {
    _isPhoneNumberVerificationButtonLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await authServiceInterface.verifyOtp(email, otp);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    } else {
      _isPhoneNumberVerificationButtonLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<ApiResponse> resetPassword(String identity, String otp, String password, String confirmPassword) async {
    _isPhoneNumberVerificationButtonLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authServiceInterface.resetPassword(identity,otp,password,confirmPassword);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      showCustomSnackBar(getTranslated('password_reset_successfully', Get.context!), Get.context!,isError: false);
      Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
    } else {
      _isPhoneNumberVerificationButtonLoading = false;
    try{
      ApiChecker.checkApi(apiResponse);
    }catch(e){
      showCustomSnackBar(getTranslated('failed', Get.context!), Get.context!);
    }
    }
    notifyListeners();
    return apiResponse;
  }



  // for phone verification
  bool _isPhoneNumberVerificationButtonLoading = false;
  bool get isPhoneNumberVerificationButtonLoading => _isPhoneNumberVerificationButtonLoading;
  String _email = '';
  String _phone = '';

  String get email => _email;
  String get phone => _phone;

  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }
  updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }



  String _verificationCode = '';
  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;
  bool get isEnableVerificationCode => _isEnableVerificationCode;

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }



  String getUserToken() {
    return authServiceInterface.getUserToken();
  }

  String? getGuestToken() {
    return authServiceInterface.getGuestIdToken();
  }


  bool isLoggedIn() {
    return authServiceInterface.isLoggedIn();
  }

  bool isGuestIdExist() {
    return authServiceInterface.isGuestIdExist();
  }

  Future<bool> clearSharedData()  {
    return authServiceInterface.clearSharedData();
  }

  Future<bool> clearGuestId() async {
    return await authServiceInterface.clearGuestId();
  }


  void saveUserEmail(String email, String password) {
    authServiceInterface.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authServiceInterface.getUserEmail();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authServiceInterface.clearUserEmailAndPassword();
  }


  String getUserPassword() {
    return authServiceInterface.getUserPassword();
  }

  Future<ApiResponse> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authServiceInterface.forgetPassword(email.replaceAll('+', ''));
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      showCustomSnackBar(apiResponse.response?.data['message'], Get.context!, isError: false);
    }
    else {
      _isLoading = false;
      showCustomSnackBar(getTranslated('Account_not_found', Get.context!), Get.context!, isError: true);

      // ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;

  }


  Future<void> getGuestIdUrl() async {
    // ApiResponse apiResponse = await authServiceInterface.getGuestId();
    // if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    //   authServiceInterface.saveGuestId(apiResponse.response!.data['guest_id'].toString());
    // } else {
    //   ApiChecker.checkApi( apiResponse);
    // }
    // notifyListeners();
  }

  void toggleTermsCheck() {
    _isAcceptTerms = !_isAcceptTerms;
    notifyListeners();
  }

// google map
  GoogleMapController? controller;
  final TextEditingController locationController = TextEditingController();
  CameraPosition? cameraPosition=const CameraPosition(target: LatLng(0.0,0.0));
  List<geocoding.Placemark> ?placemarks;
  Location location = Location();
  final Map<String, Marker> _markers = {};
  String searchResult='';
  double latitude = 0;
  double longitude = 0;

  Future<void> handleSearch() async {
    places.Prediction? p = await loc.PlacesAutocomplete.show(
        context: Get.context!,
        apiKey: 'AIzaSyC2BO1gDok2Pt8pa-MFypDjiOnfZjZWruc',
        onError: onError, // call the onError function below
        mode: loc.Mode.overlay,
        language: 'en', //you can set any language for search
        strictbounds: false,
        types: [],

        decoration: InputDecoration(
            hintText: 'search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [

        ]// you can determine search for just one country
    );

    // p.
    displayPrediction(p!, ScaffoldState());
    notifyListeners();

  }

  void onError(places.PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
    notifyListeners();

  }

  Future<void> displayPrediction(
      places.Prediction p, ScaffoldState? currentState) async {
    places.GoogleMapsPlaces placess = places.GoogleMapsPlaces(
        apiKey: 'AIzaSyC2BO1gDok2Pt8pa-MFypDjiOnfZjZWruc',
        apiHeaders: await const header.GoogleApiHeaders().getHeaders());
    places.PlacesDetailsResponse detail =
    await placess.getDetailsByPlaceId(p.placeId!);
    cameraPosition =CameraPosition(target: LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng));
  controller!.animateCamera(CameraUpdate.newLatLng(LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng)));
    notifyListeners();

    placemarks = await geocoding.placemarkFromCoordinates(detail.result.geometry!.location.lat,  detail.result.geometry!.location.lng);
    print('placeId ---> ${detail.result.placeId}');
      longitude=detail.result.geometry!.location.lng;
      latitude=detail.result.geometry!.location.lat;
      searchResult=placemarks!.first.street!;
      lan.text=detail.result.geometry!.location.lng.toString();
      lot.text=detail.result.geometry!.location.lat.toString();
      notifyListeners();
    _markers.clear(); //clear old marker and set new one
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(detail.result.geometry!.location.lat,  detail.result.geometry!.location.lng),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    // setState(() {
      _markers['myLocation'] = marker;
      controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng), zoom: zoom),
        ),

      );
      notifyListeners();
    // });
  }
  getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    try{
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          print('object');
          return;
        }
      }

    }catch(e){
      print('object');

    }


    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('object');

        return;
      }
    }

    LocationData currentPosition = await location.getLocation();
    latitude = currentPosition.latitude!;
    longitude = currentPosition.longitude!;
    final marker = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(
        title: 'you can add any message here',
      ),
    );
    // setState(() {
      _markers['myLocation'] = marker;
      controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 10),
        ),

      );
    cameraPosition=CameraPosition(target: LatLng(latitude, longitude), zoom: 10);

    notifyListeners();

  }
  double _zoom =15;
  double get zoom =>_zoom;
  void getZoom(bool add){
    if(add){
      _zoom=_zoom+5.0;

    }else{
      _zoom=_zoom-5.0;

    }

    cameraPosition=CameraPosition(target: LatLng(latitude, longitude), zoom: zoom);

    notifyListeners();
  }
bool _consent=false;
bool get consent=>_consent;
void getConsent(){
  _consent=!_consent;
  notifyListeners();
}
  void getCurrentLocations(BuildContext context, ) async {
    notifyListeners();
    Position myPosition;
    try {
      Position newLocalData = await Geolocator.getCurrentPosition();
      myPosition = newLocalData;
    }catch(e) {
      myPosition = Position(
        latitude: double.parse('0'),
        longitude: double.parse('0'),
        timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1,
      );
    }
    // pickPosition = myPosition;
    if (controller != null) {
      controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(myPosition.latitude, myPosition.longitude), zoom: 17),
      ));
    }
    // Placemark myPlaceMark;

    notifyListeners();
  }
  bool _showGoogleMap=false;
  bool get showGoogleMap=>_showGoogleMap;
  void showMap(){
    _showGoogleMap =!_showGoogleMap;
    notifyListeners();
  }
  void saveToken()async{
    await authServiceInterface.saveUserToken('eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiNzU1NWI5MWRjNGU5YTdhZTZiN2E3OTk2YzRmZDAwMjdkNjkxZGYzMDdiM2IxNjc0M2M2NzMwOWU5OWE2MmU1NDcyYmVkNjQ2ZDhkYzhkYTgiLCJpYXQiOjE3MzE4MjU5ODkuNzYzMjk0LCJuYmYiOjE3MzE4MjU5ODkuNzYzMjk5LCJleHAiOjE3NjMzNjE5ODkuNzUzMzA2LCJzdWIiOiIxNTAxMCIsInNjb3BlcyI6W119.M8QTqaJ7EXchB6-ViYOFfFIZOxjRfW4xsX2can8t3daF3Jp2m06LzBWZY-hsHNiwuIis8EekHP_PppXR4WTnYnCNpwWtQ0PsjkHE4kgDELTK1hzeG-GTRlvuQacdbeTbp5fIa0-Nn5hwQpIc-ACIJAzWPiKplEhcQOdmocflNkjCbQyUo_T6cYBpGd0VpzxceG5-vvaoJeYtkOEaaemJ81jFQ_PB0jkZckm2CMM3AFm9kuKy46mOJn9Czhaex91l1ADnTB5TJLIhuXuJH8dSBXo-0dZHUfZvRh2F5r-3H0u-8tfTCDYRLQskHaMvWlbOMxOdJg0Wme0Cgb93khUqT8-CTMUkajXdG4izqwaURZM5UlDosLRPaJvomU9BnC2TlSWyHFz71CtxlMcFE_FHsT0iCoOUMNDeAvuwkDLfc16nUO947Nr8n9thzBUazIvcu8co6RqzJ2lhW1FrPr1aIMY5rNjSN2r10YsqIRPDz3CSEPLetvMFTMLWd-0VV2xdElrCtpwbTW1wHqF2sMML_HIPh_d5DZDwrPUExGrNjNjIrby-J4VmfG2hC80M_AWtEWSAfbM_4DvSGAPqqmzA5lmt4vJLXs7zF1ORmG5m4bxi5t4z6GHseI2YGvXX_0d-XiXC8FiprvWvDcvms-PB47iTFn4gZ0KyGBrgvN-jPLw');
    await authServiceInterface.updateDeviceToken();
    notifyListeners();
  }

}

