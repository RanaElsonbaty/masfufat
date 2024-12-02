import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../checkout/screens/checkout_screen.dart';
import '../../coupon/controllers/coupon_controller.dart';
import '../../shipping/controllers/shipping_controller.dart';
import '../domain/models/cart_model.dart';

class CartBill extends StatefulWidget {
  const CartBill({super.key,  required this.cartList, this.fromCheckOut=true});
  // final double subTotal;
  // final double shipping;
  // final double dec;
  final List<CartModel> cartList;
 final bool? fromCheckOut;

  // final double coupon;
  // final double tax;
  // final double sipTax;
  // final double total;

  @override
  State<CartBill> createState() => _CartBillState();
}


class _CartBillState extends State<CartBill> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBillInfo();
  }

  void getBillInfo(){

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingController>(
      builder:(context, shippingController, child) {
        double subTotal =0.00;
        double shipping =0.00;
        double dic =0.00;
        double coupon =0.00;
        double tax =0.00;
        double sipTax =0.00;
        double total =0.00;
      try{
        if( shippingController.shippingList != null ||shippingController.chosenShippingList.isNotEmpty ||
            shippingController.shippingList!.isNotEmpty || shippingController.shippingList![0].shippingMethodList != null ||
            shippingController.shippingList![0].shippingIndex == -1) {
          shipping=
          shippingController.shippingList![0].shippingMethodList![shippingController.shippingList![0].shippingIndex!].cost!;
          sipTax=shipping*0.15;
        }
      }catch(e){}
     try{
       for (var element in widget.cartList) {
         subTotal+=(element.price!*element.quantity!);
         shipping+=element.shippingCost!;
         dic +=(element.discount!*element.quantity!);
         if(element.taxType == "exclude"){
           tax += element.tax! * element.quantity!;
         }else{
           tax += (PriceConverter.calculationTaxDouble(context, element.product!.unitPrice!, element.product!.tax!, element.product!.taxType) * element.quantity!);
         }
       }
     }catch(e){}
       try{
         sipTax=(shipping*0.15);
         total=sipTax+tax+shipping+subTotal-dic-coupon;
         coupon = Provider.of<CouponController>(Get.context!).discount ?? 0;

       }catch(e){}

        return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(getTranslated('bill', context)!,style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),)
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                Text(getTranslated('sub_total', context)!,style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),),
                  const Spacer(),
                  Text(PriceConverter.convertPrice(context, subTotal),style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            const Divider(height: 1, color: Color(0xFFD8D8D8)),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(getTranslated('Product_tax', context)!,style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                  const Spacer(),
                  Text(PriceConverter.convertPrice(context,tax),style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            const Divider(height: 1, color: Color(0xFFD8D8D8)),
            const SizedBox(height: 5,),

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                Text(getTranslated('Shipping_cost', context)!,style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),),
                  const Spacer(),
                  Text(PriceConverter.convertPrice(context, shipping),style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            const Divider(height: 1, color: Color(0xFFD8D8D8)),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(getTranslated('Shipping_tax', context)!,style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                  const Spacer(),
                  Text(PriceConverter.convertPrice(context, sipTax),style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            const Divider(height: 1, color: Color(0xFFD8D8D8)),
            const SizedBox(height: 5,),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                Text(getTranslated('Discount_on_product', context)!,style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),),
                  const Spacer(),
                  Text(PriceConverter.convertPrice(context,dic),style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            const Divider(height: 1, color: Color(0xFFD8D8D8)),
            const SizedBox(height: 5,),

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                Text(getTranslated('coupon_voucher', context)!,style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),),
                  const Spacer(),
                  Text(PriceConverter.convertPrice(context, coupon),style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 5,),

            const Divider(height: 1, color: Color(0xFFD8D8D8)),
            const SizedBox(height: 5,),


            const SizedBox(height: 5,),


            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getTranslated('Total_Payments', context)!,style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),),
                    Text(PriceConverter.convertPrice(context,total),style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            if(widget.fromCheckOut==true)
              Consumer<SplashController>(
                builder:(context, configProvider, child) =>  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: InkWell(
                    onTap: (){
                      bool hasNull = false;
                                    bool stockOutProduct = false;
                      bool onlyDigital= true;
                      List<CartModel> cartList = [];
                      cartList.addAll(widget.cartList);

                      for(CartModel cart in cartList) {
                        if(cart.productType == "physical" ){
                          onlyDigital = false;
                        }
                      }

                      List<String?> orderTypeShipping = [];
                      List<String?> sellerList = [];
                      List<List<String>> productType = [];
                      List<CartModel> sellerGroupList = [];
                      List<List<CartModel>> cartProductList = [];
                      List<List<int>> cartProductIndexList = [];
                      for(CartModel cart in cartList) {
                        // if() {
                        // }
                        if(!sellerList.contains(cart.cartGroupId)) {
                          sellerList.add(cart.cartGroupId);
                          cart.isGroupChecked = false;
                          sellerGroupList.add(cart);
                        }
                      }



                      for(CartModel? seller in sellerGroupList) {
                        List<CartModel> cartLists = [];
                        List<int> indexList = [];
                        List<String> productTypeList = [];
                        bool isSellerChecked = true;
                        for(CartModel cart in cartList) {
                          if(seller?.cartGroupId == cart.cartGroupId) {
                            cartLists.add(cart);
                            indexList.add(cartList.indexOf(cart));
                            productTypeList.add(cart.productType!);
                            // if(!cart.isChecked!){
                            isSellerChecked = false;
                          } else if (cart.isChecked!) {
                            seller?.isGroupItemChecked = true;
                            // }
                          }
                        }

                        cartProductList.add(cartLists);
                        productType.add(productTypeList);
                        cartProductIndexList.add(indexList);
                        if(isSellerChecked){
                          seller?.isGroupChecked = true;
                        }
                      }

                      for (var seller in sellerGroupList) {
                        if(seller.freeDeliveryOrderAmount?.status == 1 && seller.isGroupItemChecked!){
                        }
                        if(seller.shippingType == 'order_wise'){
                          orderTypeShipping.add(seller.shippingType);
                        }
                      }



                      for(int i=0;i<widget.cartList.length;i++){
                        // if(cart.cartList[i].isChecked!){
                        // if (kDebugMode) {
                          print('====TaxModel == ${widget.cartList[i].taxModel}');
                        // }
                        if(widget.cartList[i].taxModel == "exclude"){
                        }
                        // }
                      }
                      for(int i=0;i<shippingController.chosenShippingList.length;i++){
                        if(shippingController.chosenShippingList[i].isCheckItemExist == 1 && !onlyDigital) {
                        }
                      }





                                    if (configProvider.configModel!.shippingMethod =='sellerwise_shipping') {
                                      for (int index = 0; index < sellerGroupList.length; index++) {
                                        bool hasPhysical = false;
                                        for(CartModel cart in cartProductList[index]) {
                                          if(cart.productType == 'physical') {
                                            hasPhysical = true;
                                            break;
                                          }
                                        }

                                        if(hasPhysical && sellerGroupList[index].isGroupItemChecked! && sellerGroupList[index].shippingType == 'order_wise'  &&
                                            Provider.of<ShippingController>(context, listen: false).shippingList![index].shippingIndex == -1 && sellerGroupList[index].isGroupItemChecked!){
                                          hasNull = true;
                                          break;
                                        }
                                      }
                                    }


                                    for(int index = 0; index < sellerGroupList.length; index++) {
                                      if(widget.cartList[index].quantity! > widget.cartList[index].productInfo!.totalCurrentStock! && sellerGroupList[index].productType =="physical") {
                                        stockOutProduct = true;
                                        break;
                                      }
                                    }



                                    if( !Provider.of<AuthController>(context, listen: false).isLoggedIn()){
                                      showModalBottomSheet(backgroundColor: Colors.transparent,context:context, builder: (_)=> const NotLoggedInBottomSheetWidget());
                                    }
                                    else if (widget.cartList.isEmpty) {
                                      showCustomSnackBar(getTranslated('select_at_least_one_product', context), context);
                                    } else if (stockOutProduct) {
                                      showCustomSnackBar(getTranslated('Out_of_stock', context), context);
                                    }
                                    else if(hasNull && configProvider.configModel!.shippingMethod =='sellerwise_shipping' && !onlyDigital){
                                      // changeColor();
                                      showCustomSnackBar(getTranslated('select_all_shipping_method', context), context);
                                    }

                                    else if(shippingController.chosenShippingList.isEmpty &&
                                        configProvider.configModel!.shippingMethod !='sellerwise_shipping' &&
                                        configProvider.configModel!.inhouseSelectedShippingType =='order_wise' ){

                                      showCustomSnackBar(getTranslated('select_all_shipping_method', context), context);
                                    }
                                    // else if (!isItemChecked){
                                    //   showCustomSnackBar(getTranslated('please_select_items', context), context);
                                    // }
                                    else {


                                      // for(CartModel seller in sellerGroupList) {
                                      //   if(seller.isGroupItemChecked!) {
                                      //     sellerGroupLenght += 1;
                                      //   }
                                      // }
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(quantity: 1,
                                          cartList: widget.cartList,totalOrderAmount:total, shippingFee:shipping, discount: dic,
                                          tax:tax,  hasPhysical: false)));
                                      // Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(quantity: totalQuantity,
                                      //     cartList: cartList,totalOrderAmount: amount, shippingFee: shippingAmount-freeDeliveryAmountDiscount, discount: discount,
                                      //     tax: tax, onlyDigital: sellerGroupLenght != totalPhysical, hasPhysical: totalPhysical > 0)));
                                    }
                                  // },


                    },
                    child: Container(
                      height: 50,
                      // width: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(getTranslated('Complete_payment', context)!,style: GoogleFonts.tajawal(
                              fontSize: 14,fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),
              )

          ],
        ),
      );

      },
    );
  }
}
