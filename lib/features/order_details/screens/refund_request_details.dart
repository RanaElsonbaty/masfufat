import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../common/basewidget/custom_button_widget.dart';
import '../../../common/basewidget/custom_textfield_widget.dart';
import '../../order/domain/models/order_model.dart';
import '../controllers/order_details_controller.dart';
import '../domain/models/order_details_model.dart';
import '../widgets/app_file_refunt.dart';
import '../widgets/refunt_product_widget.dart';

class RefundRequestDetails extends StatefulWidget {
  const RefundRequestDetails({super.key, this.orderModel, required this.orderDetailsModel});
  final OrderModel? orderModel;
  final OrderDetailsModel orderDetailsModel;
  @override
  State<RefundRequestDetails> createState() => _RefundRequestDetailsState();
}

class _RefundRequestDetailsState extends State<RefundRequestDetails> {
  TextEditingController noteController=TextEditingController();
@override
  void initState() {
  initData();
    super.initState();
  }
  void initData()async{
    OrderDetailsController  provider= Provider.of<OrderDetailsController>(context,listen: false) ;

  await  provider.getOrderRefund(widget.orderDetailsModel.id.toString());
 try{
   noteController.text=  provider.orderRefuntModel!.refundRequest.first.refundReason;
   provider.getRefuntDetailsImage(  provider.orderRefuntModel!.refundRequest.first.images);
 }catch(e){}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: getTranslated('Refund_Request_Details', context)),
      body: SingleChildScrollView(
        child: Consumer<OrderDetailsController>(
          builder:(context, provider, child) {

            return provider.isRefuntLoading==false&&provider.orderRefuntModel!=null?  Column(children: [

            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text('${getTranslated('Return_Request_Number', context)} ',style: GoogleFonts.tajawal(

                    fontSize: 16,fontWeight: FontWeight.w500
                  ),overflow: TextOverflow.visible,),
                  Text('${provider.orderRefuntModel!=null?provider.orderRefuntModel!.refundRequest.first.id:''}',style: GoogleFonts.tajawal(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),overflow: TextOverflow.visible,),
                ],
              ),
            ),Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text('${getTranslated('Order_return_status', context)} '
                    ,style: GoogleFonts.tajawal(

                        fontSize: 16,fontWeight: FontWeight.w500
                    ),overflow: TextOverflow.visible,),   Text(' ${provider.orderRefuntModel!=null?getTranslated(provider.orderRefuntModel!.refundRequest.first.status, context):''}'
                    ,style: GoogleFonts.tajawal(
                        color: Theme.of(context).primaryColor,

                        fontSize: 16,fontWeight: FontWeight.w500
                    ),overflow: TextOverflow.visible,),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                Text(getTranslated('Return_Request_Information', context)!,style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),)
                ],
              ),
            ),
            widget.orderDetailsModel.productDetails!=null? RefuntProductWidget(product: widget.orderDetailsModel.productDetails!,qty: widget.orderDetailsModel.qty!,):const SizedBox.shrink(),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text('${getTranslated('Reason_for_product_return', context)}',style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w500,
            fontSize: 16
            ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
              child: CustomTextFieldWidget(
                maxLines: 5,
                controller: noteController,
                readOnly:  provider.orderRefuntModel!.refundRequest.first.status!='pending',

              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text('${getTranslated('Attachments', context)}',style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500

                  ),),
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

                      itemCount: provider.orderRefuntModel!.refundRequest.first.status=='pending'?(provider.refuntDetailsImage.length+1):provider.refuntDetailsImage.length,

                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,


                      itemBuilder: (context, index) {
                        if(index==0&&provider.orderRefuntModel!.refundRequest.first.status=='pending'){
                          // dotted_border
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
                            child: InkWell(
                              onTap: ()async{
                                showModalBottomSheet(context: context,
                                    builder: (BuildContext context) =>
                                     AddFileRefunt(orderDetailsModel: widget.orderDetailsModel,));

                              },
                              child: DottedBorder(
                                radius: const Radius.circular(12),
                                strokeWidth: 1,
                                color: Theme.of(context).iconTheme.color!,
                                borderType: BorderType.RRect,
                                child: Container(
                                  height: 50,
                                  // width: 140,
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
                              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
                              child:Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    height: 140,
                                    width: MediaQuery.of(context).size.width,
                                    child:provider.refuntDetailsImage.isNotEmpty&&provider.refuntDetailsImage[provider.orderRefuntModel!.refundRequest.first.status!='pending'?index:index-1].startsWith('/')?Image.file(File(provider.refuntDetailsImage[provider.orderRefuntModel!.refundRequest.first.status!='pending'?index:index-1])): CustomImageWidget(image: "https://platform.masfufat.com/storage/app/public/refund/${provider.refuntDetailsImage[provider.orderRefuntModel!.refundRequest.first.status!='pending'?index:index-1]}",fit: BoxFit.fill,),
                                  ),
                                ),
                        provider.orderRefuntModel!.refundRequest.first.status=='pending'?  Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          showModalBottomSheet(
                                            context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                            builder: (c) =>   bottomSheet('حذف الصوره',(){
                                              provider.removeRefuntImage(index);
                                              provider.refundDeleteAttachment(widget.orderDetailsModel.id.toString(), (provider.orderRefuntModel!.refundRequest.first.status!='pending'?index:index-1).toString());
                                              Navigator.pop(context);
                                            }),
                                          );
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
                                      const SizedBox(width: 5,),
                                      InkWell(
                                        onTap: (){
                                          showModalBottomSheet(
                                            context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                            builder: (c) =>   bottomSheet('تبديل الصوره',()async{

                                           await   provider.pikeRefuntMultiImage().then((value)async {
                                           await  provider.refundReplaceAttachment(widget.orderDetailsModel.id!.toString(),(provider.orderRefuntModel!.refundRequest.first.status!='pending'?index:index-1).toString(),value!);
                                           await  provider.getOrderRefund(widget.orderDetailsModel.id.toString());

                                             Navigator.pop(Get.context!);

                                           });

                                            }),
                                          );
                                        },
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context).cardColor
                                            ),
                                            child: const Icon(Icons.replay,color: Colors.red,size: 15,)),
                                      ),
                                    ],
                                  ),
                                ):const SizedBox.shrink()
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

              Padding(
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
              const SizedBox(height: 10,),

              provider.orderRefuntModel!.refundRequest.first.status=='pending'? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomButton(buttonText: getTranslated('okay', context),onTap: (){
                provider.refundUpdateReason(widget.orderDetailsModel.id.toString(), noteController.text);
              },),
            ):const SizedBox.shrink()
          ],):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/3,),
              Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),
            ],
          );
          },
        ),
      ),
    );
  }
}
Widget bottomSheet(String text,Function onTap){
  return Container(
    width: MediaQuery.of(Get.context!).size.width,
    height: 300,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: InkWell(
                onTap: () {
                  onTap();
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Theme.of(Get.context!).primaryColor,),child:
                 Center(child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 18),)),),
              )),
             const SizedBox(width: 10,),
              Expanded(

                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Theme.of(Get.context!).primaryColor,),
                    child: const Center(child: Text('الغاء',style: TextStyle(color: Colors.white,fontSize: 18))),)),
            ],
          ),
        )
    ],),
  );
}
