import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../helper/price_converter.dart';
import '../../../main.dart';
import '../../order/domain/models/order_model.dart';
import '../domain/models/order_details_model.dart';
import '../widgets/refunt_product_widget.dart';

class RefundRequestScreen extends StatefulWidget {
  const RefundRequestScreen({super.key, this.orderModel, required this.orderDetailsModel});
  final OrderModel? orderModel;
  final OrderDetailsModel orderDetailsModel;

  @override
  State<RefundRequestScreen> createState() => _RefundRequestScreenState();
}

class _RefundRequestScreenState extends State<RefundRequestScreen> {
  TextEditingController noteController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: getTranslated('Refund_request', context)),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10,),
          widget.orderDetailsModel.productDetails!=null?   RefuntProductWidget(product: widget.orderDetailsModel.productDetails!,qty: widget.orderDetailsModel.qty!,):const SizedBox(),

          const SizedBox(height: 10,),
        

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Text('${getTranslated('Reason_for_product_return', context)}',style: GoogleFonts.tajawal(),)
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFieldWidget(
            maxLines: 5,
              controller: noteController,
        
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Text(getTranslated('Attachments', context)!,style: GoogleFonts.tajawal(),),
              ],
            ),
          ),
          Consumer<OrderDetailsController>(
            builder:(context, provider, child) =>  SizedBox(
              height: 150,
        
              // color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: ListView.builder(
        
                    itemCount: provider.pikeImage.length+1,
        
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
        
        
                      itemBuilder: (context, index) {
                      if(index==0){
                        // dotted_border
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
                          child: InkWell(
                            onTap: (){
                              provider.pikeMultiImage();
                            },
                            child: DottedBorder(
                               radius: const Radius.circular(12),
                              strokeWidth: 1,
                              color: Theme.of(context).iconTheme.color!,
                              borderType: BorderType.RRect,
                              child: Container(
                                height: 50,
                                // width: 14>0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child:  Center(child: Text(getTranslated('Download_attachments', context)!,style: GoogleFonts.tajawal(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,color: Theme.of(context).primaryColor
                                ),)),
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
                          child:Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                // width: 140,
                                child: Image.file(File(provider.pikeImage[index-1].path,),fit: BoxFit.fill,),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: (){
                                provider.removerImage((index-1));
                                },
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).cardColor
                                    ),
                                    child: const Icon(Icons.remove,color: Colors.red,size: 15,)),
                              ),
                            )
                          ],)
                        );}
                      },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          const SizedBox(height: 10,),

          Consumer<OrderDetailsController>(
            builder:(context, provider, child) =>  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getTranslated('bill', context)!,style: GoogleFonts
                      .tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' ${getTranslated('Subtotal', context)}',style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w400,fontSize: 14
                      ),overflow: TextOverflow.visible,textAlign: TextAlign.center),
                      // const SizedBox(height: 5,),

                      Text(PriceConverter.convertPrice(context,provider.orderRefuntModel!=null?provider.orderRefuntModel!.subtotal:0.00)),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Divider(color: Colors.grey.shade300,height: 5,),
                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('${getTranslated('Discount_coupon', context)}',style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w400,fontSize: 14

                      ),overflow: TextOverflow.visible,textAlign: TextAlign.center),
                      // const SizedBox(height: 5,),

                      Text(PriceConverter.convertPrice(context,provider.orderRefuntModel!.couponDiscount),style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w400,fontSize: 14

                      ),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Divider(color: Colors.grey.shade300,height: 5,),
                  const SizedBox(height: 5,),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text('${getTranslated('Total_refund_amount', context)}',style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w400,fontSize: 14

                          ),overflow: TextOverflow.visible,textAlign: TextAlign.center,),
                          // const SizedBox(height: 5,),

                          Text(PriceConverter.convertPrice(context,provider.orderRefuntModel!.refundAmount),style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w400,fontSize: 14

                          ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Consumer<OrderDetailsController>(
            builder:(context, provider, child) =>  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomButton(
                isLoading:  provider.isRefuntLoading,
                buttonText: getTranslated('addition', context),onTap:(){
                if(noteController.text.isNotEmpty){
          provider.addOrderRefund(widget.orderDetailsModel.id.toString(), noteController.text, provider.pikeImage).then((value)async {
          await Provider.of<OrderDetailsController>(Get.context!, listen: false).getOrderDetails(widget.orderDetailsModel.orderId.toString());
          Navigator.pop(Get.context!);

          });
                }
              },),
            ),
          )
        ],),
      ),
    );
  }
}
