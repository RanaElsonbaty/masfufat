import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/basewidget/custom_image_widget.dart';
import '../../../helper/price_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../product/domain/models/product_model.dart';

class RefuntProductWidget extends StatefulWidget {
  const RefuntProductWidget({super.key, required this.product, required this.qty});
  final Product product;
  final int qty;

  @override
  State<RefuntProductWidget> createState() => _RefuntProductWidgetState();
}

class _RefuntProductWidgetState extends State<RefuntProductWidget> {

  @override
  Widget build(BuildContext context) {

    return  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Card(color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(width: Dimensions.marginSizeDefault),

              ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125))),
                      child: CustomImageWidget(image: '${widget.product.imagesFullUrl}', width: 80, height: 80))),
              const SizedBox(width: Dimensions.marginSizeDefault),

              Expanded(flex: 3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(widget.product.name??'',
                        style: GoogleFonts.tajawal(fontWeight: FontWeight.w500,fontSize: Dimensions.fontSizeDefault),
                        maxLines: 2, overflow: TextOverflow.ellipsis))]),
                  const SizedBox(height: Dimensions.marginSizeExtraSmall),


                  Row(children: [

                    Text("${getTranslated('price', context)}: ",
                      style: GoogleFonts.tajawal(fontWeight: FontWeight.w500,fontSize: 14),),
                    Text(PriceConverter.convertPrice(context, widget.product.unitPrice),
                      style: GoogleFonts.tajawal(fontWeight: FontWeight.w500,color: ColorResources.getPrimary(context), fontSize: 16),),

                    widget.product.taxModel!=null&&widget.product.taxModel == 'exclude'?
                    Text('(${getTranslated('tax', context)} ${PriceConverter.convertPrice(context, widget.product.tax)})',
                      style: GoogleFonts.tajawal(fontWeight: FontWeight.w500,color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault),):
                    Text('(${getTranslated('tax', context)} ${widget.product.taxModel})',
                        style: GoogleFonts.tajawal(fontWeight: FontWeight.w500,color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeDefault))]),
                  const SizedBox(height: Dimensions.marginSizeExtraSmall),


                  // const SizedBox(height: Dimensions.marginSizeExtraSmall),

                  const SizedBox(height: Dimensions.marginSizeExtraSmall),

                  ///Downloadable Product////////////

                  // Row(children: [
                  //   const Spacer(),
                  //   SizedBox(height: (widget.product != null &&
                  //       widget.product?.productType =='digital' && widget.paymentStatus == 'paid')?
                  //   Dimensions.paddingSizeExtraLarge : 0),
                  //
                  // ]),


                  const SizedBox(height: Dimensions.paddingSizeSmall),
                ],
                ),
              ),
            ],
            ),

            ///Review and Refund Request///////////////////
            // Consumer<OrderController>(
            //   builder: (context, orderController, _) {
            //     return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
            //         child: Row(children: [
            //           const Spacer(),
            //           orderController.orderTypeIndex == 1 && widget.orderType != "POS"?
            //           InkWell(onTap: () {
            //             if(orderController.orderTypeIndex == 1) {
            //               Provider.of<ReviewController>(context, listen: false).removeData();
            //               showDialog(context: context, builder: (context) => Dialog(
            //                   insetPadding: EdgeInsets.zero, backgroundColor: Colors.transparent,
            //                   child: ReviewDialog(productID: widget.orderDetailsModel.productDetails!.id.toString(),
            //                       orderId: widget.orderId,
            //                       callback: widget.callback,
            //                       orderDetailsModel: widget.orderDetailsModel,
            //                       orderType: widget.orderType)));
            //             }
            //           },
            //           child: Container(decoration: BoxDecoration(color:  Colors.deepOrangeAccent,
            //             borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
            //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            //             child: Row(children: [
            //               const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //               const Icon(Icons.star_outline_outlined, color: Colors.white, size: 20,),
            //               const SizedBox(width: Dimensions.paddingSizeSmall),
            //
            //               Text(getTranslated(widget.orderDetailsModel.reviewModel == null ? 'review' : 'reviewed', context)!, style: textRegular.copyWith(
            //                   fontSize: Dimensions.fontSizeDefault, color: ColorResources.white)),
            //               const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //             ]))) : const SizedBox.shrink(),
            //
            //           const SizedBox(width: Dimensions.paddingSizeSmall,),
            //
            //           Consumer<RefundController>(builder: (context,refund,_){
            //             return (orderController.orderTypeIndex == 1 && widget.orderDetailsModel.refundReq == 0 &&
            //                 widget.orderType != "POS")?
            //             InkWell(onTap: () {
            //               Provider.of<ReviewController>(context, listen: false).removeData();
            //               refund.getRefundReqInfo(widget.orderDetailsModel.id).then((value) {
            //                 if(value.response!.statusCode==200){
            //                   Navigator.push(context, MaterialPageRoute(builder: (_) =>
            //                       RefundBottomSheet(product: widget.orderDetailsModel.productDetails,
            //                         orderDetailsId: widget.orderDetailsModel.id!, orderId: widget.orderId,)));}
            //               });},
            //
            //               child: refund.isRefund ?
            //               Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
            //               Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
            //                 padding: const EdgeInsets.symmetric(vertical: 8,
            //                     horizontal: Dimensions.paddingSizeDefault),
            //                 decoration: BoxDecoration(color: ColorResources.getPrimary(context),
            //                   borderRadius: BorderRadius.circular(5),),
            //
            //                 child: Text(getTranslated('refund_request', context)!,
            //                     style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
            //                       color: Theme.of(context).highlightColor,)),),) :const SizedBox();
            //           }),
            //
            //
            //           Consumer<RefundController>(builder: (context,refundController,_){
            //             return (orderController.orderTypeIndex == 1 && widget.orderDetailsModel.refundReq != 0 &&
            //                 widget.orderType != "POS")?
            //
            //             InkWell(onTap: () {
            //               Provider.of<ReviewController>(context, listen: false).removeData();
            //               refundController.getRefundReqInfo(widget.orderDetailsModel.id).then((value) {
            //                 if(value.response!.statusCode==200){
            //                   Navigator.push(context, MaterialPageRoute(builder: (_) =>
            //                       RefundDetailsWidget(product: widget.orderDetailsModel.productDetails,
            //                         orderDetailsId: widget.orderDetailsModel.id,
            //                         orderDetailsModel:  widget.orderDetailsModel, createdAt: widget.orderDetailsModel.createdAt,)));
            //                 }});},
            //
            //
            //
            //                 child: refundController.isLoading?
            //                 Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
            //                 Container(
            //                   margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
            //                   padding: const EdgeInsets.symmetric(vertical: 8,
            //                       horizontal: Dimensions.paddingSizeDefault),
            //                   decoration: BoxDecoration(color: ColorResources.getPrimary(context),
            //                     borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),),
            //
            //                   child: Text(getTranslated('refund_status_btn', context)??'',
            //                       style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
            //                         color: Theme.of(context).highlightColor,)),)) :const SizedBox();}),
            //           const SizedBox(width: 10)]));}),

            // widget.orderDetailsModel.deliveryStatus == 'delivered' && widget.orderType != "POS" ?
            // // ReviewReplyWidget(orderDetailsModel: widget.orderDetailsModel, index: widget.index) : const SizedBox(),
            //
            // const SizedBox(height: Dimensions.paddingSizeSmall),

            //widget.orderDetailsModel.refundReq == 0 && widget.orderType != "POS"?
            //const SizedBox(height: Dimensions.paddingSizeLarge) : const SizedBox(),

          ],
          ),
        ),
      ),
    );
  }
}
