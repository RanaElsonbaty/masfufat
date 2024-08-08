import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
// import 'package:location_permissions/location_permissions.dart';

import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_webservice/places.dart' as places;
import 'package:location/location.dart';
import '../domain/models/prediction_model.dart';
import '../domain/services/location_service_interface.dart';

class LocationController with ChangeNotifier {
  final LocationServiceInterface locationServiceInterface;
  LocationController({required this.locationServiceInterface});



  Position _position = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1,
    altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1, );
  Position _pickPosition = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(),
      accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1);
  bool _loading = false;
  bool get loading => _loading;
  bool _isBilling = true;
  bool get isBilling =>_isBilling;
  final TextEditingController _locationController = TextEditingController();

  Position get position => _position;
  Position get pickPosition => _pickPosition;
  geocoding.Placemark _address = const geocoding.Placemark();
  geocoding. Placemark? _pickAddress = const geocoding.Placemark();

  geocoding.Placemark get address => _address;
  geocoding.Placemark? get pickAddress => _pickAddress;

  TextEditingController get locationController => _locationController;


  bool _buttonDisabled = true;
  bool _changeAddress = true;
  GoogleMapController? _mapController;
  List<PredictionModel> _predictionList = [];
  bool _updateAddAddressData = true;

  bool get buttonDisabled => _buttonDisabled;
  GoogleMapController? get mapController => _mapController;

  void setLocationController(String text) {
    _locationController.text = text;
  }



  // void getCurrentLocation(BuildContext context, bool fromAddress, {GoogleMapController? mapController}) async {
  //   _loading = true;
  //   notifyListeners();
  //   Position myPosition;
  //   try {
  //     Position newLocalData = await Geolocator.getCurrentPosition();
  //     myPosition = newLocalData;
  //   }catch(e) {
  //     myPosition = Position(
  //       latitude: double.parse('0'),
  //       longitude: double.parse('0'),
  //       timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1,
  //     );
  //   }
  //   if(fromAddress) {
  //     _position = myPosition;
  //   }else {
  //     _pickPosition = myPosition;
  //   }
  //   if (mapController != null) {
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(myPosition.latitude, myPosition.longitude), zoom: 17),
  //     ));
  //   }
  //   geocoding.Placemark myPlaceMark;
  //   try {
  //       String address = await getAddressFromGeocode(LatLng(myPosition.latitude, myPosition.longitude), Get.context!);
  //       myPlaceMark =geocoding. Placemark(name: address, locality: '', postalCode: '', country: '');
  //
  //   }catch (e) {
  //     String address = await getAddressFromGeocode(LatLng(myPosition.latitude, myPosition.longitude),  Get.context!);
  //     myPlaceMark = geocoding.Placemark(name: address, locality: '', postalCode: '', country: '');
  //   }
  //   fromAddress ? _address = myPlaceMark : _pickAddress = myPlaceMark;
  //   if(fromAddress) {
  //     _locationController.text = placeMarkToAddress(_address);
  //   }
  //   _loading = false;
  //   notifyListeners();
  // }

  void updateMapPosition(CameraPosition? position, bool fromAddress, String? address, BuildContext context) async {
    if(_updateAddAddressData) {
      _loading = true;
      // notifyListeners();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position!.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1,altitudeAccuracy: 1, headingAccuracy: 1);
        } else {
          _pickPosition = Position(
            latitude: position!.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1,altitudeAccuracy: 1, headingAccuracy: 1);
        }
        if (_changeAddress) {
            String? addresss = await getAddressFromGeocode(LatLng(position.target.latitude, position.target.longitude), context);
            fromAddress ? _address = geocoding.Placemark(name: addresss) : _pickAddress = geocoding.Placemark(name: addresss);

          if(address != null) {
            _locationController.text = address;
          }else if(fromAddress) {
            _locationController.text = placeMarkToAddress(_address);
          }
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      _loading = false;
      notifyListeners();
    }else {
      _updateAddAddressData = true;
    }
  }


  void setLocation(String? placeID, String? address, GoogleMapController? mapController) async {
    _loading = true;
    notifyListeners();

    // _pickPosition = Position(
      // longitude: detail.result?.geometry?.location?.lat??0, latitude: detail.result?.geometry?.location?.lng??0,
      // timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1,
      //   speedAccuracy: 1,altitudeAccuracy: 1, headingAccuracy: 1);

    _pickAddress =geocoding. Placemark(name: address);
    _changeAddress = false;

    // if(mapController != null) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
    //     detail.result?.geometry?.location?.lat??0, detail.result?.geometry?.location?.lng??0), zoom: 16)));
    // }
    _loading = false;
    notifyListeners();
  }

  void disableButton() {
    _buttonDisabled = true;
    notifyListeners();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _address = _pickAddress!;
    _locationController.text = placeMarkToAddress(_address);
    _updateAddAddressData = false;
    notifyListeners();
  }

  void setPickData() {
    _pickPosition = _position;
    _pickAddress = _address;
    _locationController.text = placeMarkToAddress(_address);
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<String> getAddressFromGeocode(LatLng latLng, BuildContext context) async {
    ApiResponse response = await locationServiceInterface.getAddressFromGeocode(latLng);
    String address = '';
    if(response.response!.statusCode == 200 && response.response!.data['status'] == 'OK') {
      address = response.response!.data['results'][0]['formatted_address'].toString();
    }
    return address;
  }

  Future<List<PredictionModel>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty) {
      ApiResponse response = await locationServiceInterface.searchLocation(text);
      if (response.response!.statusCode == 200 && response.response!.data['status'] == 'OK') {
        _predictionList = [];
        response.response!.data['predictions'].forEach((prediction) => _predictionList.add(PredictionModel.fromJson(prediction)));
      } else {
        ApiChecker.checkApi( response);
      }
    }
    return _predictionList;
  }

  String placeMarkToAddress(geocoding.Placemark placeMark) {
    return '${placeMark.name ?? ''} ${placeMark.subAdministrativeArea ?? ''} ${placeMark.isoCountryCode ?? ''}';
  }

  void isBillingChanged(bool change) {
    _isBilling = change;
    if (change) {
      change = !_isBilling;
    }
    notifyListeners();
  }


// google map
  GoogleMapController? controller;
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
    _pickPosition=Position(longitude: longitude, latitude: latitude, timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1);
    // latitude=
    // lan.text=detail.result.geometry!.location.lng.toString();
    // lot.text=detail.result.geometry!.location.lat.toString();
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
  Future<void> getCurrentLocation() async {
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
  Future<Position> getLocation()async {
    // Test if location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(Exception('Location permissions are permanently denied.'));
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(Exception('Location permissions are denied.'));
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocations(BuildContext context, ) async {
    notifyListeners();
    Position myPosition;
    // try {
      Position newLocalData = await getLocation();
      myPosition = newLocalData;
    // }catch(e) {
      // myPosition = Position(
      //   latitude: double.parse('0'),
      //   longitude: double.parse('0'),
      //   timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1,
      // );
    // }
    // pickPosition = myPosition;
    if (controller != null) {
      controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(myPosition.latitude, myPosition.longitude), zoom: 17),
      ));
    }
    // Placemark myPlaceMark;

    notifyListeners();
  }

}
