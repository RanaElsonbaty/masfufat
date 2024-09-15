
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //   Do_you_want_to_sync_all
            Text(getTranslated('Do_you_want_to_sync_all', Get.context!)!,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 30,
                  fontWeight: FontWeight.w700

              ),
            ),
            const SizedBox(height: 10,),
            Consumer<MyShopController>(
              builder:(context, myShopController, child) =>  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                  onTap: ()async{
                    // Navigator.pop(context);
                    Navigator.pop(diagloContext);

                    Dialog('Products_are_being_synced');

                   await addPrice(myShopController).then((value) async{
                    await myShopController.syncProduct().then((value)async {
                      if(value==true){
                        await myShopController.getList();
                        myShopController. initController();
                      }else{
                      // Products_sync_failed
                        showCustomSnackBar('${getTranslated('Products_sync_failed', Get.context!)}', Get.context!, isError: true);

                      }

                    });
                   });


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
            )
          ],
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
  Future addPrice(MyShopController myShopController)async{
    for (int i=0;i<myShopController.pendingList.length;i++) {
     await myShopController. addProductPrice(myShopController.pendingList[i].id,myShopController.controller[i].text);

    }
  }
}
