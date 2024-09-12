import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/model/model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/basewidget/custom_image_widget.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),

                        child: Text(PriceConverter.convertPrice(context, widget.linked.pricings.suggestedPrice),style: GoogleFonts.tajawal(
                            fontSize: 16,fontWeight: FontWeight.w400
                        ),),
                      ),
                      // SizedBox(
                      //     width: 150,
                      //
                      //     child:  CustomTextFieldWidget(
                      //       controller: widget.controller,
                      //       maxLines: 1,
                      //       hintText:'140 ر.س',
                      //       isAmount: true,
                      //     )
                      // )

                    ],
                  ),
                ],),
              ),
            )
          ],),
        ),
      ),
    );
  }
}
