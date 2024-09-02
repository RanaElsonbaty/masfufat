import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../../../theme/controllers/theme_controller.dart';

class CouponApplyWidget extends StatelessWidget {
  final TextEditingController couponController;
  final double orderAmount;
  const CouponApplyWidget({super.key, required this.couponController, required this.orderAmount});

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponController>(
      builder: (context, couponProvider, _) {
        return Container(height: (couponProvider.discount != null && couponProvider.discount != 0)?50:70, width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // color:Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              // border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.25))
        ),

          child: (couponProvider.discount != null && couponProvider.discount != 0)?
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
                SizedBox(height: 25,width: 25, child: Image.asset(Images.appliedCoupon)),
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                child: Text(couponProvider.couponCode, style: textBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge?.color),),),

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Text('(-${PriceConverter.convertPrice(context, couponProvider.discount)} off)',
                    style: textMedium.copyWith(color: Theme.of(context).primaryColor)))]),

            InkWell(onTap: ()=> couponProvider.removeCoupon(),
                child: Icon(Icons.clear, color: Theme.of(context).colorScheme.error))]):

          Padding(padding: const EdgeInsets.all(8.0),
              child: Container(width : MediaQuery.of(context).size.width, height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      border: Border.all(color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                      Theme.of(context).hintColor.withOpacity(.15): Theme.of(context).primaryColor.withOpacity(.15))),
                  child: Row(children: [

                    Expanded(child: Container(decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all( Radius.circular(Dimensions.paddingSizeDefault))),

                        child:  TextFormField(
                            controller: couponController,
                            decoration: InputDecoration(
                                helperStyle: textRegular.copyWith(),
                                prefixIcon: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child: Image.asset(Images.eCoupon,color: Theme.of(context).primaryColor,),),
                                suffixIcon: InkWell(onTap: (){
                                  if(couponController.text.isNotEmpty) {
                                    couponProvider.applyCoupon(context,couponController.text, orderAmount);
                                    // Navigator.of(context).pop();
                                    couponController.clear();
                                  }
                                },
                                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                        child: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                            borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeExtraSmall))),
                                            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
                                                vertical: Dimensions.paddingSizeSmall),
                                                child: Text('${getTranslated('apply', context)}', style: textMedium.copyWith(color: Colors.white)))))),
                                hintText: getTranslated('enter_coupon', context),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                suffixIconConstraints: const BoxConstraints(maxHeight: 40),
                                hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.125),
                                        width:  0.125)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width:  0.125)),

                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.125), width:  0.125)))))),
                  ]))),
          // InkWell(onTap: ()=> showModalBottomSheet(context: context,
          //     isScrollControlled: true, backgroundColor: Colors.transparent,
          //     builder: (c) =>   CouponBottomSheetWidget(orderAmount: orderAmount)),
          //   child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //       Text('${getTranslated('add_coupon', context)}', style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
          //       Text('${getTranslated('add_more', context)}', style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
          //
          //     ],),
          //   ),
          // ),
        );
      }
    );
  }
}
