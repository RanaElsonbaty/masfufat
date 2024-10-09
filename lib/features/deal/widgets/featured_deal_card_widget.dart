import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';

import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/domain/models/cart_model.dart';
import '../../my shop/controllers/my_shop_controller.dart';

class FeaturedDealWidget extends StatelessWidget {
  final Product product;
  final bool isHomePage;
  final bool? isCenterElement;
  const FeaturedDealWidget({super.key, required this.product, required this.isHomePage, this.isCenterElement});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(productId: product.id,slug: product.slug, product: product,))),

      child: LayoutBuilder(
        builder: (context, constrains) {
          return AnimatedContainer(
            margin: isCenterElement == null ? null :  EdgeInsets.symmetric(vertical : isCenterElement! ? 0 : 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: Theme.of(context).cardColor,
                border: Border.all(color: Theme.of(context).colorScheme.onTertiary),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.05), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 5)),
                ]),

            duration: const Duration(milliseconds: 600),
            child: Stack(children: [
              Row(children: [

                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    child: CustomImageWidget(
                      image: '${product.imagesFullUrl}',
                      height: constrains.maxHeight * 0.8,
                      width: constrains.maxHeight * 0.6,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(product.currentStock! == 0 && product.productType == 'physical')
                            Text(getTranslated('out_of_stock', context)??'',
                                style: GoogleFonts.tajawal(color: const Color(0xFFF31B1B),fontSize: 12,fontWeight: FontWeight.w500)),
                            FavouriteButtonWidget(
                                backgroundColor: ColorResources.getImageBg(context), productId: product.id, product: product,),
                          ],
                        ),

                      // const SizedBox(height: Dimensions.paddingSizeSmall),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Icon(Icons.star_rate_rounded, color: Provider.of<ThemeController>(context).darkTheme ?
                          Colors.white : Colors.orange, size: 16),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            product.rating != null && product.rating!.isNotEmpty ? double.parse(product.rating![0].average!).toStringAsFixed(1) : '0.0',
                            style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeExtraSmall,fontWeight: FontWeight.w500,),
                          ),
                        ),

                        Text('(${product.reviewCount.toString()})', style: GoogleFonts.tajawal(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeExtraSmall,
                        )),

                      ]),
                      // const SizedBox(height: Dimensions.paddingSizeSmall),


                      Row(children: [
                        Flexible(child: Text(
                          product.name ?? '', style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w500),
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                        )),

                        const SizedBox(width: Dimensions.paddingSizeDefault),
                      ]),
                      const SizedBox(height: Dimensions.paddingSizeSmall),


                      FittedBox(child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text(product.discount! > 0 ? PriceConverter.convertPrice(context, product.unitPrice!.toDouble()) : '',
                            style: GoogleFonts.tajawal(color: Theme.of(context).hintColor,
                                decoration: TextDecoration.lineThrough, fontSize: Dimensions.fontSizeSmall)),

                        product.discount! > 0 ? const SizedBox(width: Dimensions.paddingSizeExtraSmall): const SizedBox(),

                        Text(
                          PriceConverter.convertPrice(
                            context, product.unitPrice??0.0,
                            discountType: product.discountType,
                            discount: product.discount??0.0,
                          ),
                          style: GoogleFonts.tajawal(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w500
                          ),
                        ),

                        const SizedBox(width: Dimensions.paddingSizeSmall),

                      ])), Consumer<CartController>(
                        builder:(context, cartProvider, child) {
                          bool inCart=false;
                          for (var element in cartProvider.cartList) {
                            if(element.id==product.id){
                              inCart=true;
                            }
                          }
                          return Consumer<MyShopController>(
                            builder:(context, myShopController, child) {
                              bool  sync=false;
                              for (var element in myShopController.pendingList) {
                                if(element.id==product.id){
                                  sync=true;
                                }
                              } for (var element in myShopController.deleteList) {
                                if(element.id==product.id){
                                  sync=true;
                                }
                              } for (var element in myShopController.linkedList) {
                                if(element.id==product.id){
                                  sync=true;
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [

                                    Expanded(
                                      child: InkWell(
                                        onTap: (){

                                          if(sync==false){
                                            myShopController.addProduct(product.id!).then((value) {
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
                                            productId: product.id,
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
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                )),
              ]),


              product.discount! > 0 ? Positioned(top: 20, left: 10,
                child: Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: ColorResources.getPrimary(context),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))),
                  child: Directionality(textDirection: TextDirection.ltr,
                    child: Text(PriceConverter.percentageCalculation(
                        context, product.unitPrice!.toDouble(), product.discount!.toDouble(), product.discountType),
                      style: textRegular.copyWith(color: Theme.of(context).highlightColor, fontSize: Dimensions.fontSizeSmall)),
                  )),
              ) : const SizedBox.shrink(),


            ]),
          );
        }
      ),
    );
  }
}
