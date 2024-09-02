
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../order/domain/models/order_model.dart';
import '../domain/models/order_details_model.dart';
import '../screens/Refund_request_screen.dart';

class ShowModalBottomSheetOrder extends StatefulWidget {
  const ShowModalBottomSheetOrder({super.key, this.orderModel, required this.orderDetailsModel,});
  final OrderModel? orderModel;
  final OrderDetailsModel orderDetailsModel;


  @override
  State<ShowModalBottomSheetOrder> createState() => _ShowModalBottomSheetOrderState();
}

class _ShowModalBottomSheetOrderState extends State<ShowModalBottomSheetOrder> {
  BuildContext diagloContext=Get.context!;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getTranslated('هل انت متاكد؟', Get.context!)!,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 30,
                  fontWeight: FontWeight.w700

              ),
            ),
            const SizedBox(height: 10,),
            Consumer<MyShopController>(
              builder:(context, myShopProvider, child) =>  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()async{
                        Navigator.pop(context);

                        Navigator.push(context, MaterialPageRoute(builder: (context) => RefundRequestScreen(orderModel: widget.orderModel!,orderDetailsModel: widget.orderDetailsModel,),));



                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(getTranslated('yes', context)!,
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 18,
                                  color: Colors.white,

                                  fontWeight: FontWeight.w500

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(getTranslated('no', context)!,
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],),
      )
    );
  }
  Future Dialog(String text){

    return showDialog(

      barrierDismissible: false  ,
      context: diagloContext,

      builder: (context) {
        return  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.0,vertical: MediaQuery.of(context).size.width/1.7),
          child: Container(
            height:300,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(getTranslated(text, context)!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.tajawal(
                        color: Theme.of(context).iconTheme.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 22

                    ),),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Future addPrice(MyShopController myShopController)async{
    for (int i=0;i<myShopController.pendingList.length;i++) {
      await myShopController. addProductPrice(myShopController.pendingList[i].id,myShopController.controller[i].text);

    }
  }
}
