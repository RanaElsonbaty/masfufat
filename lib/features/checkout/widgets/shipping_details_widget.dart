import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    // bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<CheckoutController>(
        builder: (context, shippingProvider,_) {
          bool selectAddress=shippingProvider.addressIndex == null;
          if(shippingProvider.sameAsBilling && !widget.hasPhysical){
            shippingProvider.setSameAsBilling();
          }
          return Consumer<AddressController>(
            builder: (context, locationProvider, _) {
              return Container(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,
                  Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Card(child:
                      Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                            color:selectAddress?Colors.red: Theme.of(context).cardColor),
                          child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
                            Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start, children: [
                              Expanded(child: Row(children: [
                                SizedBox(width: 20, child: Image.asset(Images.billingTo,color:selectAddress?Colors.white: Theme.of(context).primaryColor,)),
                                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                    child: Text('${getTranslated('select_a_shipping_address', context)}',
                                        style: GoogleFonts.tajawal(
                                            color: selectAddress?Colors.white:Colors.black,
                                            fontSize: Dimensions.fontSizeLarge))
                                )
                              ])),


                              InkWell(onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => const SavedBillingAddressListScreen(formCheckOut: false,))),
                                child: SizedBox(width: 20,child: Image.asset(Images.edit, scale: 3, color:selectAddress?Colors.white: Theme.of(context).primaryColor,)),),
                            ]),


                              const SizedBox(height: Dimensions.paddingSizeDefault,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                               Divider(thickness: .125,color: selectAddress?Colors.white:null,),

                              (shippingProvider.addressIndex != null && (locationProvider.addressList?.isNotEmpty ?? false))
                                  ? Column(children: [
                                AddressInfoItem(icon:locationProvider.addressList?[shippingProvider.addressIndex!].addressType=='home'?
                                Images.homeImage:locationProvider.addressList?[shippingProvider.addressIndex!].addressType=='permanent'?Images.officeImage:Images.address,
                                    title: getTranslated(locationProvider.addressList?[shippingProvider.addressIndex!].addressType, context)??''),
                              AddressInfoItem(icon: Images.user,
                                    title: locationProvider.addressList?[shippingProvider.addressIndex!].contactPersonName??''),
                                AddressInfoItem(icon: Images.callIcon,
                                    title: locationProvider.addressList?[shippingProvider.addressIndex!].phone??''),
                                AddressInfoItem(icon: Images.address,
                                    title: locationProvider.addressList?[shippingProvider.addressIndex!].address??''),
                              ]) :  Text(getTranslated('add_your_address', context)!,
                                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: selectAddress?Colors.white:null),
                                maxLines: 3, overflow: TextOverflow.fade,
                              ),
                            ]),
                          ]),
                        )),
                  
                    if(selectAddress)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                        child: Text(getTranslated('Select_shipping_address_required', context)!,style: GoogleFonts.tajawal(fontSize: 18,color: Colors.red),),
                      )
                  ]),
              );
            }
          );
        }
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
            child: Text(title??'',style: textRegular.copyWith(),maxLines: 2, overflow: TextOverflow.fade )))]),
    );
  }
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}