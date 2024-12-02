import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReviewAndSpecificationSectionWidget extends StatelessWidget {
  const ReviewAndSpecificationSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsController>(
      builder: (context, productDetailsController, _) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [


          Expanded(

            child: InkWell(onTap: ()=> productDetailsController.selectReviewSection(0),
                child: Column(children: [
                  Container(padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeSmall),
                    // width:  MediaQuery.of(context).size.width/3,
                    height: 40,

                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    ),
                    child: Center(
                      child: Text('${getTranslated('specification', context)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.tajawal(fontWeight:FontWeight.w400,fontSize: 14,color: productDetailsController.index==0?Theme.of(context).primaryColor:Theme.of(context).iconTheme.color),),
                    ),),
                  // if(productDetailsController.index==0)
                    Container( height: 3,color: productDetailsController.index==0? Theme.of(context).primaryColor:Theme.of(context).cardColor,)])),
          ),
          // const SizedBox(width: Dimensions.paddingSizeDefault),


            Expanded(
              child: InkWell(onTap: ()=> productDetailsController.selectReviewSection(1),
                child: Column(children: [
                  Container(padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeSmall),
                    // width:  MediaQuery.of(context).size.width/3,
                    height: 40,

                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        // color: productDetailsController.index==1? Provider.of<ThemeController>(context, listen: false).darkTheme?
                        // Theme.of(context).hintColor.withOpacity(.25) :
                        // Theme.of(context).primaryColor.withOpacity(.05):Colors.transparent
                    ),
                    child: Center(
                      child: Text('${getTranslated('Logistics_information', context)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:  GoogleFonts.tajawal(fontWeight:FontWeight.w400,fontSize: 14,color:productDetailsController.index==1?Theme.of(context).primaryColor:Theme.of(context).iconTheme.color),),
                    ),),
                  // if(productDetailsController.index==1)
                    Container(height: 3,color:productDetailsController.index==1? Theme.of(context).primaryColor:Theme.of(context).cardColor,)])),
            ),
          // const SizedBox(width: Dimensions.paddingSizeDefault),


  if(productDetailsController.productDetailsModel!=null&&productDetailsController.productDetailsModel!.reviewsCount!=null&&productDetailsController.productDetailsModel!.reviewsCount!=0)
          Expanded(
            // flex: 1,
            child: InkWell(onTap: ()=> productDetailsController.selectReviewSection(2),
              child: Stack(clipBehavior: Clip.none, children: [
                Column(children: [
                  Container(padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeSmall),
                    height: 40,
                    // width:  MediaQuery.of(context).size.width/3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    ),
                    child: Center(
                      child: Text('${getTranslated('reviews', context)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style:  GoogleFonts.tajawal(fontWeight:FontWeight.w400,fontSize: 14,
                          color:productDetailsController.index==2?Theme.of(context).primaryColor:Theme.of(context).iconTheme.color),),
                    ),),


                  // if(productDetailsController.isReviewSelected)
                  // if()

                    Container(height: 3,color:productDetailsController.index==2? Theme.of(context).primaryColor:Theme.of(context).cardColor)]),

              ],
              ),
            ),
          )
        ],);
      }
    );
  }
}
