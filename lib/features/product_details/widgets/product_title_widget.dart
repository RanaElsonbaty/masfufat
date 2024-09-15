
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/product_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ProductTitleWidget extends StatelessWidget {
  final ProductDetailsModel? productModel;
  final String? averageRatting;
  const ProductTitleWidget({super.key, required this.productModel, this.averageRatting});

  @override
  Widget build(BuildContext context) {

    ({double? end, double? start})? priceRange = ProductHelper.getProductPriceRange(productModel);
    double? startingPrice = priceRange.start;
    double? endingPrice = priceRange.end;

    return productModel != null? Container(
      padding: const EdgeInsets.symmetric(horizontal : Dimensions.homePagePadding),
      child: Consumer<ProductDetailsController>(
        builder: (context, details, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text(productModel!.name ?? '',
                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w400,), ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Row(children: [
              const Icon(Icons.star,color: Colors.yellow,size: 20,),
              const SizedBox(width: 2,),
              Text(double.tryParse(averageRatting!=null?averageRatting!:'0.00').toString()),
              // RatingBar(rating: productModel!.reviews != null ? productModel!.reviews!.isNotEmpty ?
              const SizedBox(width: 2,),

              // double.parse(averageRatting!) : 0.0 : 0.0),
              Text('(${productModel?.reviewsCount})',style: GoogleFonts.cairo(
                color: Colors.grey
              ),)]),
            // const SizedBox(height: Dimensions.paddingSizeSmall),
            const SizedBox(height: Dimensions.paddingSizeSmall),



            Consumer<ReviewController>(
                builder: (context, reviewController, _) {
                  return Row(children: [
                    // if(reviewController.reviewList!=null)

                    Text.rich(TextSpan(children: [
                      TextSpan(text: '${details.productDetailsModel!.reviews != null ? details.productDetailsModel!.reviews!.length : 0} ',
                          style: GoogleFonts.tajawal(
                              color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                              Theme.of(context).hintColor : Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeDefault)),
                      TextSpan(text: '${getTranslated('Product_Reviews', context)}  | ',
                          style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,))])),

// if(details.orderCount!=null)
                     Text.rich(TextSpan(children: [
                      TextSpan(text: '${details.productDetailsModel!.orderCount ?? 0} ', style: GoogleFonts.tajawal(
                          color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                          Theme.of(context).hintColor : Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeDefault)),
                      TextSpan(text: '${getTranslated('orders', context)}  | ',
                          style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,))])),
// if(details.wishCount!=null)
                    Text.rich(TextSpan(children: [
                      TextSpan(text: '${details.productDetailsModel!.wishList!.length} ', style: GoogleFonts.tajawal(
                          color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                          Theme.of(context).hintColor : Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeDefault)),
                      TextSpan(text: '${getTranslated('wish_listed', context)}',
                          style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,))])),
                  ]);}),
            const SizedBox(height: Dimensions.paddingSizeSmall),


            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text('${startingPrice != null ? PriceConverter.convertPrice(context, startingPrice,
                  discount: productModel!.discount, discountType: productModel!.discountType):''}'
                  '${endingPrice !=null ? ' - ${PriceConverter.convertPrice(context, endingPrice,
                  discount: productModel!.discount, discountType: productModel!.discountType)}' : ''}',
                  style: GoogleFonts.tajawal(color: ColorResources.getPrimary(context),
                      fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w700)),

              if(productModel!.discount != null && productModel!.discount! > 0)...[
                const SizedBox(width: Dimensions.paddingSizeSmall),

                Text('${PriceConverter.convertPrice(context, startingPrice)}'
                    '${endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, endingPrice)}' : ''}',
                    style: GoogleFonts.tajawal(color: Theme.of(context).hintColor,
                        decoration: TextDecoration.lineThrough)),
              ],
            ]),
            const SizedBox(height: Dimensions.paddingSizeSmall),











          ]);
        },
      ),
    ):const SizedBox();
  }
}
