import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/domain/models/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/widgets/cart_quantity_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../localization/controllers/localization_controller.dart';

class CartWidget extends StatelessWidget {
  final CartModel? cartModel;
  final int index;
  final bool fromCheckout;
  const CartWidget({super.key, this.cartModel, required this.index, required this.fromCheckout});

  @override
  Widget build(BuildContext context) {
TextEditingController controller =TextEditingController(text: cartModel!.quantity.toString());
    return Consumer<CartController>(
      builder: (context, cartProvider, _) {
        return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,
            Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,0),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(extentRatio: .25,
                motion: const ScrollMotion(), children: [
                  SlidableAction(
                      onPressed: (value){
                        cartProvider.removeFromCartAPI(cartModel?.id, index);
                      },
                      backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.05),
                      foregroundColor: Theme.of(context).colorScheme.error,
                      icon: CupertinoIcons.delete_solid,
                      label: getTranslated('delete', context))]
            ),

            child: Container(decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                // border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.15), width: .75)
            ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [



                Expanded(child: IntrinsicHeight(
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment:  MainAxisAlignment.start, children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(onTap: (){
                        Navigator.push(context, PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 1000),
                            pageBuilder: (context, anim1, anim2) => ProductDetails(productId: cartModel?.productId, slug: cartModel?.slug, product: cartModel!.product!,)));
                      },
                          child: Stack(children: [
                            Container(decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.10),width: 0.5)),
                                child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                    child: CustomImageWidget(image: '${cartModel?.product!.imagesFullUrl}',
                                        height: 70, width: 70))),
                            if(cartModel!.isProductAvailable! == 0)
                              Container(decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                  color: Colors.black.withOpacity(.5)),
                                height: 70, width: 70,
                                child: Center(
                                  child: Text("${getTranslated("not_available", context)}", textAlign: TextAlign.center,
                                    style: textMedium.copyWith(color: Colors.white),),
                                ),)
                          ],
                          )),
                    ),

                    Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,
                        vertical: Dimensions.paddingSizeSmall),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center, children: [
                              Row(children: [
                                Expanded(child: Text(cartModel!.name!, maxLines: 1, overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ))),
                                const SizedBox(width: Dimensions.paddingSizeSmall)]),
                              const SizedBox(height: Dimensions.paddingSizeSmall,),



                              Row(children: [

                                // SizedBox(width: Dimensions.fontSizeSmall,),


                                Text('${getTranslated('price_value', context)}: ${PriceConverter.convertPrice(context, cartModel!.price,
        discount: cartModel!.discount,discountType: 'amount')}',
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.tajawal(

                                      fontWeight: FontWeight.w400,
                                        // color: (cartModel!.shop != null && (cartModel!.shop!.temporaryClose! || cartModel!.shop!.vacationStatus!))?
                                    // Theme.of(context).hintColor:ColorResources.getPrimary(context),
                                        fontSize:14)
        )
                              ,

                              ]
        ),
                              Row(
                                children: [
                                  cartModel!.discount!>0?
                                  Text(
                                      ' ${   PriceConverter.convertPrice(context, cartModel!.price)}'
                                      ,maxLines: 1,overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.tajawal(color: Theme.of(context).hintColor,
                                          decoration: TextDecoration.lineThrough))

                                  :const SizedBox(),
                                ],
                              ),


                              //variation
                              // (cartModel!.variant != null && cartModel!.variant!.isNotEmpty) ?
                              // Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                              //     child: Row(children: [
                              //       Flexible(child: Text(cartModel?.variant??'',maxLines: 1,overflow: TextOverflow.ellipsis,
                              //           style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                              //               color: ColorResources.getReviewRattingColor(context))))]))
                                  // : const SizedBox()
                              // ,
                              const SizedBox(width: Dimensions.paddingSizeSmall),


                //               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //                 cartModel!.shippingType !='order_wise'?
                //                 Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                //                     child: Row(children: [
                //                       Text('${getTranslated('shipping_cost', context)}: ',
                //                           style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                //                               // color: (cartModel!.shop != null && (cartModel!.shop!.temporaryClose! || cartModel!.shop!.vacationStatus!))?
                //                               // Theme.of(context).hintColor: ColorResources.getReviewRattingColor(context)
                // )),
                //                       Text(PriceConverter.convertPrice(context, cartModel!.shippingCost),
                //                           style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                //                               color: Theme.of(context).disabledColor))])): const SizedBox()]),

                              cartModel!.taxModel == 'exclude'?
                              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                                child: Text('${getTranslated('tax', context)} :${PriceConverter.convertPrice(context, cartModel?.tax)}',
                                  style: GoogleFonts.tajawal(
                                      fontSize: 14),),):

                              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                                  child: Text('${getTranslated('tax', context)} ${cartModel!.taxModel}',
                                      style: GoogleFonts.tajawal(

                                          fontSize: 14))),

                                Row(
                                  children: [
                                    Text("${getTranslated("qty", context)} : ${cartModel!.productInfo!.totalCurrentStock}",
                                      style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault, ),),

                                    if(cartModel!.quantity!> cartModel!.productInfo!.totalCurrentStock! && cartModel?.productType == "physical")
                                    Text("${getTranslated("out_of_stock", context)}",
                                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.error),),
                                  ],
                                ),


                            ]))),

                    Consumer<LocalizationController>(
                      builder:(context, lanProvider, child) =>  Container(
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.075)),
                            borderRadius: lanProvider.isLtr? const BorderRadius.only(bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                                topRight: Radius.circular(Dimensions.paddingSizeExtraSmall)):const BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.paddingSizeExtraSmall),
                              bottomLeft: Radius.circular(Dimensions.paddingSizeExtraSmall),
                            )
                        ),
                        width: 40,
                        // height: (cartModel!.shippingType !='order_wise' && cartModel!.variant != null && cartModel!.variant!.isNotEmpty)? 185 : (cartModel!.variant != null && cartModel!.variant!.isNotEmpty &&  cartModel!.shippingType =='order_wise')? 125 : (cartModel!.variant == null &&  cartModel!.shippingType !='order_wise')? 160 : 150,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                              cartModel!.increment!?
                              const Padding(padding: EdgeInsets.all(8.0),
                                child: SizedBox(width: 20, height: 20,child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2)),) :

                              CartQuantityButton(index: index, isIncrement: true,
                                  quantity: cartModel!.quantity,
                                  
                                  maxQty: cartModel!.productInfo?.totalCurrentStock,
                                  
                                  cartModel: cartModel, minimumOrderQuantity: cartModel!.productInfo!.minimumOrderQty,
                                  digitalProduct: cartModel!.productType == "digital"? true : false),
                              // Text(cartModel!.quantity.toString(), style: GoogleFonts.cairo(
                              //   color: Colors.white,
                              //   fontWeight: FontWeight.w500,fontSize: 16
                              // )),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: TextFormField(
                                  controller: controller,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  textAlign: TextAlign.center,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: Colors.black,
                                  cursorHeight: 10,
                                  cursorWidth: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                  onFieldSubmitted: (val){
                                      cartProvider.updateCartProductQuantity(cartModel!.id, int.parse(val.toString()), context, true, index);
                                  },
                                ),
                              ),

                              cartModel!.decrement!?  const Padding(padding: EdgeInsets.all(8.0),
                                child: SizedBox(width: 20, height: 20,child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2,)),) :
                              CartQuantityButton(isIncrement: false, index: index,
                                  quantity: cartModel!.quantity,
                                  maxQty: cartModel!.productInfo!.totalCurrentStock,
                                  cartModel: cartModel, minimumOrderQuantity: cartModel!.productInfo!.minimumOrderQty,
                                  digitalProduct: cartModel!.productType == "digital"? true : false)])),
                      ),
                    ),

                  ]),
                ))

              ]),
            ),
          ),
        );
      }
    );
  }
}



