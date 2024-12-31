
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../Store settings/controllers/store_setting_controller.dart';
import '../../Store settings/screen/store_setting_screen.dart';

class ShowModalBottomSheetShop extends StatefulWidget {
  const ShowModalBottomSheetShop({super.key, required this.delete, this.index=0});
  final bool delete;
  final int? index;

  @override
  State<ShowModalBottomSheetShop> createState() => _ShowModalBottomSheetShopState();
}

class _ShowModalBottomSheetShopState extends State<ShowModalBottomSheetShop> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Provider.of<StoreSettingController>(context,listen: false).linkedAccountsList.isEmpty){
      Provider.of<StoreSettingController>(context,listen: false).getLinkedProduct();
    }

  }
  BuildContext diagloContext=Get.context!;
  @override
  Widget build(BuildContext context) {
    return  Container(

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

                        dialog('Products_are_being_deleted');
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 120,height: 4,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade400,
              ),),
            const SizedBox(height: 40,),

            // if (storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails!=null||storeSetting.linkedAccountsList.last.storeDetails!=null)
              Text(getTranslated('Save_and_sync_now', Get.context!)!,
                style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w700,
                    fontSize: 20)
              ),
              const SizedBox(height: 15,),
              Text(getTranslated('Are_you_sure_to_save_and_sync_products', Get.context!)!,
                style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                )
              ),

              const SizedBox(height: 20,),
    // Spacer(),
    // if (storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails!=null||storeSetting.linkedAccountsList.last.storeDetails!=null)

              Consumer<MyShopController>(
                builder:(context, myShopController, child) =>  Consumer<StoreSettingController>(
                  builder:(context, storeSetting, child) =>  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                      onTap: ()async{
                        Navigator.pop(context);





                      },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor.withOpacity(.3)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(getTranslated('cancel', context)!,
                                  style: GoogleFonts.titilliumWeb(
                                      fontSize: 18,
                                      color: Colors.black,

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
                          onTap: ()async{
                            // dialog('Products_are_being_synced');

                            if(storeSetting.linkedAccountsList.isNotEmpty&&storeSetting.linkedAccountsList.first.storeDetails==null&&storeSetting.linkedAccountsList.last.storeDetails==null){
                              Navigator.pop(diagloContext);
                              showCustomSnackBar('${getTranslated('Unable_to_connect_to_your_marketplace', Get.context!)}', Get.context!, isError: true);

                              return ;
                            }

                            dialog('Products_are_being_synced');
try{
  if(myShopController.selectIds.isEmpty||myShopController.selectAll==true){
  await  syncAllProductOneTime(myShopController).then((value) async{
    if(value==true){
    await myShopController.getList();
            myShopController. initController();
    }
  });
    myShopController.clearSelect();

            Navigator.pop(diagloContext);
    Navigator.pop(Get.context!);


  }else{
  await  syncOneProductOneTime(myShopController).then((value) async{
    await myShopController.getList();
    myShopController. initController();
  });
  myShopController.clearSelect();
            Navigator.pop(diagloContext);
Navigator.pop(Get.context!);

  }
  // Navigator.pop(diagloContext);
}catch(e){
  showCustomSnackBar(e.toString(), Get.context!);
}

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(getTranslated('confirm', context)!,
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
                ),
              ),
              // const SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }


  Future dialog(String text)  {
    // final ui.Image image =await getSvg();

    return showDialog(

      barrierDismissible: false  ,
      context: diagloContext,

      builder: (context) {
        return  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.0,vertical: MediaQuery.of(context).size.width/2),
          child: Container(
            // height:300,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor,

          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Image.asset(Images.logoGif,width: 100,height: 100,),

                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                  child: Text(getTranslated('Please_wait', context)!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.tajawal(
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 20

                  ),),
                ),
                const SizedBox(height: 5,),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(getTranslated('Products_are_being_synced_this_will_take_some_time_please_do_not_close_the_app', context)!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,

                    style: GoogleFonts.tajawal(
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.w500,
                    fontSize: 18

                  ),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // double profit =0.00;
  // double percentage =0.00;
  // double getProfit(double val,MyShopController myShopController,int i) {
  //   //
  //   if(Provider.of<MyShopController>(context,listen: false).switch2){
  //     double tax =(double.parse(Provider.of<MyShopController>(context,listen: false).taxController.text)/100)*myShopController.pendingList[i].pricings.suggestedPrice;
  //     // getProfit(double.parse(widget.controller.text)+tax??0.00);
  //     val= val +tax;
  //   }else{
  //     // getProfit(double.parse(widget.controller.text)??0.00);
  //
  //   }
  //
  //   double value =0.0;
  //   value = myShopController.pendingList[i].pricings.value +
  //       (myShopController.pendingList[i].taxType == 'percent' || myShopController.pendingList[i].taxType != null
  //           ? ((myShopController.pendingList[i].tax / 100) * myShopController.pendingList[i].pricings.value)
  //           : myShopController.pendingList[i].tax);
  //
  //
  //   setState(() {
  //     profit = (val - value);
  //     percentage = (profit / value) * 100;
  //   });
  //   print('value: $value');
  //
  //   print("Profit: $profit");
  //   print("Percentage: $percentage%");
  //   return percentage;
  // }
  // Future addPrice(MyShopController myShopController)async{
  //   double price=0.00;
  //   for (int i=0;i<myShopController.selectIds.length;i++) {
  //     try{
  //       price= getProfit(double.parse(myShopController.controller[i].text),myShopController ,i);
  //
  //       await myShopController. addProductPrice(myShopController.selectIds[i],myShopController.controller[i].text).then((value)async {
  //       if(value==true){
  //           await myShopController.syncProduct(false,).then((value)async {
  //             if(value==true){
  //               Navigator.pop(diagloContext);
  //             }else{
  //               Navigator.pop(diagloContext);
  //             }
  //
  //           });
  //         }else{
  //           Navigator.pop(diagloContext);
  //           showCustomSnackBar('${getTranslated('Product_sync_failed', Get.context!)} sku : ${myShopController.pendingList[i].code}', Get.context!, isError: true);
  //           return false;
  //
  //       }
  //       });
  //       print(price);
  //       return true;
  //
  //     }catch(e){
  //       print(e);
  //     }
  //
  //   }
  // }
Future syncAllProductOneTime(MyShopController myShopController)async{

  for (int i =0;i<myShopController.pendingList.length;i++) {
    double tax=0.00;

    if(myShopController.switch2){
      tax= (((double.parse(myShopController.controller[i].text)+(((double.parse(myShopController.taxController.text)/100)*double.parse(myShopController.controller[i].text))))));

    }
          await myShopController. addProductPrice(myShopController.pendingList[i].id,(double.parse(myShopController.controller[i].text)+tax).toString()).then((value)async {
if(value==true){
        await myShopController. syncProduct(widget.index==0?false:true,false).then((value)async {
          if(value==true){
                          // Navigator.pop(diagloContext);
                        }else{
                      showCustomSnackBar('${getTranslated('Product_sync_failed', Get.context!)} sku : ${myShopController.pendingList[i].code}', Get.context!, isError: true);
                          // Navigator.pop(diagloContext);
                        }
        });

}else{
  // Navigator.pop(diagloContext);
            showCustomSnackBar('${getTranslated('Product_sync_failed', Get.context!)} sku : ${myShopController.pendingList[i].code}', Get.context!, isError: true);
            return false;
}
  });
  }
}
Future syncOneProductOneTime(MyShopController myShopController)async{

  for (int i =0;i<myShopController.selectIds.length;i++) {
    double tax=0.00;

    if(myShopController.switch2){
      tax= (((double.parse(myShopController.controller[i].text)+(((double.parse(myShopController.taxController.text)/100)*double.parse(myShopController.controller[i].text))))));

    }
    await myShopController. addProductPrice(myShopController.selectIds[i],(double.parse(myShopController.controller[i].text)+tax).toString()).then((value)async {
      if(value==true){
        await myShopController. syncOneProduct(widget.index==0?false:true,myShopController.selectIds[i],false).then((value)async {
          if(value==true){
            // Navigator.pop(diagloContext);
          }else{
            showCustomSnackBar('${getTranslated('Product_sync_failed', Get.context!)} id : ${myShopController.selectIds[i]}', Get.context!, isError: true);
            // Navigator.pop(diagloContext);
          }
        });

      }else{
        // Navigator.pop(diagloContext);
        showCustomSnackBar('${getTranslated('Product_sync_failed', Get.context!)} id : ${myShopController.selectIds[i]}', Get.context!, isError: true);
        return false;
      }
    });
  }
}
}
