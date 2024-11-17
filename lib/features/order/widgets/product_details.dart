import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../common/basewidget/custom_directionality_widget.dart';
import '../../../common/basewidget/custom_image_widget.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../product_details/domain/models/product_details_model.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../../sync order/domain/models/Sync_order_model.dart';

class ProductSyncOrder extends StatefulWidget {
  const ProductSyncOrder({super.key, this.syncOrder, required this.products});
  final SyncOrderModel? syncOrder;
  final  List<ProductDetailsModel> products;

  @override
  State<ProductSyncOrder> createState() => _ProductSyncOrderState();
}

class _ProductSyncOrderState extends State<ProductSyncOrder> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ListView.builder(
          itemCount: widget.products.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return widget.products.isNotEmpty
                ? InkWell(
              onTap: (){
                // Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetails(productId: widget.products[index].id, slug: widget.products[index].slug, product: widget.products.first,),));

              },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: [
                                  Card(color: Theme.of(context).cardColor,
                    child: Column(children: [
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const SizedBox(width: Dimensions.marginSizeDefault),

                        ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                            child: CustomImageWidget(image: widget.products[index].images!=null? widget.products[index].images!.first:'', width: 70, height: 80)),
                        const SizedBox(width: Dimensions.marginSizeDefault),

                        Expanded(flex: 3,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              Expanded(child: Text(widget.products[index].name??'',
                                  style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400),
                                  maxLines: 2, overflow: TextOverflow.ellipsis))]),
                            const SizedBox(height: Dimensions.marginSizeExtraSmall),


                            Row(children: [

                              Text("${getTranslated('price', context)} :",
                                style: GoogleFonts.tajawal( fontSize: 14,fontWeight: FontWeight.w400),),
                              Text(PriceConverter.convertPrice(context, widget.products[index].unitPrice??0.00),
                                style: GoogleFonts.tajawal(  fontSize: 16,fontWeight: FontWeight.w400),),

                              widget.products[index].taxModel == 'exclude'?
                              Text('(${getTranslated('tax', context)} ${PriceConverter.convertPrice(context, widget.products[index].tax??0.00)})',
                                style: GoogleFonts.tajawal(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault),):
                              Text('(${getTranslated('tax', context)} ${widget.products[index].tax??''}%)',
                                  style: GoogleFonts.tajawal(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault))
                            ]),
                            const SizedBox(height: Dimensions.marginSizeExtraSmall),

                            Text('${getTranslated('qty', context)}: ${widget.syncOrder!.details![index].qty!}',
                                style: GoogleFonts.tajawal( fontSize: 14,fontWeight: FontWeight.w400)),
                            const SizedBox(height: Dimensions.marginSizeExtraSmall),

                            // (widget.products[index].variant != null && widget.products[index].variant!.isNotEmpty) ?
                            // Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                            //   child: Row(children: [
                            //     // Text('${getTranslated('variations', context)}: ',
                            //     //     style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                            //
                            //
                            //     // Flexible(child: Text(widget.orderDetailsModel.variant!,
                            //     //     style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            //     //       color: Theme.of(context).disabledColor,))),
                            //   ]),
                            // ) : const SizedBox(),
                            // const SizedBox(height: Dimensions.marginSizeExtraSmall),

                            ///Downloadable Product////////////

                            // Row(children: [
                            //   const Spacer(),
                            //   SizedBox(height: (widget.products[index] != null &&
                            //       widget.orderDetailsModel.productDetails?.productType =='digital' && widget.paymentStatus == 'paid')?
                            //   Dimensions.paddingSizeExtraLarge : 0),
                            //
                            // ]),


                            // const SizedBox(height: Dimensions.paddingSizeSmall),
                          ],
                          ),
                        ),
                      ],
                      ),

                      ///Review and Refund Request///////////////////
                      // Consumer<SyncOrderController>(
                      //     builder: (context, orderController, _) {
                      //       return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                      //           child: Row(children: [
                      //             const Spacer(),
                      //             orderController.orderTypeIndex == 1 && widget.orderType != "POS"?
                      //             InkWell(onTap: () {
                      //               if(orderController.orderTypeIndex == 1) {
                      //                 Provider.of<ReviewController>(context, listen: false).removeData();
                      //                 showDialog(context: context, builder: (context) => Dialog(
                      //                     insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent,
                      //                     child: ReviewDialog(productID: widget.orderDetailsModel.productDetails!.id.toString(),
                      //                         orderId: widget.orderId,
                      //                         callback: widget.callback,
                      //                         orderDetailsModel: widget.orderDetailsModel,
                      //                         orderType: widget.orderType)));
                      //               }
                      //             },
                      //                 child: Container(decoration: BoxDecoration(color:  Colors.deepOrangeAccent,
                      //                     borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                      //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                      //                     child: Row(children: [
                      //                       const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      //                       const Icon(Icons.star_outline_outlined, color: Colors.white, size: 20,),
                      //                       const SizedBox(width: Dimensions.paddingSizeSmall),
                      //
                      //                       Text(getTranslated(widget.orderDetailsModel.reviewModel == null ? 'review' : 'reviewed', context)!, style: textRegular.copyWith(
                      //                           fontSize: Dimensions.fontSizeDefault, color: ColorResources.white)),
                      //                       const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      //                     ]))) : const SizedBox.shrink(),
                      //
                      //             const SizedBox(width: Dimensions.paddingSizeSmall,),
                      //
                      //             Consumer<RefundController>(builder: (context,refund,_){
                      //               return (orderController.orderTypeIndex == 1 && widget.orderDetailsModel.refundReq == 0 &&
                      //                   widget.orderType != "POS")?
                      //               InkWell(onTap: () {
                      //                 Provider.of<ReviewController>(context, listen: false).removeData();
                      //                 refund.getRefundReqInfo(widget.orderDetailsModel.id).then((value) {
                      //                   if(value.response!.statusCode==200){
                      //                     Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      //                         RefundBottomSheet(product: widget.orderDetailsModel.productDetails,
                      //                           orderDetailsId: widget.orderDetailsModel.id!, orderId: widget.orderId,)));}
                      //                 });},
                      //
                      //                 child: refund.isRefund ?
                      //                 Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
                      //                 Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                      //                   padding: const EdgeInsets.symmetric(vertical: 8,
                      //                       horizontal: Dimensions.paddingSizeDefault),
                      //                   decoration: BoxDecoration(color: ColorResources.getPrimary(context),
                      //                     borderRadius: BorderRadius.circular(5),),
                      //
                      //                   child: Text(getTranslated('refund_request', context)!,
                      //                       style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      //                         color: Theme.of(context).highlightColor,)),),) :const SizedBox();
                      //             }),
                      //
                      //
                      //             Consumer<RefundController>(builder: (context,refundController,_){
                      //               return (orderController.orderTypeIndex == 1 && widget.orderDetailsModel.refundReq != 0 &&
                      //                   widget.orderType != "POS")?
                      //
                      //               InkWell(onTap: () {
                      //                 Provider.of<ReviewController>(context, listen: false).removeData();
                      //                 refundController.getRefundReqInfo(widget.orderDetailsModel.id).then((value) {
                      //                   if(value.response!.statusCode==200){
                      //                     Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      //                         RefundDetailsWidget(product: widget.orderDetailsModel.productDetails,
                      //                           orderDetailsId: widget.orderDetailsModel.id,
                      //                           orderDetailsModel:  widget.orderDetailsModel, createdAt: widget.orderDetailsModel.createdAt,)));
                      //                   }});},
                      //
                      //
                      //
                      //                   child: refundController.isLoading?
                      //                   Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
                      //                   Container(
                      //                     margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                      //                     padding: const EdgeInsets.symmetric(vertical: 8,
                      //                         horizontal: Dimensions.paddingSizeDefault),
                      //                     decoration: BoxDecoration(color: ColorResources.getPrimary(context),
                      //                       borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
                      //
                      //                     child: Text(getTranslated('refund_status_btn', context)??'',
                      //                         style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      //                           color: Theme.of(context).highlightColor,)),)) :const SizedBox();}),
                      //             const SizedBox(width: 10)]));}),

                      // widget.orderDetailsModel.deliveryStatus == 'delivered' && widget.orderType != "POS" ?
                      // ReviewReplyWidget(orderDetailsModel: widget.products[index], index: widget.index) : const SizedBox(),

                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      //widget.orderDetailsModel.refundReq == 0 && widget.orderType != "POS"?
                      //const SizedBox(height: Dimensions.paddingSizeLarge) : const SizedBox(),

                    ],
                    ),
                                  ),

                                  if(widget.products[index].discount! > 0) Positioned(
                    top: 5,
                    left:  5,
                    right:  5,
                    child: Container(
                      height: 20,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular( Dimensions.paddingSizeExtraSmall ),
                          left: Radius.circular( Dimensions.paddingSizeExtraSmall),
                        ),
                      ),
                      child: CustomDirectionalityWidget(
                        child: Text(
                          PriceConverter.percentageCalculation(
                            context,
                            (widget.products[index].unitPrice! * widget.products[index].currentStock!),
                            widget.products[index].discount,
                            getTranslated('amount', context),
                          ),
                          style: titilliumRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                    ),
                                  )

                                ],
                                ),
                  ),
                )
                : const SizedBox.shrink();
          }),
    );
  }
}
