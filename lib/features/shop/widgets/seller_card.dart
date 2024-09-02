import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/domain/models/seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/shop_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SellerCard extends StatefulWidget {
  final SellerModel? sellerModel;
  final bool isHomePage;
  final int index;
  final int length;
  const SellerCard({super.key, this.sellerModel, this.isHomePage = false, required this.index, required this.length});

  @override
  State<SellerCard> createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  bool vacationIsOn = false;
  @override
  Widget build(BuildContext context) {
    var splashController = Provider.of<SplashController>(context, listen: false);
    // print('asdasdadasdasd${splashController.baseUrls!.shopImageUrl}');
    if(widget.sellerModel!.vacationEndDate != null){
      DateTime vacationDate = DateTime.parse(widget.sellerModel!.vacationEndDate!);
      DateTime vacationStartDate = DateTime.parse(widget.sellerModel!.vacationStartDate!);
      final today = DateTime.now();
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;
      if(difference >= 0 && widget.sellerModel!.vacationStatus==1 && startDate <= 0){
        vacationIsOn = true;
      }
      else{
        vacationIsOn = false;
      }
    }


    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
          sellerId: widget.sellerModel?.sellerId,
          temporaryClose: widget.sellerModel?.temporaryClose==1,
          vacationStatus: widget.sellerModel?.vacationStatus==1,
          vacationEndDate: widget.sellerModel?.vacationEndDate,
          vacationStartDate: widget.sellerModel?.vacationStartDate,
          name: widget.sellerModel?.name,
          banner: widget.sellerModel?.banner,
          image: widget.sellerModel?.image,)));
      },
      child : Padding(
        padding: widget.isHomePage? EdgeInsets.only(left : widget.index == 0? Dimensions.paddingSizeDefault :
        Provider.of<LocalizationController>(context, listen: false).isLtr ?
        Dimensions.paddingSizeDefault : 0, right: widget.index + 1 == widget.length?
        Dimensions.paddingSizeDefault : (Provider.of<LocalizationController>(context, listen: false).isLtr && widget.isHomePage) ?
            0 : Dimensions.paddingSizeDefault, bottom: widget.isHomePage?
        Dimensions.paddingSizeExtraSmall: Dimensions.paddingSizeDefault):
        const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,0),
        child: Container(clipBehavior: Clip.none, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.075),
              spreadRadius: 1, blurRadius: 1, offset: const Offset(0,1))]),
          child: Stack(children: [

            SizedBox(height: widget.isHomePage? 100 : 120,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeSmall),
                      topRight: Radius.circular(Dimensions.paddingSizeSmall)),
                  child: CustomImageWidget(
                      fit: BoxFit.fill,
                      image:
                 '${splashController.baseUrls!=null?splashController.baseUrls!.shopImageUrl:''}/banner/${widget.sellerModel!.banner}'))),

          Positioned(
            top: 70,
            left: 70,
            right: 70,
            child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)),
                              child: CustomImageWidget(
                              image:
                              '${splashController.baseUrls!=null?splashController.baseUrls!.shopImageUrl:''}/${widget.sellerModel!.image}',
                                  width: 50,height: 50)),

          ),
            if((widget.sellerModel!.temporaryClose==1) || vacationIsOn)
            Container(decoration: BoxDecoration(color: Colors.black.withOpacity(.5),
                borderRadius: const BorderRadius.all(Radius.circular(8)
                )
            )),
            (widget.sellerModel!.temporaryClose==1) ?
                      Center(child: Text(getTranslated('temporary_closed', context)!, textAlign: TextAlign.center,
                        style: GoogleFonts.tajawal(color: Colors.white, fontSize: Dimensions.fontSizeExtraLarge)))
            :
            vacationIsOn == true?
            Center(child: Text(getTranslated('close_for_now', context)!, textAlign: TextAlign.center,
              style: GoogleFonts.tajawal(color: Colors.white, fontSize: Dimensions.fontSizeExtraLarge),))
            :
            const SizedBox(),
            Positioned(
                left: 5,
                right: 5,
                top: 125,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 15,),
                    Text(widget.sellerModel?.name??'', maxLines: 1,overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(color:const Color(0xFFDED9EB),
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(NumberFormat.compact().format(widget.sellerModel?.totalProducts??0),
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault, color:Theme.of(context).primaryColor),),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                          Text("${getTranslated('products', context)}", style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall)
                          )])),
                    ),
                  ],
                ),
              )
              // Row(children: [
              //     Container(transform: Matrix4.translationValues(12, -20, 0), height: 60, width: 60,
              //       child: Stack(children: [
              //           Container(width: 60,height: 60,
              //               decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)),
              //                 color: Theme.of(context).highlightColor),
              //               child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)),
              //                 child: CustomImageWidget(
              //                 image:
              //                 '${splashController.baseUrls!=null?splashController.baseUrls!.shopImageUrl:''}/${widget.sellerModel!.image}',
              //                     width: 60,height: 60))),
              //
              //
              //         // (widget.sellerModel!.temporaryClose==1) ?
              //         //   Center(child: Text(getTranslated('temporary_closed', context)!, textAlign: TextAlign.center,
              //         //     style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraSmall))):
              //         //   vacationIsOn == true?
              //         //   Center(child: Text(getTranslated('close_for_now', context)!, textAlign: TextAlign.center,
              //         //     style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraSmall),)):
              //         //   const SizedBox()
              //       ])),
              //
              //
              //     const SizedBox(width: Dimensions.paddingSizeLarge),
              //     Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //         // Text(widget.sellerModel?.name??'', maxLines: 1,overflow: TextOverflow.ellipsis,
              //         //   style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
              //         // Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
              //         //   child: Row(children: [
              //         //     Icon(Icons.star_rate_rounded, color: Colors.yellow.shade700, size: 15,),
              //         //     Text("${widget.sellerModel?.totalProducts.toStringAsFixed(1)} ",
              //         //       style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
              //         //     Text(" (${widget.sellerModel?.totalProducts??0})",
              //         //       style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),
              //         //   ]))
              //         ])
              //     )
              //         ]),

            // Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall,
            //     right: Dimensions.paddingSizeSmall, bottom:  Dimensions.paddingSizeSmall),
            //   child: Row( children: [
            //
            //     Expanded(child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            //       decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(.125),
            //           borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
            //       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //         Text(NumberFormat.compact().format(widget.sellerModel?.totalProducts??0),
            //           style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault, color:Theme.of(context).primaryColor),),
            //         const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //
            //         Text("${getTranslated('products', context)}", style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall)
            //         )])
            //         ))])),
            ],
          ),
        ),
      )
    );
  }
}
