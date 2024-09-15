import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_directionality_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/domain/models/wishlist_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/widgets/remove_from_wishlist_bottom_sheet_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/domain/models/cart_model.dart';
import '../../my shop/controllers/my_shop_controller.dart';

class WishListWidget extends StatelessWidget {
  final WishlistModel? wishlistModel;
  final int? index;
  const WishListWidget({super.key, this.wishlistModel, this.index});

  @override
  Widget build(BuildContext context) {
    final bool isLtr = Provider.of<LocalizationController>(context, listen: false).isLtr;

    return InkWell(
onTap: (){
  Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetails(productId: wishlistModel?.product!.id, slug: wishlistModel?.product!.slug),));
},
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          margin: const EdgeInsets.only(top: Dimensions.marginSizeSmall),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)),],
              color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(5)),
          child: IntrinsicHeight(
            child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,children: [
              Container(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.25)),),
                child: ClipRRect(borderRadius: BorderRadius.circular(12),
                  child: Container(
                    // constraints: const BoxConstraints(maxHeight: 90),
                    child: CustomImageWidget(width: 90,height: 110,
                      image: '${wishlistModel?.product!.imagesFullUrl!}',
                      fit: BoxFit.fill,
                    ),
                  ))),



                  wishlistModel?.product!.unitPrice!= null && wishlistModel!.product!.discount! > 0?
                  Positioned(top: Dimensions.paddingSizeSmall, left: isLtr ? 0 : null, right: isLtr ? null : 0,
                    child: Container(height: 20, padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(isLtr ?  Dimensions.paddingSizeExtraSmall : 0),
                          left: Radius.circular(isLtr ? 0 : Dimensions.paddingSizeExtraSmall),
                        ),
                          color: Theme.of(context).primaryColor,
                        ),
                      child: Text(wishlistModel?.product!.unitPrice!=null &&
                          wishlistModel?.product!.discount != null &&
                          wishlistModel?.product!.discountType != null?
                      PriceConverter.percentageCalculation(context, wishlistModel?.product!.unitPrice,
                          wishlistModel!.product!.discount, wishlistModel?.product!.discountType) : '',
                        style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeExtraSmall, color: Colors.white,fontWeight: FontWeight.w500)))):const SizedBox(),
              const SizedBox(width: Dimensions.paddingSizeSmall),


              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(wishlistModel?.product?.name ?? '',maxLines: 2,overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(
                          fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400))),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),


                  InkWell(onTap: (){showModalBottomSheet(backgroundColor: Colors.transparent,
                      context: context, builder: (_) => RemoveFromWishlistBottomSheet(
                          productId : wishlistModel!.product!.id!, index: index!));},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        child: Image.asset(Images.heart, scale: 3, color: ColorResources.getRed(context).withOpacity(.90),width: 20,))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Row(children: [

                  Flexible(child: CustomDirectionalityWidget(child: Text(

                    '${getTranslated('price_value', context)} :${     PriceConverter.convertPrice(
      context, wishlistModel!.product!.unitPrice,
      discount: wishlistModel!.product!.discount,
      discountType: wishlistModel!.product!.discountType,
      )}' ,

                    maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.tajawal(
                      // color: ColorResources.getPrimary(context),
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w400,
                    ),
                  ))),
      const SizedBox(width: 3,),
                  wishlistModel!.product!.taxModel == 'exclude'?
                  Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                    child: Text('(${getTranslated('tax', context)} :${PriceConverter.convertPrice(context, wishlistModel!.product!.tax)})',
                      style: GoogleFonts.tajawal(
                          fontSize: 14,color: Colors.grey),),):

                  Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: Text('(${getTranslated('tax', context)} ${wishlistModel!.product!.taxModel})',
                          style: GoogleFonts.tajawal(
                              color: Colors.grey,
                              fontSize: 14))),




                ]),


                Consumer<CartController>(
                  builder:(context, cartProvider, child) {
                    bool inCart=false;
                    for (var element in cartProvider.cartList) {

                      if(element.product!.id.toString()==wishlistModel!.product!.id.toString()){
                        inCart=true;
                        print('object');
                      }
                    }
                    return Consumer<MyShopController>(
                      builder:(context, myShopController, child) {
                        bool  sync=false;
                        for (var element in myShopController.pendingList) {
                          if(element.id==wishlistModel!.product!.id){
                            sync=true;
                          }
                        } for (var element in myShopController.deleteList) {
                          if(element.id==wishlistModel!.product!.id){
                            sync=true;
                          }
                        } for (var element in myShopController.linkedList) {
                          if(element.id==wishlistModel!.product!.id){
                            sync=true;
                          }
                        }
                        return Row(children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                CartModelBody cart = CartModelBody(
                                  productId: wishlistModel!.product!.id,
                                  quantity: 1,
                                );
                                Provider.of<CartController>(context, listen: false).addToCartAPI(
                                    cart, context, []);
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:inCart?Colors.grey: Theme.of(context).primaryColor.withOpacity(0.20),
                                ),
                                child:    Center(
                                  child: Text(getTranslated('buy', context)!,style: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:inCart?Colors.white: Colors.black
                                  ),),
                                ),
                              ),
                            ),
                          ),

                      const SizedBox(width: 5,),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                if(sync==false){
                                  myShopController.addProduct(wishlistModel!.product!.id!).then((value) {
                                    if(value==true){
                                      showCustomSnackBar(getTranslated('Added_to_my_store', context), context,isError: false);
                                      myShopController.getList();
                                    }else{
                                      showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );

                                    }
                                  });}
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:sync?Colors.grey: Theme.of(context).primaryColor,

                                ),
                                child: Center(
                                  child: Text(getTranslated('sync', context)!,style: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),),
                                ),
                              ),
                            ),

                          ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                      //   child: InkWell(
                      //     onTap: (){
                      //     Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
                      //       pageBuilder: (context, anim1, anim2) => ProductDetails(productId: wishlistModel!.product!.id,
                      //           slug: wishlistModel!.product!.slug, isFromWishList: true)));},
                      //     child: Container(height: 40,
                      //       padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      //       alignment: Alignment.center, decoration: BoxDecoration(
                      //           color: Theme.of(context).highlightColor,
                      //           border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.35)),
                      //           boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme? null :
                      //           [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 75, offset: const Offset(0, 1),),],
                      //           borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                      //       child: Icon(Icons.shopping_cart_outlined, color: Theme.of(context).primaryColor, size: 25),
                      //     ),
                      //   ),
                      // ),
                                      ],
                                      );
                      },
                    );
                  },
                ),
              ])),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),

            ],),
          ),
        ),
      ),
    );
  }
}
