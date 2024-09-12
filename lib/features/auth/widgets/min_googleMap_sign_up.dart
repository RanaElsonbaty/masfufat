import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

import 'package:provider/provider.dart';
import '../../../utill/dimensions.dart';

class MinGoogleMap extends StatefulWidget {
  const MinGoogleMap({super.key});

  @override
  State<MinGoogleMap> createState() => _MinGoogleMapState();
}

class _MinGoogleMapState extends State<MinGoogleMap> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder:(context, auth, child) =>  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),

          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: true,
                 onCameraMove: ((position) async{
                   auth.lot.text=position.target.latitude.toString();
                   auth.lan.text=position.target.longitude.toString();
                   auth.cameraPosition = position;
                   try{
                     auth. placemarks = await geocoding.placemarkFromCoordinates(position.target.latitude, position.target.longitude);
                     setState(() {
                       auth. searchResult=auth.placemarks!.first.street!;
                       auth.address.text=auth.placemarks!.first.street!;

                     });
                   }catch(e){}
                 }),
                 onMapCreated: (GoogleMapController controller) {
                   auth.controller = controller;
                 },

                  initialCameraPosition:  auth.cameraPosition!,
                mapType: MapType.normal,
                 myLocationEnabled: true,
                 myLocationButtonEnabled: false,


              ),

              InkWell(onTap: () =>
                  auth.handleSearch(),
                  // _openSearchDialog(context, _controller),
                  child: Container(width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: 10.0),
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: 10.0),
                      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                      child: Row(children: [
                        Expanded(child: Text(
                           auth.searchResult!=''?auth.searchResult:'search'
                            , maxLines: 1, overflow: TextOverflow.ellipsis)),
                        const Icon(Icons.search, size: 20)]))) ,
              Center(child: Icon(Icons.location_on_rounded, color: Theme.of(context).primaryColor, size: 40)),
          Positioned(bottom: 20, right: 0, left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(onTap: () {
                  auth.getCurrentLocations( context);
                },
                    child: Container(width: 35, height: 35,
                        margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor),
                        child: const Icon(Icons.my_location, color: Colors.white, size: 20))),
              ],
            ),
          ),

      ]
        ),
      ))),
    );
  }

  // final CameraPosition _kGooglePlex = const CameraPosition(
  //   target: LatLng(33.298037, 44.2879251),
  //   zoom: 10,
  // );
  // Future<void> _handleSearch() async {
  //   places.Prediction? p = await loc.PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: 'AIzaSyC2BO1gDok2Pt8pa-MFypDjiOnfZjZWruc',
  //       onError: onError, // call the onError function below
  //       mode: loc.Mode.overlay,
  //       language: 'en', //you can set any language for search
  //       strictbounds: false,
  //       types: [],
  //
  //       decoration: InputDecoration(
  //           hintText: 'search',
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(20),
  //               borderSide: const BorderSide(color: Colors.white))),
  //       components: [
  //
  //       ]// you can determine search for just one country
  //   );
  //   // p.
  //     displayPrediction(p!, ScaffoldState());
  //
  // }
  //
  // void onError(places.PlacesAutocompleteResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     elevation: 0,
  //     behavior: SnackBarBehavior.floating,
  //     backgroundColor: Colors.transparent,
  //     content: AwesomeSnackbarContent(
  //       title: 'Message',
  //       message: response.errorMessage!,
  //       contentType: ContentType.failure,
  //     ),
  //   ));
  // }
  //
  // Future<void> displayPrediction(
  //     places.Prediction p, ScaffoldState? currentState) async {
  //   places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
  //       apiKey: 'AIzaSyC2BO1gDok2Pt8pa-MFypDjiOnfZjZWruc',
  //       apiHeaders: await const header.GoogleApiHeaders().getHeaders());
  //   places.PlacesDetailsResponse detail =
  //   await _places.getDetailsByPlaceId(p.placeId!);
  //   auth.cameraPosition =CameraPosition(target: LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng));
  //   setState(() {
  //
  //   });
  //   final lat = detail.result.geometry!.location.lat;
  //   final lng = detail.result.geometry!.location.lng;
  //   auth. placemarks = await geocoding.placemarkFromCoordinates(lat, lng);
  //   print('placeId ---> ${detail.result.placeId}');
  //   setState(() {
  //     auth.longitude=detail.result.geometry!.location.lng;
  //     auth.latitude=detail.result.geometry!.location.lat;
  //     searchResult=placemarks!.first.street!;
  //
  //   });
  //   _markers.clear(); //clear old marker and set new one
  //   final marker = Marker(
  //     markerId: const MarkerId('deliveryMarker'),
  //     position: LatLng(lat, lng),
  //     infoWindow: const InfoWindow(
  //       title: '',
  //     ),
  //   );
  //   setState(() {
  //     _markers['myLocation'] = marker;
  //     _controller?.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(lat, lng), zoom: 15),
  //       ),
  //
  //     );
  //   });
  // }
  // getCurrentLocation() async {
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //
  //   try{
  //     serviceEnabled = await location.serviceEnabled();
  //     if (!serviceEnabled) {
  //       serviceEnabled = await location.requestService();
  //       if (!serviceEnabled) {
  //         return;
  //       }
  //     }
  //
  //   }catch(e){
  //
  //   }
  //
  //
  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   LocationData currentPosition = await location.getLocation();
  //   latitude = currentPosition.latitude!;
  //   longitude = currentPosition.longitude!;
  //   final marker = Marker(
  //     markerId: const MarkerId('myLocation'),
  //     position: LatLng(latitude, longitude),
  //     infoWindow: const InfoWindow(
  //       title: 'you can add any message here',
  //     ),
  //   );
  //   setState(() {
  //     _markers['myLocation'] = marker;
  //     _controller?.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(latitude, longitude), zoom: 10),
  //       ),
  //     );
  //   });
  //   setState(() {
  //
  //   });
  // }
}
