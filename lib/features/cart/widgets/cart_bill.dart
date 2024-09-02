import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
         if(element.taxModel == "exclude"){
           tax += element.tax! * element.quantity!;
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
          children: [
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
                Text(getTranslated('shipping_fee', context)!,style: GoogleFonts.tajawal(
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
                Text(getTranslated('discount', context)!,style: GoogleFonts.tajawal(
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

              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                Text(getTranslated('tax', context)!,style: GoogleFonts.tajawal(
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
                    if(widget.fromCheckOut==true)
                        InkWell(
                      onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(quantity: 1,
      cartList: widget.cartList,totalOrderAmount:total, shippingFee:shipping, discount: dic,
      tax:tax,  hasPhysical: false)));

                      },
                      child: Container(
                        // height: 35,
                        // width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
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
                    )
                  ],
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
