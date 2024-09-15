import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/widgets/address_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/widgets/remove_address_bottom_sheet_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../location/screens/select_location_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});
  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {

  @override
  void initState() {
    Provider.of<AddressController>(context, listen: false).getAddressList(all: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('addresses', context),),
      floatingActionButton: FloatingActionButton(
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const
        // AddNewAddressScreen(isBilling: false)
             SelectLocationScreen(edit: false,)
        )),
        backgroundColor: ColorResources.getPrimary(context),
        child: Icon(Icons.add, color: Theme.of(context).highlightColor)),


      body: Consumer<AddressController>(
        builder: (context, locationProvider, child) {
          return  locationProvider.addressList != null? locationProvider.addressList!.isNotEmpty ?
          RefreshIndicator(onRefresh: () async => await locationProvider.getAddressList(),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      children: [
                        Text(getTranslated('Your_address_list', context)!,style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),),
                      ],
                    ),
                  ),
                  ListView.builder(padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: locationProvider.addressList?.length,
                    itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
                      child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                              spreadRadius: 0
                            )
                          ],
                          color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                        child: Column(children: [
              
                          Row(children: [
                            Expanded(child: Text('${locationProvider.addressList?[index].address}',
                                style: GoogleFonts.tajawal (fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w500),),),
              
                            InkWell(onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                                // AddNewAddressScreen(
                              // isBilling:  locationProvider.addressList?[index].isBilling==1,
                              // placemarks: [],
                              // address: locationProvider.addressList?[index], isEnableUpdate: true
                       SelectLocationScreen(edit: true,
                        address: locationProvider.addressList![index],
              
              
                              )
                      )),
                              child: Container(width: 40,
                                decoration: BoxDecoration(borderRadius:
                               BorderRadius.circular(5),
                                  // color: Theme.of(context).primaryColor.withOpacity(.05)
                                ),
                                child: Padding(padding: const EdgeInsets.all(6),
                                  child: Image.asset(Images.editIcon),),),
                            ),
                          ]
                          ),
              
                          Row(children: [
                            Text('${getTranslated('city', context)} : ${locationProvider.addressList?[index].city ?? ""}',
                              style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400),),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
              
              
                          ]
                          ), Row(children: [
                            Text('${getTranslated('zip', context)} : ${locationProvider.addressList?[index].zip ?? ""}',
                                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400)),
              
                            const Spacer(),
                            InkWell(onTap: (){
                              showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=>
                                  RemoveFromAddressBottomSheet(addressId: locationProvider.addressList![index].id!, index: index));
                            },
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(Images.deleteIcons,width: 20,),
                                ))
              
              
              
                          ]
                          ),
                        ],
                        ),
                      ),
                    );
                    },
                  ),
                ],
              ),
            ),
          ) : const NoInternetOrDataScreenWidget(isNoInternet: false,
            message: 'no_address_found',
            icon: Images.noAddress,): const AddressShimmerWidget();
        },
      ),
    );
  }
}
