
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/product_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ProductTitleWidget extends StatelessWidget {
  final ProductDetailsModel? productModel;
  final String? averageRatting;
  const ProductTitleWidget({super.key, required this.productModel, this.averageRatting});

  @override
  Widget build(BuildContext context) {

    ProductHelper.getProductPriceRange(productModel);

    return productModel != null? Container(
      padding: const EdgeInsets.symmetric(horizontal : Dimensions.homePagePadding),
      child: Consumer<ProductDetailsController>(
        builder: (context, details, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text(productModel!.name ?? '',
                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w400,), ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            const SizedBox(height: Dimensions.paddingSizeSmall),



            Consumer<ReviewController>(
                builder: (context, reviewController, _) {
                  return Row(children: [

                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Row(
                        children: [
                          const Icon(Icons.star,color:Colors.yellow,),
                          const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('${details.productDetailsModel!.reviews != null ? details.productDetailsModel!.reviews!.length : 0} ',
                                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,
                                  color:  Provider.of<ThemeController>(context, listen: false).darkTheme?
                                            Theme.of(context).hintColor : Theme.of(context).primaryColor,
                                ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text('|',  style: TextStyle(fontSize: Dimensions.fontSizeDefault,
                              color:  Provider.of<ThemeController>(context, listen: false).darkTheme?
                              Theme.of(context).hintColor : Theme.of(context).primaryColor,

                            ),),
                          )
                        ],
                      ),
                    ),
const SizedBox(width: 5,),
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
                      TextSpan(text: '${details.productDetailsModel!.wishList!=null?details.productDetailsModel!.wishList!.length:0} ', style: GoogleFonts.tajawal(
                          color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                          Theme.of(context).hintColor : Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeDefault)),
                      TextSpan(text: '${getTranslated('wish_listed', context)}',
                          style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,))])),
                  ]);}),
            const SizedBox(height: Dimensions.paddingSizeSmall),



            const SizedBox(height: Dimensions.paddingSizeSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.start  ,
              children: [
                const SizedBox(width: 5,),
                Expanded(
                  flex: 1,
                  child: Text("${getTranslated('price_value', context)} ${PriceConverter.convertPrice(context,
                      productModel!.unitPrice??0, discountType: productModel!.discountType,
                      discount: productModel!.discount ?? 0.00)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).iconTheme.color
                          ,
                          fontSize: 14
                      )),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("${getTranslated('qty', context)!} ${productModel!.currentStock.toString()}",style:  GoogleFonts.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            // color: Colors.grey,
                            color: Theme.of(context).iconTheme.color

                            ),),
                ),




                const SizedBox(width: 5,),
              ],
            ),
            const SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(width: 5,),

              Expanded(
                flex: 1,
                child: RichText(
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    text:"${getTranslated('tax', context)} " ,
                    style: GoogleFonts.tajawal(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        // color: Colors.grey,
                        color: Theme.of(context).iconTheme.color

                    ),
                    children: [

                      TextSpan(
                        text:PriceConverter.calculationTaxString(context, productModel!.unitPrice, productModel!.tax??0.00, productModel!.taxType??''),

                        style:  GoogleFonts.tajawal(
                            fontWeight: FontWeight.w400,
                            // color: Colors.red,
                            fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ),
              ),




            ]),
            if(productModel!.discount!=0.00)
            const SizedBox(height: 5,),
            if(productModel!.discount!=0.00)
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(width: 5,),
              Expanded(
                flex: 2,
                child: Text("${getTranslated('Product_discount', context)} ${PriceConverter.convertPrice(context,productModel!.discount!)}" ,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).iconTheme.color
                        ,
                        fontSize: 14)),
              ),


            ]),

            const SizedBox(height: 5,),

            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(width: 5,),
              Expanded(
                flex: 2,
                child: Text("${getTranslated('total', context)} ${ PriceConverter.convertPrice(context,
          (productModel!.unitPrice!=null?productModel!.unitPrice!:0)+PriceConverter.calculationTaxDouble(context, productModel!.unitPrice, productModel!.tax??0.00, productModel!.taxType??''), discountType: productModel!.discountType,
          discount: productModel!.discount ?? 0.00)}" ,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tajawal(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,fontSize: 16)),
              ),


            ]),



            const SizedBox(height: 10,),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       const SizedBox(width: 5,),
            //
            //       //
            //
            //       if(productModel!.discount!= null && productModel!.discount! > 0 )
            //
            //         Expanded(
            //           child: Text(PriceConverter.convertPrice(context, productModel!.unitPrice),
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //
            //               style: GoogleFonts.tajawal(color: Theme.of(context).hintColor,fontWeight: FontWeight.w500,
            //                   decoration: TextDecoration.lineThrough, fontSize:10)),
            //         )
            //       // : const SizedBox.shrink(),
            //     ],
            //   ),
            // ),


          ]);
        },
      ),
    ):const SizedBox();
  }
}
