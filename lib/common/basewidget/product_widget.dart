import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../features/cart/controllers/cart_controller.dart';
import '../../features/cart/domain/models/cart_model.dart';
import '../../features/product/widgets/carousel_slider.dart';


class ProductWidget extends StatelessWidget {
  final Product productModel;
  final int productNameLine;
  final bool? selectActive;
  const ProductWidget({super.key, required this.productModel, this.productNameLine = 2, this.selectActive=false});

  @override
  Widget build(BuildContext context) {

    double ratting = (productModel.rating?.isNotEmpty ?? false) ?  double.parse('${productModel.rating?[0].average}') : 0;

    return InkWell(onTap: () {Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(productId: productModel.id,
              product: productModel,
              slug: productModel.slug)));},
      child: Container(
        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow:  [BoxShadow(

            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0, blurRadius: 15,
            offset: const Offset(2, 4),
          )],),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            LayoutBuilder(builder: (context, boxConstraint)=> ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusDefault),
                topRight: Radius.circular(Dimensions.radiusDefault),
              ),
              child: Stack(
                children: [
                  CarouselSliderWidget(
                    isCategory: false,
                    productModel: productModel,
                  ),

                  if(productModel.currentStock! == 0 && productModel.productType == 'physical')...[

                    Positioned.fill(child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 20,
                        width: boxConstraint.maxWidth,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(237, 29, 29, 0.5),
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(Dimensions.radiusSmall),
                            //   topRight: Radius.circular(Dimensions.radiusSmall),
                            // )
                        ),
                        child: Center(
                          child: Text(
                            getTranslated('out_of_stock', context)??'',
                            style: GoogleFonts.cairo(color: Colors.white, fontSize: 10,fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )),

                  ],

                ],
              ),
            )),

            // Product Details
            Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),



                  Padding(padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: Dimensions.paddingSizeSmall),
                    child: SizedBox(
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(productModel.name ?? '',
                              textAlign: TextAlign.center, style: GoogleFonts.tajawal(
                          fontSize:14,
                            fontWeight: FontWeight.w500
                          ), maxLines: 2,


                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    )
                  ),
                // if(ratting > 0)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [

                  const Icon(Icons.star_rate_rounded, color: Colors.orange,size: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(ratting.toStringAsFixed(1), style: GoogleFonts.cairo(fontSize: Dimensions.fontSizeDefault)),
                  ),
                  Text('(${productModel.reviewCount!=null?productModel.reviewCount.toString():0})',
                      style: GoogleFonts.cairo(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))]),
                 const SizedBox(height: 3,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                     Expanded(
                       child: RichText(
                         textAlign: TextAlign.start,
                         overflow: TextOverflow.ellipsis,
                         maxLines: 1,
                         text: TextSpan(
                           text:"${getTranslated('tax', context)}:" ,
                           style: GoogleFonts.tajawal(
                             fontSize: 12,
                             fontWeight: FontWeight.w400,
                             // color: Colors.grey,
                               color: Theme.of(context).iconTheme.color
                                          
                           ),
                           children: [
                                          
                             TextSpan(
                               text: PriceConverter.convertPrice(context,productModel.tax??0.0),

                               style:  GoogleFonts.tajawal(
                                 fontWeight: FontWeight.w400,
                                 color: Colors.red,
                                 fontSize: 12
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     //                  Text('${getTranslated('tax', context)!}:${PriceConverter.convertPrice(context,productModel.tax??0.0)}',style: GoogleFonts.tajawal(
                     //                      fontSize: 12,
                     //                      fontWeight: FontWeight.w400,
                     //                      color: Colors.red
                     //                    ),),
                     // Spacer(),
                     // Text('${getTranslated('qty', context)!}: ${}3123123123131',style: GoogleFonts.tajawal(
                     //   fontSize: 12,
                     //   fontWeight: FontWeight.w400,
                     //   color: Colors.white
                     // ),),

                     RichText(
                       textAlign: TextAlign.start,
                       overflow: TextOverflow.ellipsis,
                       maxLines: 1,
                       text: TextSpan(
                         text:"${getTranslated('qty', context)!}:" ,
                         style: GoogleFonts.tajawal(
                             fontSize: 12,
                             fontWeight: FontWeight.w400,
                             // color: Colors.grey,
                             color: Theme.of(context).iconTheme.color

                         ),
                         children: [

                           TextSpan(
                             text: productModel.currentStock.toString()??'0',

                             style:  GoogleFonts.tajawal(
                                 fontWeight: FontWeight.w400,
                                 color: Theme.of(context).iconTheme.color
                     ,
                                 fontSize: 12
                             ),
                           ),
                         ],
                       ),
                     ),
                   
                   ]),
                 ),




                const SizedBox(height: 5,),

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [

                         //
                         Expanded(
                           flex: 2,
                           child: Text("${getTranslated('Total_Payments', context)} ${PriceConverter.convertPrice(context,
                               productModel.unitPrice, discountType: productModel.discountType,
                               discount: productModel.discount ?? 0.00)}ٍ",
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                               style: GoogleFonts.tajawal(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 12)),
                         ),
                         if(productModel.discount!= null && productModel.discount! > 0 )

                         Expanded(
                           child: Text(PriceConverter.convertPrice(context, productModel.unitPrice),
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,

                               style: GoogleFonts.tajawal(color: Theme.of(context).hintColor,fontWeight: FontWeight.w500,
                                   decoration: TextDecoration.lineThrough, fontSize:10)),
                         )
                         // : const SizedBox.shrink(),
                       ],
                     ),
                   ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Consumer<CartController>(
                  builder:(context, cartProvider, child) {
                    bool inCart=false;
                    for (var element in cartProvider.cartList) {
                      if(element.product!.id==productModel.id){
                        inCart=true;
                      }
                    }
                    return Consumer<MyShopController>(
                    builder:(context, myShopController, child) {
                      bool  sync=false;
                      bool linked=false;
                      for (var element in myShopController.pendingList) {
                        if(element.id==productModel.id){
                          sync=true;
                        }
                      } for (var element in myShopController.deleteList) {
                        if(element.id==productModel.id){
                          sync=true;
                        }
                      } for (var element in myShopController.linkedList) {
                        if(element.id==productModel.id){
                          linked=true;
                        }
                      }
                      return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: ()async{

                         try{
                           if(inCart){
                             if(cartProvider.cartList.isEmpty){
                               await cartProvider.getCartData(context);
                               cartProvider.setCartData();
                             }
                             CartModel? cartItem;
                             int index= 0;
                             for (int i=0;i<cartProvider.cartList.length;i++) {
                               if(cartProvider.cartList[i].product!.id == productModel.id){
                                 index =i;
                                 cartItem=cartProvider.cartList[i];
                                 if(productModel.currentStock!=cartItem.quantity){

                                   cartProvider.updateCartProductQuantity(cartItem.id, cartItem.quantity!+1, context, true, index,product: true);
                                 }else{
                                   showCustomSnackBar(getTranslated('out_of_stock', context), context);

                                 }


                               }
                             }


                             // showCustomSnackBar(getTranslated('Already_added', context), context);
                           }else
                           if(productModel.currentStock==0){
                             showCustomSnackBar(getTranslated('Out_of_stock', context), context);
                           }else{
                             CartModelBody cart = CartModelBody(
                               productId: productModel.id,
                               quantity: 1,
                             );
                             Provider.of<CartController>(context, listen: false).addToCartAPI(
                                 cart, context, []);}
                         }catch(e){
                           showCustomSnackBar(getTranslated('The_product_was_not_added_to_the_cart_successfully', context), context);

                         }
                              },
                              child: Container(
                                height: 30,

                                decoration: BoxDecoration(
                                    color:productModel.currentStock==0?Colors.grey: Theme.of(context).primaryColor.withOpacity(0.20),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Center(child: Text(getTranslated('buy', context)!,style: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:productModel.currentStock==0?Colors.white: Theme.of(context).iconTheme.color
                                  ),)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: InkWell(
                              onTap: (){
try{

  if(productModel.currentStock==0){
    showCustomSnackBar(getTranslated('Out_of_stock', context), context);

  }else if(!sync&&!linked){
    myShopController.addProduct(productModel.id!).then((value) {
      if(value==true){
        myShopController.getList();
        showCustomSnackBar(getTranslated('Added_to_my_store', context), context,isError: false);

      }else{
        showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );

      }
    });}else{
    showCustomSnackBar(getTranslated('Already_added', context), context,isError: true );
  }
}catch(e){
  showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );
}
                              },

                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color:linked==true?Colors.green:sync||productModel.currentStock==0?Colors.grey: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Center(child: Text(linked==false?getTranslated('sync', context)!:getTranslated('synced',context)!,style: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),)),
                                ),
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
            ),
          ]),

          // Off

          productModel.discount! > 0 ?
          Positioned(top: 10, left: 0, child: Container(
            transform: Matrix4.translationValues(-1, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 3),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                    bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),),

              child: Center(
                child: Directionality(textDirection: TextDirection.ltr,
                  child: Text(PriceConverter.percentageCalculation(context, productModel.unitPrice,
                        productModel.discount, productModel.discountType),
                    style: textBold.copyWith(color: Colors.white,
                        fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center,),
                ))))
              : const SizedBox.shrink(),
          // ,

          Positioned(top: 0, left: 2,
            child: FavouriteButtonWidget(
              product: productModel,
              // backgroundColor: ColorResources.getImageBg(context),
              productId: productModel.id,
            ),
          ),
          selectActive!?  Positioned(top: 0, right: 2,
            child: Consumer<ProductController>(
              builder:(context, product, child) =>  Consumer<MyShopController>(
                builder:(context, myShopController, child) =>  Checkbox(
                    value: product.productSelect.contains(productModel.id),
                    onChanged: (val){
                      // for (var element in widget.products) {
                        bool  sync=false;
                        for (var elm in myShopController.pendingList) {
                          if(elm.id==productModel.id){
                            sync=true;
                          }
                        } for (var elm in myShopController.deleteList) {
                          if(elm.id==productModel.id!){
                            sync=true;
                          }
                        } for (var elm in myShopController.linkedList) {
                          if(elm.id==productModel.id!){
                            sync=true;
                          }
                        }
                        if(productModel.currentStock==0){
                          showCustomSnackBar(getTranslated('Out_of_stock', context), context);

                        }else if(sync){
                          showCustomSnackBar(getTranslated('Already_added', context), context,isError: true );

                        }else{
                          product.selectProduct(productModel.id!,true);


                        }

                      // }
                      // product.selectProduct(productModel.id!,true);
                    },
                  checkColor: Colors.white,
                side: const BorderSide(width: 2,color: Colors.grey),
                  activeColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                  ),


                ),
              ),
            ),):const SizedBox.shrink()
        ]),
      ),
    );
  }
}
