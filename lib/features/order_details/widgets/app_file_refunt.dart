import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../domain/models/order_details_model.dart';


class AddFileRefunt extends StatefulWidget {
  const AddFileRefunt({super.key, required this.orderDetailsModel});
  final OrderDetailsModel orderDetailsModel;

  @override
  State<AddFileRefunt> createState() => _AddFileRefuntState();
}

class _AddFileRefuntState extends State<AddFileRefunt> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<OrderDetailsController>(
            builder:(context, provider, child) =>  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          provider.refuntPikeMultiImage(1).then((value) async{
                            Navigator.pop(context);

                            await   provider.refundUploadAttachment(widget.orderDetailsModel.id.toString(), provider.refuntPikeImage);
                            await  provider.getOrderRefund(widget.orderDetailsModel.id.toString());
                          //
                          });
                        },
                        child: Container(
                            // height: 25,
                            // width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xFFEFECF5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  const Icon(Icons.file_present_outlined),
                                  const SizedBox(width: 5,),

                                  Text('file',style: GoogleFonts.cairo(fontSize: 16,fontWeight: FontWeight.w500),)
                                ],
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(width: 10,),

                    Expanded(
                      child: InkWell(
                        onTap: (){
                          provider.refuntPikeMultiImage(2).then((value) async{
                            Navigator.pop(context);

                            await   provider.refundUploadAttachment(widget.orderDetailsModel.id.toString(), provider.refuntPikeImage);
                            await  provider.getOrderRefund(widget.orderDetailsModel.id.toString());
                            //
                          });
                        },
                        child: Container(
                            // height: 25,
                            // width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xFFEFECF5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [

                                  const Icon(Icons.image_outlined),
                                  const SizedBox(width: 5,),

                                  Text('video ',style: GoogleFonts.cairo(fontSize: 16,fontWeight: FontWeight.w500),)
                                ],
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          provider.refuntPikeMultiImage(3).then((value) async{
                            Navigator.pop(context);
                            await   provider.refundUploadAttachment(widget.orderDetailsModel.id.toString(), provider.refuntPikeImage);
                            await  provider.getOrderRefund(widget.orderDetailsModel.id.toString());
                            //
                          });
                        },
                        child: Container(
                            // height: 25,
                            // width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xFFEFECF5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [

                                  const Icon(Icons.video_collection_outlined),
                                  const SizedBox(width: 5,),

                                  Text('photo',style: GoogleFonts.cairo(fontSize: 16,fontWeight: FontWeight.w500),)
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
              ],),
          ),
        )
    );
  }
}

