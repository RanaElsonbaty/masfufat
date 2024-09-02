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
      appBar: const CustomAppBar(title: 'طلب استرجاع'),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10,),
          // OrderProductListWidget(orderType: widget.orderModel!.orderType,
          //
          //       fromRefunt: true,
          //     fromTrack: false,isGuest:0,orderId: widget.orderModel!.id.toString(), orderModel: widget.orderModel!,),
          RefuntProductWidget(product: widget.orderDetailsModel.productDetails!,qty: widget.orderDetailsModel.qty!,),

          const SizedBox(height: 10,),
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                       Text(getTranslated('Subtotal', context)!,style: GoogleFonts.tajawal(),overflow: TextOverflow.visible,textAlign: TextAlign.center),
                      const SizedBox(height: 5,),

                      Text('${widget.orderModel!.orderAmount}'),
                    ],
                  ),
                ),
                const SizedBox(width: 5,),

                Expanded(
                  child: Column(
                    children: [
                       Text(' تخفيض (كوبون)',style: GoogleFonts.tajawal(),overflow: TextOverflow.visible,textAlign: TextAlign.center),
                      const SizedBox(height: 5,),

                      Text('${widget.orderModel!.discountAmount}'),
                    ],
                  ),
                ),
                const SizedBox(width: 5,),

                Expanded(
                  child: Column(
                    children: [
                       Text('إجمالي المبلغ المسترد',style: GoogleFonts.tajawal(),overflow: TextOverflow.visible,textAlign: TextAlign.center,),
                      const SizedBox(height: 5,),

                      Text('${widget.orderModel!.orderAmount}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Text('سبب استرجاع المنتج',style: GoogleFonts.tajawal(),)
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
                Text('المرفقات',style: GoogleFonts.tajawal(),),
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
        
                    physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
        
        
                      itemBuilder: (context, index) {
                      if(index==0){
                        // dotted_border
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: const Center(child: Icon(Icons.add,size: 50,)),
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child:Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                height: 140,
                                width: 140,
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
        
          Consumer<OrderDetailsController>(
            builder:(context, provider, child) =>  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomButton(
                isLoading:  provider.isRefuntLoading,
                buttonText: 'اضافه',onTap:(){
                if(noteController.text.isNotEmpty){
          provider.addOrderRefund(widget.orderDetailsModel.id.toString(), noteController.text, provider.pikeImage).then((value)async {
          await Provider.of<OrderDetailsController>(Get.context!, listen: false).getOrderDetails(widget.orderDetailsModel.orderId.toString());
          Navigator.pop(context);

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
