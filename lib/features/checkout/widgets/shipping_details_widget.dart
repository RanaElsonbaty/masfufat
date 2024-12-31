import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/widgets/create_account_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/screens/saved_billing_address_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../address/domain/models/address_model.dart';
import '../../address/widgets/address_type_widget.dart';
import '../../address/widgets/remove_address_bottom_sheet_widget.dart';
import '../../location/screens/select_location_screen.dart';


class ShippingDetailsWidget extends StatefulWidget {
  final bool hasPhysical;
  final bool billingAddress;
  final GlobalKey<FormState> passwordFormKey;
  final bool? fromCheckout;

  const ShippingDetailsWidget({super.key, required this.hasPhysical, required this.billingAddress, required this.passwordFormKey, this.fromCheckout=false});

  @override
  State<ShippingDetailsWidget> createState() => _ShippingDetailsWidgetState();
}

class _ShippingDetailsWidgetState extends State<ShippingDetailsWidget> {
  final ScrollController scrollController = ScrollController();
  bool isDown=false;
  List<AddressModel> addressList=   [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressList=Provider.of<AddressController>(context,listen: false).addressList!;
  }
  @override
  Widget build(BuildContext context) {
    // bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<AddressController>(
      builder:(context, locationProvider, child) => Consumer<CheckoutController>(
          builder: (context, shippingProvider,_) {

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(getTranslated('Select_the_title', context)!,style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,fontSize: 16
                      ),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isDown=!isDown;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height:45,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(
                     color: const Color(0xFFEFF1F8),
                     borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated('Choose_from_your_shipping_addresses', context)!,style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w500,color: Colors.grey.shade600
                        ),),
                        Icon(isDown?Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_up_rounded,color: Colors.grey.shade600,)
                      ],
                    ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Visibility(
                    visible: isDown,
                    child: Container(
                      height: 320,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: .5,color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          CustomTextFieldWidget(
                            filled: false,
                            showLabelText: false,
                            hintText: getTranslated('Find_specific_shipping_address', context),
                            onChanged: (val) {
                              setState(() {

    if (val.isNotEmpty) {
    // Filter the list by matching the entered value
    addressList = Provider.of<AddressController>(context, listen: false)
        .addressList!
        .where((address) =>
    (address.address ?? '').toLowerCase().contains(val.toLowerCase()))
        .toList();


    } else {
    // Reset to the original list when input is cleared
    addressList = Provider.of<AddressController>(context, listen: false).addressList!;
    }
    });

                            },
                          ),
                          SizedBox(
                            height: 200,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Scrollbar(
                                controller: scrollController,
                                thumbVisibility: true,

                                child: ListView.builder(
                                  controller: scrollController,
                                  padding: const EdgeInsets.only(right: 13),
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: addressList!.length,
                                    itemBuilder:(context, index) {
                                      return Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: InkWell(
                                            onTap: (){
                                              for(int i=0;i<locationProvider.addressList!.length;i++){
                                                if(addressList[index].id==locationProvider.addressList![i].id){
                                                  shippingProvider.setBillingAddressIndex(i);

                                                }
                                              }

                                            },
                                            child: Container(
                                              height: 45,
                                              padding: const EdgeInsets.symmetric(horizontal: 5),
                                              decoration:  BoxDecoration(

                                                color:locationProvider.addressList!=null&& addressList[index].id==locationProvider.addressList![shippingProvider.addressIndex??0].id?Theme.of(context).cardColor:null
                                                // border: Border.all(width: .1,color: Colors.grey),
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(addressList![index].address!,
                                                      maxLines: 1,
                                                      style: GoogleFonts.tajawal(
                                                      fontWeight: FontWeight.w400,fontSize: 14,
                                                    ),),
                                                  ),
                                                  const Spacer(),
                                                  const SizedBox(width: 5,),

                                                 InkWell(

                                                   onTap: (){
                                                     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                                                     SelectLocationScreen(edit: true,address: addressList[index],)));
                                                   },
                                                     child: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                                                  const SizedBox(width: 5,),
                                                  InkWell(
                                                      onTap: (){
                                                        showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=>
                                                            RemoveFromAddressBottomSheet(addressId: addressList[index].id!, index: index));

                                                      },
                                                      child: Image.asset(Images.delete,width: 20,)),

                                                ],


                                                                            ),
                                            ),
                                          ));
                                    }, ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFD4CAEA),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add,color: Colors.black,),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const
                                    // AddNewAddressScreen(isBilling: true,placemarks: [],)
                                    SelectLocationScreen(edit: false,)
                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(getTranslated('Add_new_address', context)!,style: GoogleFonts.tajawal(
                                        fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black
                                    ),),
                                  ),
                                )
                              ],),
                          )

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            );
          }
      ),
    );
  }
}



class AddressInfoItem extends StatelessWidget {
  final String? icon;
  final String? title;
  const AddressInfoItem({super.key, this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(children: [
        SizedBox(width: 18, child: Image.asset(icon!,color: Theme.of(context).primaryColor,)),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            child: Text(title??'',style: textRegular.copyWith(color: Colors.white),maxLines: 2, overflow: TextOverflow.fade )))]),
    );
  }
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
class SelectAddressWidget extends StatefulWidget {
  const SelectAddressWidget({super.key});

  @override
  State<SelectAddressWidget> createState() => _SelectAddressWidgetState();
}

class _SelectAddressWidgetState extends State<SelectAddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color:Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))
      ),
      child: Consumer<AddressController>(
        builder:(context, address, child) {
          return Column(
            children: [
              const SizedBox(height: 10,),
              Container(height: 5,width: 120,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey
              ),),
              const SizedBox(height: 10,),

              SizedBox(
                height: 370,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: address.addressList!.length,
                  itemBuilder: (context, index) {
                    return InkWell(onTap: () {Provider.of<CheckoutController>(context, listen: false).setBillingAddressIndex(index);
                    Navigator.pop(context);
                    },
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: Container(margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor,
                                  border: index == Provider.of<CheckoutController>(context).billingAddressIndex ?
                                  Border.all(width: 2, color: Theme.of(context).primaryColor) : null,),
                                child: AddressTypeWidget(address: address.addressList?[index]))));
                },),
              ),
            ],
          );
        },
      ),
    );
  }
}
