import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/widgets/coupon_item_widget.dart';
import 'package:provider/provider.dart';

class CouponBottomSheetWidget extends StatefulWidget {
  final double orderAmount;
  const CouponBottomSheetWidget({super.key, required this.orderAmount});
  @override
  State<CouponBottomSheetWidget> createState() => _CouponBottomSheetWidgetState();
}

class _CouponBottomSheetWidgetState extends State<CouponBottomSheetWidget> {

  TextEditingController couponController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponController>(
        builder: (context, couponProvider, _) {
          return Container(constraints : BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75,
              minHeight: MediaQuery.of(context).size.height * 0.5 ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeDefault),
                    topRight: Radius.circular(Dimensions.paddingSizeDefault))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [

              const SizedBox(height: Dimensions.paddingSizeSmall),
              Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: Center(child: Container(width: 35,height: 4,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                      color: Theme.of(context).hintColor.withOpacity(.5))))),




              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Text('${getTranslated('available_promo', context)}',
                    style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge))),

              couponProvider.availableCouponList != null? couponProvider.availableCouponList!.isNotEmpty?
              Expanded(child: Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: couponProvider.availableCouponList!.length,
                    itemBuilder: (context, index){
                      return CouponItemWidget(
                        coupons: couponProvider.availableCouponList![index],
                        fromCheckout: true,
                        onCopy: (String? code ) { 
                          couponController.text = code ?? '';
                        },
                      );
                    }),
                ),
              ) : const NoInternetOrDataScreenWidget(isNoInternet: false) :
              const Expanded(child: Center(child: CircularProgressIndicator())),

            ]),
          );
        }
    );
  }
}
