import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/controllers/store_setting_controller.dart';
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


class ProductWidget extends StatefulWidget {
  final Product productModel;
  final int productNameLine;
  final bool? selectActive;
  const ProductWidget({super.key, required this.productModel, this.productNameLine = 2, this.selectActive=false});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
double tax =0.00;

double total =0.00;

  void getTaxAndPrice(){
    if(widget.productModel.tax!=null){
    if(widget.productModel.taxType==null){
      tax =(widget.productModel.tax!/100)*widget.productModel.unitPrice!;
    }else if(widget.productModel.taxType=='percent'){
      tax =(widget.productModel.tax!/100)*widget.productModel.unitPrice!;

    }else{
      tax=widget.productModel.tax!;
    }}
    // double tax =(productModel.taxType!=null&&productModel.taxType=='percent'?(productModel.tax!/100)*productModel.unitPrice!:productModel.tax!);
  // double total = productModel.unitPrice!+(productModel.taxType==null||productModel.taxType=='percent'?(productModel.tax!/100)*productModel.unitPrice!:productModel.tax!);
  }

  @override
  Widget build(BuildContext context) {
    getTaxAndPrice();
    double ratting = (widget.productModel.rating?.isNotEmpty ?? false) ?  double.parse('${widget.productModel.rating?[0].average}') : 0;

    return InkWell(onTap: () {Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(productId: widget.productModel.id,
              product: widget.productModel,
              slug: widget.productModel.slug)));},
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
                    productModel: widget.productModel,
                  ),

                  if(widget.productModel.currentStock! == 0 && widget.productModel.productType == 'physical')...[

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
                          Text(widget.productModel.name ?? '',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start  ,
                  children: [
                    const SizedBox(width: 5,),
                    Expanded(
                      flex: 1,
                      child: Text("${getTranslated('price_value', context)} ${PriceConverter.convertPrice(context,
                          widget.productModel.unitPrice!, discountType: widget.productModel.discountType,
                          discount: widget.productModel.discount ?? 0.00)}ٍ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.tajawal(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 12)),
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(
                        text:"${getTranslated('qty', context)!} :" ,
                        style: GoogleFonts.tajawal(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            // color: Colors.grey,
                            color: Theme.of(context).iconTheme.color

                        ),
                        children: [

                          TextSpan(
                            text: widget.productModel.currentStock.toString()??'0',

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
                    const SizedBox(width: 5,),
                  ],
                ),
                 const SizedBox(height: 3,),
                 Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                   const SizedBox(width: 5,),

                   Expanded(
                     flex: 1,
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
                             text: PriceConverter.convertPrice(context,tax??0.0),

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
if(ratting!=0)
                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [

                     const Icon(Icons.star_rate_rounded, color: Colors.orange,size: 20),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 2.0),
                       child: Text(ratting.toStringAsFixed(1), style: GoogleFonts.cairo(fontSize: Dimensions.fontSizeDefault)),
                     ),
                     Text('(${widget.productModel.reviewCount!=null?widget.productModel.reviewCount.toString():0})',
                         style: GoogleFonts.cairo(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))

                   ]),
                   const SizedBox(width: 5,),



                 ]),




                const SizedBox(height: 5,),

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 0.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         const SizedBox(width: 5,),

                         //
                         Expanded(
                           flex: 2,
                           child: Text("${getTranslated('Total_Payments', context)} ${PriceConverter.convertPrice(context,
                               widget.productModel.unitPrice!+tax, discountType: widget.productModel.discountType,
                               discount: widget.productModel.discount ?? 0.00)}ٍ",
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                               style: GoogleFonts.tajawal(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 12)),
                         ),
                         if(widget.productModel.discount!= null && widget.productModel.discount! > 0 )

                         Expanded(
                           child: Text(PriceConverter.convertPrice(context, widget.productModel.unitPrice),
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
                      if(element.product!.id==widget.productModel.id){
                        inCart=true;
                      }
                    }
                    return Consumer<MyShopController>(
                    builder:(context, myShopController, child) {
                      bool  sync=false;
                      bool linked=false;
                      for (var element in myShopController.pendingList) {
                        if(element.id==widget.productModel.id){
                          sync=true;
                        }
                      } for (var element in myShopController.deleteList) {
                        if(element.id==widget.productModel.id){
                          sync=true;
                        }
                      } for (var element in myShopController.linkedList) {
                        if(element.id==widget.productModel.id){
                          linked=true;
                        }
                      }
                      return Consumer<StoreSettingController>(
                        builder:(context, storeSetting, child) =>  Padding(
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
                                 if(cartProvider.cartList[i].product!.id == widget.productModel.id){
                                   index =i;
                                   cartItem=cartProvider.cartList[i];
                                   if(widget.productModel.currentStock!=cartItem.quantity){

                                     cartProvider.updateCartProductQuantity(cartItem.id, cartItem.quantity!+1, context, true, index,product: true);
                                   }else{
                                     showCustomSnackBar(getTranslated('out_of_stock', context), context);

                                   }


                                 }
                               }


                               // showCustomSnackBar(getTranslated('Already_added', context), context);
                             }else
                             if(widget.productModel.currentStock==0){
                               showCustomSnackBar(getTranslated('Out_of_stock', context), context);
                             }else{
                               CartModelBody cart = CartModelBody(
                                 productId: widget.productModel.id,
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
                                      color:widget.productModel.currentStock==0?Colors.grey: Theme.of(context).primaryColor.withOpacity(0.20),
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Center(child: Text(getTranslated('buy', context)!,style: GoogleFonts.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:widget.productModel.currentStock==0?Colors.white: Theme.of(context).iconTheme.color
                                    ),)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  // if (storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails!=null||storeSetting.linkedAccountsList.last.storeDetails!=null){

                                    try{

                          if(widget.productModel.currentStock==0){
                            // Out of stock
                            showCustomSnackBar(getTranslated('Out_of_stock', context), context);

                          }else if(!sync&&!linked){
                            myShopController.addProduct(widget.productModel.id!).then((value) {
                              if(value==true){
                                // get sync product
                                myShopController.getList();
                                // done
                                showCustomSnackBar(getTranslated('Added_to_my_store', context), context,isError: false);

                              }else{
                              // unknown error
                                // showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );

                              }
                            });}else{
                            // Already added
                            showCustomSnackBar(getTranslated('Already_added', context), context,isError: true );
                          }
                        }catch(e){
                                      // unknown error
                          showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );
                        }
                                  // }else{
                                  //   showCustomSnackBar(getTranslated('Unable_to_connect_to_your_marketplace', context), context,time: 3);
                                  // }
                                },

                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color:linked==true?Colors.green:sync||widget.productModel.currentStock==0?Colors.grey: Theme.of(context).primaryColor,
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

          widget.productModel.discount! > 0 ?
          Positioned(top: 10, left: 0, child: Container(
            transform: Matrix4.translationValues(-1, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 3),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                    bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),),

              child: Center(
                child: Directionality(textDirection: TextDirection.ltr,
                  child: Text(PriceConverter.percentageCalculation(context, widget.productModel.unitPrice,
                        widget.productModel.discount, widget.productModel.discountType),
                    style: textBold.copyWith(color: Colors.white,
                        fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center,),
                ))))
              : const SizedBox.shrink(),
          // ,

          Positioned(top: 0, left: 2,
            child: FavouriteButtonWidget(
              product: widget.productModel,
              // backgroundColor: ColorResources.getImageBg(context),
              productId: widget.productModel.id,
            ),
          ),
          widget.selectActive!?  Positioned(top: 0, right: 2,
            child: Consumer<StoreSettingController>(
              builder:(context, storeSetting, child) =>  Consumer<ProductController>(
                builder:(context, product, child) =>  Consumer<MyShopController>(
                  builder:(context, myShopController, child) =>  Checkbox(
                      value: product.productSelect.contains(widget.productModel.id),
                      onChanged: (val){
                  // if (storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails!=null||storeSetting.linkedAccountsList.last.storeDetails!=null){

                        // for (var element in widget.products) {
                          bool  sync=false;
                          for (var elm in myShopController.pendingList) {
                            if(elm.id==widget.productModel.id){
                              sync=true;
                            }
                          } for (var elm in myShopController.deleteList) {
                            if(elm.id==widget.productModel.id!){
                              sync=true;
                            }
                          } for (var elm in myShopController.linkedList) {
                            if(elm.id==widget.productModel.id!){
                              sync=true;
                            }
                          }
                          if(widget.productModel.currentStock==0){
                            showCustomSnackBar(getTranslated('Out_of_stock', context), context);

                          }else if(sync){
                            showCustomSnackBar(getTranslated('Already_added', context), context,isError: true );

                          }else{
                            product.selectProduct(widget.productModel.id!,true);


                          }
                      // }else{
                    // showCustomSnackBar(getTranslated('Unable_to_connect_to_your_marketplace', context), context,time: 3);
                  //
                  // }

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
              ),
            ),):const SizedBox.shrink()
        ]),
      ),
    );
  }
}
