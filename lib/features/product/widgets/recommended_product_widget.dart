import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/recommended_product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/domain/models/cart_model.dart';
import '../../my shop/controllers/my_shop_controller.dart';


class RecommendedProductWidget extends StatelessWidget {
  final bool fromAsterTheme;
  const RecommendedProductWidget({super.key,  this.fromAsterTheme = false});


  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeDefault),
      color: const Color(0xFFD9D9D9),
      child: Column(children: [
          Consumer<ProductController>(
            builder: (context, recommended, child) {

              return  recommended.recommendedProduct != null?
              InkWell(onTap: () {
                  Navigator.push(context, PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 1000),
                    pageBuilder: (context, anim1, anim2) => ProductDetails(productId: recommended.recommendedProduct!.id,
                      slug: recommended.recommendedProduct!.slug)));
                },
                child: Column(children: [

                  fromAsterTheme?
                      Column(children: [
                        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Text(getTranslated('dont_miss_the_chance', context)??'',
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                                color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                Theme.of(context).hintColor : Theme.of(context).primaryColor),),),

                        Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                          child: Text(getTranslated('lets_shopping_today', context)??'',
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                                color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                Theme.of(context).hintColor : Theme.of(context).primaryColor)))]):


                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Text(getTranslated('deal_of_the_day', context)??'',
                            style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeExtraLarge,
                                color: Colors.black),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                           borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageWidget(image: recommended.recommendedProduct!.imagesFullUrl!,width: 85,height: 85,)
                              ,
                              const SizedBox(width: 5,),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.50,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(recommended.recommendedProduct!.name!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.tajawal(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15
                                          ),),
                                        ),
                                         FavouriteButtonWidget(productId: recommended.recommendedProduct!.id!,)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.50,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                     const Icon(Icons.star,color: Color(0xFFFFD800),size: 20,),
                                     const SizedBox(width: 3,),

                                     Text(recommended.recommendedProduct!.reviewCount!.toString(),style: GoogleFonts.cairo(),),
                                     const SizedBox(width: 3,),
                                     Text('(${recommended.recommendedProduct!.reviewCount!.toString()})',style: GoogleFonts.cairo(

                                     ),),
                                        // const Spacer(),

                                        // Container(
                                        //   height: 30,
                                        //   width: 100,
                                        //  decoration: BoxDecoration(
                                        //    borderRadius: BorderRadius.circular(12),
                                        //    color: const Color(0xFFDED9EB)
                                        //  ),
                                        //   child: Center(child: Text(getTranslated('details', context)!,style: GoogleFonts.tajawal(
                                        //     fontWeight: FontWeight.w500,
                                        //     fontSize: 14,
                                        //     color: Colors.black
                                        //   ),)),
                                        // ),

                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),

                                  Consumer<CartController>(
                                    builder:(context, cartProvider, child) {
                                      bool inCart=false;
                                      for (var element in cartProvider.cartList) {
                                        if(element.id==recommended.recommendedProduct!.id){
                                          inCart=true;
                                        }
                                      }
                                      return Consumer<MyShopController>(
                                        builder:(context, myShopController, child) {
                                          bool  sync=false;
                                          for (var element in myShopController.pendingList) {
                                            if(element.id==recommended.recommendedProduct!.id){
                                              sync=true;
                                            }
                                          } for (var element in myShopController.deleteList) {
                                            if(element.id==recommended.recommendedProduct!.id){
                                              sync=true;
                                            }
                                          } for (var element in myShopController.linkedList) {
                                            if(element.id==recommended.recommendedProduct!.id){
                                              sync=true;
                                            }
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            child: Container(
                                              height: 30,
                                              width: 180,
                                              child: Row(
                                                children: [

                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: (){

                                                        if(sync==false){
                                                          myShopController.addProduct(recommended.recommendedProduct!.id!).then((value) {
                                                            if(value==true){
                                                              showCustomSnackBar(getTranslated('Added_to_my_store', context), context,isError: false);
                                                              myShopController.getList();
                                                            }else{
                                                              showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );

                                                            }
                                                          });}
                                                      },

                                                      child: Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color:sync?Colors.grey: Theme.of(context).primaryColor,
                                                            borderRadius: BorderRadius.circular(4)
                                                        ),
                                                        child: Center(child: Text(getTranslated('sync', context)!,style: GoogleFonts.tajawal(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white
                                                        ),)),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5,),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: (){
                                                        CartModelBody cart = CartModelBody(
                                                          productId: recommended.recommendedProduct!.id,
                                                          quantity: 1,
                                                        );
                                                        Provider.of<CartController>(context, listen: false).addToCartAPI(
                                                            cart, context, []);
                                                      },
                                                      child: Container(
                                                        height: 30,

                                                        decoration: BoxDecoration(
                                                            color:inCart?Colors.grey: Theme.of(context).primaryColor.withOpacity(0.20),
                                                            borderRadius: BorderRadius.circular(4)
                                                        ),
                                                        child: Center(child: Text(getTranslated('buy', context)!,style: GoogleFonts.tajawal(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black
                                                        ),)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )



                    // Stack(children: [
                    //   Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                    //     child: Container(
                    //       padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    //       decoration: BoxDecoration(
                    //         borderRadius:  const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
                    //         color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                    //         Theme.of(context).highlightColor : Theme.of(context).highlightColor,
                    //         border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.3),width: 1)
                    //       ),
                    //         child: Row(children: [
                    //           recommended.recommendedProduct !=null && recommended.recommendedProduct!.thumbnail !=null?
                    //           Container(
                    //             height: (recommended.recommendedProduct!.currentStock! < recommended.recommendedProduct!.minimumOrderQuantity! &&
                    //                 recommended.recommendedProduct!.productType == 'physical')? 170:150,
                    //             decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                    //                 border: Border.all(color: Theme.of(context).primaryColor,width: .5),
                    //                 borderRadius: const BorderRadius.all(Radius.circular(5))),
                    //             child: LayoutBuilder(builder: (context, boxConstraint)=> ClipRRect(
                    //                   borderRadius: const BorderRadius.all(Radius.circular(5)),
                    //                   child: Stack(
                    //                     children: [
                    //                       CustomImageWidget(
                    //                         height: ResponsiveHelper.isTab(context) ? 250 :  size.width * 0.4,
                    //                         width: ResponsiveHelper.isTab(context) ? 230 : size.width * 0.4,
                    //                         image: '${recommended.recommendedProduct?.imagesFullUrl}',
                    //                       ),
                    //
                    //                       if(recommended.recommendedProduct!.currentStock! == 0 &&
                    //                           recommended.recommendedProduct!.productType == 'physical')
                    //                         Positioned.fill(child: Align(
                    //                         alignment: Alignment.bottomCenter,
                    //                         child: Container(
                    //                           width: ResponsiveHelper.isTab(context) ? 230 : size.width * 0.4,
                    //                           decoration: BoxDecoration(
                    //                               color: Theme.of(context).colorScheme.error.withOpacity(0.4),
                    //                               borderRadius: const BorderRadius.only(
                    //                                 topLeft: Radius.circular(Dimensions.radiusSmall),
                    //                                 topRight: Radius.circular(Dimensions.radiusSmall),
                    //                               )
                    //                           ),
                    //                           child: Text(
                    //                             getTranslated('out_of_stock', context)??'',
                    //                             style: textBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall),
                    //                             textAlign: TextAlign.center,
                    //                           ),
                    //                         ),
                    //                       )),
                    //                     ],
                    //                   )
                    //                 )
                    //             )):const SizedBox(),
                    //
                    //           const SizedBox(width: Dimensions.paddingSizeDefault),
                    //           Expanded(
                    //             child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //
                    //                 Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center, children: [
                    //                     Icon(Icons.star, color: Provider.of<ThemeController>(context).darkTheme ?
                    //                     Colors.white : Colors.orange, size: 15),
                    //
                    //                     Text(double.parse(ratting!).toStringAsFixed(1),
                    //                         style: titilliumBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    //
                    //                     Text('(${ recommended.recommendedProduct?.reviewCount ?? '0'})', style:
                    //                     textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                    //                         color: Theme.of(context).hintColor)),]),
                    //                 const SizedBox(height: Dimensions.paddingSizeSmall,),
                    //
                    //                 FittedBox(
                    //                   child: Row(children: [
                    //                       const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall),
                    //                       recommended.recommendedProduct !=null && recommended.recommendedProduct!.discount!= null &&
                    //                           recommended.recommendedProduct!.discount! > 0  ? Text(
                    //                         PriceConverter.convertPrice(context, recommended.recommendedProduct!.unitPrice),
                    //                         style: textRegular.copyWith(color: Theme.of(context).hintColor,
                    //                           decoration: TextDecoration.lineThrough, fontSize: Dimensions.fontSizeSmall,),
                    //                       ) : const SizedBox.shrink(),
                    //                       const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall,
                    //                           width: Dimensions.paddingSizeExtraSmall),
                    //
                    //                       recommended.recommendedProduct != null && recommended.recommendedProduct!.unitPrice != null?
                    //                       Text(PriceConverter.convertPrice(context, recommended.recommendedProduct!.unitPrice,
                    //                             discountType: recommended.recommendedProduct!.discountType,
                    //                             discount: recommended.recommendedProduct!.discount),
                    //                         style: textBold.copyWith(color: ColorResources.getPrimary(context),
                    //                           fontSize: Dimensions.fontSizeLarge)):const SizedBox(),
                    //                     ])),
                    //                 const SizedBox(height: Dimensions.paddingSizeSmall,),
                    //
                    //
                    //                 SizedBox(width: MediaQuery.of(context).size.width/2.5,
                    //                   child: Text(recommended.recommendedProduct!.name??'',maxLines: 2, overflow: TextOverflow.ellipsis,
                    //                       style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge))),
                    //
                    //                 Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                    //                   child: Container(width: 110,height: 35,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeOverLarge)),
                    //                       color: Theme.of(context).primaryColor),
                    //                     child: Center(child: Text(getTranslated('buy_now', context)!,
                    //                       style: const TextStyle(color: Colors.white)))))
                    //               ],),
                    //           ),
                    //         ],
                    //         ),
                    //       ),
                    //     ),
                    //
                    //
                    //
                    //     Positioned(top: 8, right: isLtr ? 25 : null, left: !isLtr ? 25 : null, child: FavouriteButtonWidget(
                    //       backgroundColor: ColorResources.getImageBg(context),
                    //       productId: recommended.recommendedProduct?.id)),
                    //
                    //
                    //     recommended.recommendedProduct !=null && recommended.recommendedProduct!.discount!= null &&
                    //         recommended.recommendedProduct!.discount! > 0  ?
                    //     Positioned(top: 25, left: isLtr ? 32 : null, right: !isLtr ? 27 : null, child: Container(height: 20,
                    //       padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                    //       decoration: BoxDecoration(
                    //         color: ColorResources.getPrimary(context),
                    //         borderRadius: BorderRadius.only(
                    //           bottomRight: Radius.circular( isLtr ? 5 : 0),
                    //           topRight: Radius.circular( isLtr ? 5 : 0),
                    //           bottomLeft: Radius.circular( isLtr ? 0 : 5),
                    //           topLeft: Radius.circular( isLtr ? 0 :  5),
                    //
                    //         ),
                    //       ),
                    //
                    //
                    //       child: Center(child: Directionality(
                    //         textDirection: TextDirection.ltr,
                    //         child: Text(PriceConverter.percentageCalculation(context,
                    //             recommended.recommendedProduct!.unitPrice,
                    //               recommended.recommendedProduct!.discount, recommended.recommendedProduct!.discountType),
                    //             style: textRegular.copyWith(color: Theme.of(context).highlightColor,
                    //                 fontSize: Dimensions.fontSizeSmall),
                    //           ),
                    //       )))) : const SizedBox.shrink(),
                    //   ],
                    // ),
                  ],
                ),
              ):const SizedBox.shrink();

            },
          ),
        ],
      ),
    );
  }


}

