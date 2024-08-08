import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/location/controllers/location_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_webservice/places.dart' as places;
import 'package:location/location.dart';

import '../../address/domain/models/address_model.dart';
import '../../address/screens/add_new_address_screen.dart';
class SelectLocationScreen extends StatefulWidget {
  final GoogleMapController? googleMapController;
  final bool isEnableUpdate;
  final bool fromCheckout;
  final AddressModel? address;
  final bool? isBilling;
  const SelectLocationScreen({super.key,  this.googleMapController, required this.isEnableUpdate, required this.fromCheckout, this.address, this.isBilling});
  @override
  SelectLocationScreenState createState() => SelectLocationScreenState();
}

class SelectLocationScreenState extends State<SelectLocationScreen> {
  GoogleMapController? _controller;
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _askingPermission();
    Provider.of<LocationController>(context, listen: false).setPickData();


  }

  Future<bool> _askingPermission() async {
    // if (camera) {
      await permission.Permission.camera.request();
      if (await permission.Permission.camera.isDenied) {
        return false;
      } else {
        return true;
      }
    // } else {
    //   await Permission.microphone.request();
    //   if (await Permission.microphone.isDenied) {
    //     return false;
    //   } else {
    //     return true;
    //   }
    // }

  }

  void initData()async{

    if(widget.isEnableUpdate==false){
      getCurrentLocation();

    }else{
      placemarks = await geocoding.placemarkFromCoordinates(  widget.address!.latitude != null?   double.parse(
          widget.address!.latitude!
      ):0.00, widget.address!.longitude != null
          ?     double.parse(widget.address!.longitude!
      ):0.00);
      searchResult=placemarks!.first.street!;
      Provider.of<LocationController>(context, listen: false).updateMapPosition(
          CameraPosition(
              target: LatLng(
                  widget.address!.latitude != null?   double.parse(
                      widget.address!.latitude!
                  ):0.00,
                  widget.address!.longitude != null
                      ?     double.parse(widget.address!.longitude!
                  ):0.00)),
          true,
          widget.address!.address!,
          context);


    }
  }
  List<geocoding.Placemark> ?placemarks;
  @override
  void dispose() {
    super.dispose();
    // _controller!.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _locationController.text = '${Provider.of<LocationController>(context).address.name ?? ''}, '
        '${Provider.of<LocationController>(context).address.subAdministrativeArea ?? ''}, '
        '${Provider.of<LocationController>(context).address.isoCountryCode ?? ''}';

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('select_delivery_address', context)),
      body: Consumer<LocationController>(
          builder: (context, locationController, child) =>  Stack(clipBehavior: Clip.none, children: [
              GoogleMap(mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(locationController.position.latitude, locationController.position.longitude), zoom: 16),
                zoomControlsEnabled: false,
                compassEnabled: false,
                indoorViewEnabled: true,
                mapToolbarEnabled: true,
                onCameraIdle: () => locationController.updateMapPosition(locationController.cameraPosition, false, null, context),
                onCameraMove: ((position) async{
                  locationController.cameraPosition = position;
                 try{
                   locationController. placemarks = await geocoding.placemarkFromCoordinates(position.target.latitude, position.target.longitude);
                   setState(() {
                     locationController.searchResult=locationController.placemarks!.first.street!;

                   });
                 }catch(e){}
                }),
                onMapCreated: (GoogleMapController controller) {
                  locationController.controller = controller;
                },
              ),

              locationController.pickAddress != null ?
              InkWell(onTap: () =>
                  _handleSearch(),
                  // _openSearchDialog(context, _controller),
                child: Container(width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: 18.0),
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: 23.0),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                  child: Row(children: [
                    Expanded(child: Text(
                        locationController.searchResult!=''?locationController.searchResult:'search'
                    , maxLines: 1, overflow: TextOverflow.ellipsis)),
                    const Icon(Icons.search, size: 20)]))) : const SizedBox.shrink(),


              Positioned(bottom: 0, right: 0, left: 0,
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    InkWell(onTap: () {
                      // locationController.getCurrentLocation(context, false, mapController: _controller);
                      locationController.getCurrentLocations( context,);

                    },
                      child: Container(width: 50, height: 50,
                        margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          color: ColorResources.getChatIcon(context)),
                        child: Icon(Icons.my_location, color: Theme.of(context).primaryColor, size: 35))),


                    SizedBox(width: double.infinity,
                      child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        child: CustomButton(buttonText: getTranslated('select_location', context),
                          onTap: () async{
                            if(locationController.controller != null) {
                              locationController.controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                locationController.pickPosition.latitude, locationController.pickPosition.longitude), zoom: 16)));
                              locationController.setAddAddressData();
                            }
                            if(locationController.placemarks!=null&&locationController.placemarks!.isEmpty){
                              locationController.placemarks = await geocoding.placemarkFromCoordinates(locationController.pickPosition.latitude, locationController.pickPosition.longitude,);

                            }
                            Navigator.of(Get.context!).push(MaterialPageRoute(builder: (_) =>
                             AddNewAddressScreen(isBilling: false,placemarks:locationController.placemarks!=null? locationController.placemarks!:[], fromCheckout: widget.fromCheckout,address: widget.address,isEnableUpdate: widget.isEnableUpdate,)
                            // const SelectLocationScreen()
                            )
                            );
                          })))
                ]
                )),
              Center(child: Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 50)),
              locationController.loading ?
              Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))) :
              const SizedBox(),
            ],
          ) ,
        ),
    );
  }
  Location location = Location();
  final Map<String, Marker> _markers = {};
  String searchResult='';
  double latitude = 0;
  double longitude = 0;
  Future<void> _handleSearch() async {
    places.Prediction? p = await loc.PlacesAutocomplete.show(
        context: context,
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
    try{
      displayPrediction(p!, ScaffoldState());

    }catch(E){}
  }

    void onError(places.PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
  }

  Future<void> displayPrediction(
      places.Prediction p, ScaffoldState? currentState) async {
    places.GoogleMapsPlaces placess = places.GoogleMapsPlaces(
        apiKey: 'AIzaSyC2BO1gDok2Pt8pa-MFypDjiOnfZjZWruc',
        apiHeaders: await const header.GoogleApiHeaders().getHeaders());
    places.PlacesDetailsResponse detail =
    await placess.getDetailsByPlaceId(p.placeId!);
    setState(() {

    });
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
     placemarks = await geocoding.placemarkFromCoordinates(lat, lng);
    print('placeId ---> ${detail.result.placeId}');
    setState(() {
      searchResult=placemarks!.first.street!;

    });
    _markers.clear(); //clear old marker and set new one
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15),
        ),

      );
    });
  }
  getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    try{
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

    }catch(e){

    }


    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
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
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 10),
        ),
      );
    });
  }
  void getCurrentLocations(BuildContext context,GoogleMapController controller ) async {
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
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(myPosition.latitude, myPosition.longitude), zoom: 17),
    ));
      // Placemark myPlaceMark;

  }

}
