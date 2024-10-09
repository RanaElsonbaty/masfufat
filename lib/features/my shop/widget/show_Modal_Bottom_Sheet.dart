
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../Store settings/controllers/store_setting_controller.dart';
import '../../Store settings/screen/store_setting_screen.dart';

class ShowModalBottomSheetShop extends StatefulWidget {
  const ShowModalBottomSheetShop({super.key, required this.delete});
  final bool delete;

  @override
  State<ShowModalBottomSheetShop> createState() => _ShowModalBottomSheetShopState();
}

class _ShowModalBottomSheetShopState extends State<ShowModalBottomSheetShop> {
  BuildContext diagloContext=Get.context!;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(

      height: 250,
      width: MediaQuery.of(context).size.width,
      child:widget.delete?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 5,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey
              ),
            ),
        const SizedBox(height: 15,),
        Text(getTranslated('Delete_product', Get.context!)!,
        style: GoogleFonts.titilliumWeb(
          fontSize: 20,
          fontWeight: FontWeight.w700

        ),
        ),
            const SizedBox(height: 5,),

            Text(getTranslated('Are_you_sure_you_want_to_delete_the_selected_products', Get.context!)!,
        textAlign: TextAlign.center,
         overflow: TextOverflow.visible,
        maxLines: 2,
        style: GoogleFonts.titilliumWeb(
          fontSize: 18,

          fontWeight: FontWeight.w400

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
                        // Navigator.pop(context);
                        Navigator.pop(diagloContext);

                        Dialog('Products_are_being_deleted');
                        if(myShopProvider.selectIds.isNotEmpty){
                          for (var element in myShopProvider.selectIds) {
                            if(myShopProvider.selectIndex==0){
                           await myShopProvider.deleteProduct(element);
                            }else{
                            await myShopProvider.deleteLinkedProduct(element);

                            }
                          }
                          await myShopProvider.getList();
                          myShopProvider. initController();
                          Navigator.pop(diagloContext);

                        }


                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red.shade600
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(getTranslated('confirm', context)!,
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20,
                                  color: Colors.white,

                                  fontWeight: FontWeight.w400

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
                        Navigator.pop(diagloContext);

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor.withOpacity(0.20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(getTranslated('cancellation', context)!,
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400

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
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<StoreSettingController>(
          builder:(context, storeSetting, child) =>  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            if (storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails!=null||storeSetting.linkedAccountsList.last.storeDetails!=null) Text(getTranslated('Do_you_want_to_sync_all', Get.context!)!,
                style: GoogleFonts.titilliumWeb(
                    fontSize: 30,
                    fontWeight: FontWeight.w700

                ),
              ) else Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    // Expanded(
                    //   child: Text(getTranslated('Unable_to_connect_to_your_marketplacePlease_click_the_following_link_to_authenticate', Get.context!)!,
                    //   style: GoogleFonts.titilliumWeb(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w700
                    //
                    //   ),
                    //
                    //               ),
                    //
                    //     // Click_here
                    // ),
                  //    Text(getTranslated('Click_here', Get.context!)!,
                    //     style: GoogleFonts.titilliumWeb(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w700
                    //
                    //     ),)
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const StoreSettingScreen()));
                        },
                        child: RichText(text: TextSpan(
                            text:getTranslated('Unable_to_connect_to_your_marketplacePlease_click_the_following_link_to_authenticate', Get.context!)!, style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w500,
                            fontSize: 25, color: const Color(0xFF202532)), children: [
                          // if (widget.isRequiredFill)
                          TextSpan(text: '  ',style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w500, fontSize: 25, color: Colors.red)),
                            TextSpan(text:getTranslated('Click_here', Get.context!)!, style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.w500, fontSize: 25, color: Colors.red))])),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10,),
    if (storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails!=null||storeSetting.linkedAccountsList.last.storeDetails!=null)

              Consumer<MyShopController>(
                builder:(context, myShopController, child) =>  Consumer<StoreSettingController>(
                  builder:(context, storeSetting, child) =>  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                      onTap: ()async{

                        // Navigator.pop(context);
                      if(storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails==null&&storeSetting.linkedAccountsList.last.storeDetails==null){
                        Navigator.pop(diagloContext);
                        showCustomSnackBar('${getTranslated('Products_sync_failed', Get.context!)}', Get.context!, isError: true);

                        return ;
                      }
                        Navigator.pop(diagloContext);

                        Dialog('Products_are_being_synced');

                     try{

                       await addPrice(myShopController).then((value) async{
                         if(value==true){
                           await myShopController.syncProduct().then((value)async {
                             if(value==true){
                               await myShopController.getList();
                               myShopController. initController();

                               Navigator.pop(diagloContext);

                             }else{
                               // Products_sync_failed
                               showCustomSnackBar('${getTranslated('Products_sync_failed', Get.context!)}', Get.context!, isError: true);
                               Navigator.pop(diagloContext);

                             }

                           });
                         }else{
                           showCustomSnackBar('${getTranslated('There_is_a_product_part_of_equal_to_zero_or_less', Get.context!)}', Get.context!, isError: true);
                           Navigator.pop(diagloContext);

                         }

                       });
                     }catch(e){
                       Navigator.pop(diagloContext);

                     }


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

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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

  double profit =0.00;
  double percentage =0.00;
  double getProfit(double val,MyShopController myShopController,int i) {
    //
    if(Provider.of<MyShopController>(context,listen: false).switch2){
      double tax =(double.parse(Provider.of<MyShopController>(context,listen: false).taxController.text)/100)*myShopController.pendingList[i].pricings.suggestedPrice;
      // getProfit(double.parse(widget.controller.text)+tax??0.00);
      val= val +tax;
    }else{
      // getProfit(double.parse(widget.controller.text)??0.00);

    }

    double value =0.0;
    value = myShopController.pendingList[i].pricings.value +
        (myShopController.pendingList[i].taxType == 'percent' || myShopController.pendingList[i].taxType != null
            ? ((myShopController.pendingList[i].tax / 100) * myShopController.pendingList[i].pricings.value)
            : myShopController.pendingList[i].tax);


    setState(() {
      profit = (val - value);
      percentage = (profit / value) * 100;
    });
    print('value: $value');

    print("Profit: $profit");
    print("Percentage: $percentage%");
    return percentage;
  }
  Future addPrice(MyShopController myShopController)async{
    double price=0.00;
    for (int i=0;i<myShopController.pendingList.length;i++) {
      try{
        price= getProfit(double.parse(myShopController.controller[i].text),myShopController ,i);
        if(myShopController.switch3&&price<0){
          return false;
        }
        await myShopController. addProductPrice(myShopController.pendingList[i].id,myShopController.controller[i].text);
        print(price);
        return true;

      }catch(e){
        print(e);
      }

    }
  }
}
