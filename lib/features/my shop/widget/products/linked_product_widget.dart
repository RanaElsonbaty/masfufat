import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/model/model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/basewidget/custom_image_widget.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/images.dart';
import '../../controllers/my_shop_controller.dart';
import '../show_Modal_Bottom_Sheet.dart';

class LinkedProductWidget extends StatefulWidget {
  const LinkedProductWidget({super.key, required this.linked, this.unSync=false});
final Linked linked;
final bool ?unSync;
  @override
  State<LinkedProductWidget> createState() => _LinkedProductWidgetState();
}

class _LinkedProductWidgetState extends State<LinkedProductWidget> {
  TextEditingController price =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.unSync==false){
    // }
    getPrice();
  }
  void getPrice()async{
    price.text='';
// await Future.delayed(const Duration(seconds: 1));
  price.text=widget.linked.linkedProduct.price.toStringAsFixed(2);
  }
  @override
  Widget build(BuildContext context) {
    getPrice();
    print('widget.linked.linkedProduct.price ${widget.linked.linkedProduct.price}');
    print('price.text ${price.text}');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8)
        ),

        child:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<MyShopController>(
                  builder:(context, myShopProvider, child) {
                    return Checkbox(value: myShopProvider.selectIds.contains(widget.linked.id), onChanged: (val){
                      myShopProvider.selectOneProduct(widget.linked.id,val!);
                    },
                      checkColor: Colors.white,
                      fillColor: myShopProvider.selectIds.contains(widget.linked.id)? null:MaterialStateProperty.all(Colors.white),
                      side: BorderSide.none,
                      activeColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    );
                  },
                ),


                Consumer<MyShopController>(
                  builder:(context, myShopProvider, child) =>  InkWell(
                    onTap: ()async{
                      myShopProvider.selectOneProduct(widget.linked.id, true);
                      showModalBottomSheet(context: context,
                          // backgroundColor: Colors.white,
                          builder: (BuildContext context)=> const ShowModalBottomSheetShop( delete: true,));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).cardColor
                      ),
                      child: Center(child:Image.asset(Images.delete,width: 20,),),
                    ),
                  ),
                )
              ],
            ),
            Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:  CustomImageWidget(image: widget.linked.imageUrl,height: 82,width: 84,)),
              const SizedBox(width: 10,),
              Expanded(
                flex: 11,
                child: Text(widget.linked.name,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],),
            const SizedBox(height: 5,),
            Container(
              decoration:  const BoxDecoration(
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                child: Column(children: [
                  InkWell(
                    onTap: (){
                      Clipboard.setData(
                          ClipboardData(text: widget.linked.itemNumber));
                      showCustomSnackBar(
                        getTranslated('The_text_has_been_copied', context),
                        context,
                        isError: false,
                      );
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${getTranslated('Product_number', context)!} : ',style: GoogleFonts.tajawal(
                            fontSize: 16,fontWeight: FontWeight.w400,
                        ),),

                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),

                          child: Text(widget.linked.itemNumber.toString(),style: GoogleFonts.tajawal(
                              fontSize: 16,fontWeight: FontWeight.w400,
                            // height: 0.9

                          ),),
                        ),
                        const Spacer(),
                        Image.asset(Images.copyIcon,width: 15,)
                        // Icon(Ico)

                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),

                  InkWell(
                    onTap: (){
                      Clipboard.setData(
                          ClipboardData(text: widget.linked.code));
                      showCustomSnackBar(
                        getTranslated('The_text_has_been_copied', context),
                        context,
                        isError: false,
                      );
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${getTranslated('Product_barcode_sku', context)!} : ',style: GoogleFonts.tajawal(
                            fontSize: 16,fontWeight: FontWeight.w400
                        ),),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),

                          child: Text(widget.linked.code,style: GoogleFonts.tajawal(
                              fontSize: 16,fontWeight: FontWeight.w400
                          ),),
                        ),
                        const Spacer(),
                        Image.asset(Images.copyIcon,width: 15,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${getTranslated('cost', context)!} :',style: GoogleFonts.tajawal(
                          fontSize: 16,fontWeight: FontWeight.w400
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),

                        child: Text(PriceConverter.convertPrice(context,widget.linked.pricings.value),style: GoogleFonts.tajawal(
                            fontSize: 16,fontWeight: FontWeight.w400
                        ),),
                      ),
                      // const Spacer(),
                      // Image.asset(Images.copyIcon,width: 15,)
                    ],
                  ),
                  const SizedBox(height: 5,),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${getTranslated('Suggested_selling_price', context)! } :',

                        style: GoogleFonts.tajawal(
                          fontSize: 16,fontWeight: FontWeight.w400,

                      ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(PriceConverter.convertPrice(context, widget.linked.pricings.suggestedPrice),style: GoogleFonts.tajawal(
                            fontSize: 16,fontWeight: FontWeight.w400
                        ),),
                      ),

                    ],
                  ),
                  const SizedBox(height: 5,),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${getTranslated('Selling_price_in_my_store', context)!} :',style: GoogleFonts.tajawal(
                          fontSize: 16,fontWeight: FontWeight.w400
                      ),),
                     
                      SizedBox(
                        width: 150,
                        height:50,
                        child: ClipRRect(
                            child: TextFormField(
                              controller: price,
                              decoration: InputDecoration(
                                hintText:  '${price.text} ر.س',
                                hintStyle: GoogleFonts.tajawal(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey
                                ),

                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                ),
                              ),
                              keyboardType: const TextInputType.numberWithOptions(decimal: false),

                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
                              ],
                              onChanged: (val){
                                if(val!=''&&val.isNotEmpty){
                                  // getProfit(double.parse(val));

                                }else{
                                  // getProfit(0);

                                }

                              },

                              textAlign: TextAlign.center,

                            ),
                          

                        ),
                      ),
                      const Spacer(),
                      widget.linked.requestStatus==true? Consumer<MyShopController>(
                        builder:(context, myShop, child) =>  InkWell(
                          onTap: ()async{
                            dialog('Products_are_being_synced');
                            double tax=0.00;

                            if(myShop.switch2){
                              tax= (((double.parse(price.text)+(((double.parse(myShop.taxController.text)/100)*double.parse(price.text))))));

                            }
    await myShop.addProductPrice(widget.linked.id, (double.parse(price.text)+tax).toString()).then((value) async{
    await myShop.syncOneProduct(widget.unSync==true, widget.linked.id,widget.unSync==false).then((value) async{
      await myShop.getList();
      myShop. initController();
      Navigator.pop(diagloContext);
    });
    });
print(widget.linked.id);



                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8,),
                            child: Image.asset(Images.sync,width: 25,),
                          ),
                        ),
                      ):const SizedBox.shrink()


                    ],
                  ),
                  const SizedBox(height: 5,),

                widget.unSync==true?  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${getTranslated('سبب الحذف', context)!} :',style: GoogleFonts.tajawal(
                          fontSize: 16,fontWeight: FontWeight.w400
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),

                        child: Text(getTranslated(widget.linked.linkedProduct.deletionReason ?? 'null', context)??'',style: GoogleFonts.tajawal(
                            fontSize: 16,fontWeight: FontWeight.w400
                        ),),
                      ),


                    ],
                  ):const SizedBox.shrink(),
                ],),
              ),
            )
          ],),
        ),
      ),
    );
  }
  BuildContext diagloContext=Get.context!;

  Future dialog(String text){

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
}
