import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/location/controllers/location_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:provider/provider.dart';
import '../../address/screens/add_new_address_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:location_permissions/location_permissions.dart';

import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_webservice/places.dart' as places;

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../localization/language_constrants.dart';
import '../../../utill/dimensions.dart';
import '../../address/domain/models/address_model.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key, required this.edit, this.address});

  final bool edit;
  final AddressModel? address;

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  double lon = 	46.738586;
  double lat =	24.774265;
  GoogleMapController? mapController;
  List<geocoding.Placemark> ?placemarks;
  Location location = Location();
  final Map<String, Marker> _markers = {};

  String searchResult='';

  bool locationEdit=false;
  @override
  void initState() {
    // mapController!.l
          getCurrentLocation();

    initLocation();

    super.initState();
  }

  void initLocation() async {
    await askingPermission();
    await Future.delayed(const Duration(milliseconds: 100));
    if (widget.edit) {
      getEditLocation();
    } else {
      // lat=0.000;
      // lon=0.000;
      // getUserLocation();
    }
  }

  void getEditLocation() {
    lon = double.parse(widget.address!.longitude!);
    lat = double.parse(widget.address!.latitude!);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(
            lat,
            lon,
          ),
          zoom: 15),
    ));
  }
  bool isMoving = false;
  // void getUserLocation() {}
  void getLocationName()async{

    if(isMoving ==false){
      print('getLocationName start');

    try{
      placemarks = await geocoding.placemarkFromCoordinates(lat,  lon);
      setState(() {

        searchResult=placemarks!.first.street!;
      });
    }catch(e){
      print(e)
      ;             }
    }
  }
    double zoom =5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: getTranslated('select_delivery_address', context)),
        body: Stack(children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(target: LatLng(lat, lon),zoom: 5),
            myLocationButtonEnabled: false,
            onLongPress: (argument) {
              locationEdit=true;

            },
            onCameraMove: (position) async{
              setState(() {
                isMoving = true;
                lat =position.target.latitude;
                lon =position.target.longitude;
              });



            // الون - #000011

            },
            onCameraIdle:  () {
              setState(() {
                isMoving = false;
              });
              getLocationName();


            },
            onMapCreated: (controller) {
              mapController = controller;
            },
          ),
          InkWell(onTap: () =>
           handleSearch(), child: Container(width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: 18.0),
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge+25, vertical: 23.0),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                  child: Row(children: [
                     Image.asset(Images.searchIcon,width: 20,color: Theme.of(context).iconTheme.color,)
                    ,
                    const SizedBox(width: 3,),
                    Expanded(child: Text(
                        searchResult!=''?searchResult:'search'
                    , maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ]))),
          Center(
              child: Icon(Icons.location_on,
                  color: Theme.of(context).primaryColor, size: 50)),
          Positioned(
            bottom: 83,
            right: 15,
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      getCurrentLocations(context);
                      locationEdit=true;
                      zoom=17;


                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        // margin: const EdgeInsets.only(
                        //     right: Dimensions.paddingSizeLarge),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                               4),
                            color: Theme.of(context).primaryColor),
                        child: const Icon(Icons.my_location,
                            color: Colors.white, size: 25))),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Consumer<LocationController>(
                      builder:(context, locationController, child) =>  CustomButton(
                        buttonText: getTranslated('select_location', context),
                        fontSize: 20,

                        backgroundColor: Theme.of(context).primaryColor,
                        onTap: () async{
                          locationController.getPosition(CameraPosition(target: LatLng(lat, lon)));
                          try{
                            placemarks = await geocoding.placemarkFromCoordinates(lat,  lon);

                            Navigator.of(Get.context!).push(MaterialPageRoute(builder: (_) =>
                                AddNewAddressScreen(editLocation: locationEdit,placemarks: placemarks??[],isEnableUpdate: widget.edit,fromCheckout: false,address: widget.address,isBilling: false,)));
                      //
                          }catch(e){
                            Navigator.of(Get.context!).push(MaterialPageRoute(builder: (_) =>
                                AddNewAddressScreen(editLocation: locationEdit,placemarks: placemarks??[],isEnableUpdate: widget.edit,fromCheckout: false,address: widget.address,isBilling: false,)));
                          }
                        },
                      ),
                    )),
              )),
          Positioned(
            left: 15,
              bottom: 70,
              child: SizedBox(
                height: 120,
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15,),

                  InkWell(
                      onTap: (){
                        setState(() {
                          zoom+=1;

                        });
                        mapController!.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(
                                lat,
                                lon,
                              ),
                              zoom: zoom),
                        ));
                      },
                      child: Container(
                        height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x73000000),
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              )
                            ]
                          ),

                          child: const Icon(Icons.add))),

const SizedBox(height: 5,),
                  InkWell(
                      onTap: (){
setState(() {
  zoom-=1;

});                        mapController!.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(
                                lat,
                                lon,
                              ),
                              zoom: zoom),

                        ));
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x73000000),
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                )
                              ]
                          ),
                          child: const Center(child: Text('-',

                            style: TextStyle(
                            fontSize: 30,
                            height: 0.5,

                          ),)))),
                    const SizedBox(height: 20,),

                ],),
              ))
        ]));
  }

  Future<bool> askingPermission() async {
    await permission.Permission.camera.request();
    if (await permission.Permission.camera.isDenied) {
      return false;
    } else {
      return true;
    }
  }
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    await askingPermission();
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
  final marker = Marker(
    markerId: const MarkerId('myLocation'),
    position: LatLng(currentPosition.latitude!, currentPosition.longitude!),
    infoWindow: const InfoWindow(
      title: '',
    ),
  );

  _markers['myLocation'] = marker;
  mapController?.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(currentPosition.latitude!, currentPosition.longitude!), zoom: 10),
    ),

  );




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

    return await Geolocator.getCurrentPosition();
  }
  void getCurrentLocations(BuildContext context, ) async {
 try{

   Position myPosition;
   Position newLocalData = await getLocation();
   myPosition = newLocalData;

   if (mapController != null) {
     mapController!.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(target: LatLng(myPosition.latitude, myPosition.longitude), zoom: 17),
     ));
   }
   setState(() {
     lon= myPosition.longitude;
     lat=myPosition.latitude;
   });
 }catch(e){
 }

  }
  Future<void> handleSearch() async {
    places.Prediction? p = await loc.PlacesAutocomplete.show(
        context: context,
        apiKey: 'AIzaSyCruxq7GI3gz6iNk2G72e-igYyz9-eXcfE',
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

        ]
    );

    displayPrediction(p!, ScaffoldState());

  }

  void onError(places.PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        contentType: ContentType.failure,
        message: response.errorMessage!,
      ),
    ));

  }

  Future<void> displayPrediction(places.Prediction p, ScaffoldState? currentState) async {
    places.GoogleMapsPlaces placess = places.GoogleMapsPlaces(
        apiKey: 'AIzaSyCruxq7GI3gz6iNk2G72e-igYyz9-eXcfE',
        apiHeaders: await const header.GoogleApiHeaders().getHeaders());
    places.PlacesDetailsResponse detail =
    await placess.getDetailsByPlaceId(p.placeId!);
    mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng)));

    placemarks = await geocoding.placemarkFromCoordinates(detail.result.geometry!.location.lat,  detail.result.geometry!.location.lng);
    print('placeId ---> ${detail.result.placeId}');
    setState(() {
      lon=detail.result.geometry!.location.lng;
      lat=detail.result.geometry!.location.lat;
      searchResult=placemarks!.first.street!;
    });
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
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng), zoom: 5),
      ),

    );
    setState(() {

    });
  }

}

