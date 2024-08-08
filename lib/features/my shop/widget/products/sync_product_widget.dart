import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/widget/show_Modal_Bottom_Sheet.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../domain/model/model.dart';

class SyncProductWidget extends StatefulWidget {
  const SyncProductWidget({super.key,  required this.pending, required this.controller, required this.index,  });
 final Pending pending ;
 final TextEditingController controller;
 final int index;

  @override
  State<SyncProductWidget> createState() => _SyncProductWidgetState();
}

class _SyncProductWidgetState extends State<SyncProductWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<MyShopController>(
              builder:(context, myShopProvider, child) {
                return Checkbox(value: myShopProvider.selectIds.contains(widget.pending.id!), onChanged: (val){
              myShopProvider.selectOneProduct(widget.pending.id!,val!);
              },
                checkColor: Colors.white,
                activeColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              );
              },
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:  CustomImageWidget(image: widget.pending.imageUrl!,height: 82,width: 84,)),
            const SizedBox(width: 10,),
            Expanded(
              flex: 11,
              child: Text(widget.pending.name!,
                overflow: TextOverflow.visible,
                style: GoogleFonts.tajawal(
                fontWeight: FontWeight.w500,

                fontSize: 16  ,

              ),
              ),
            ),
            Consumer<MyShopController>(
              builder:(context, myShopProvider, child) =>  InkWell(
                onTap: ()async{
                  myShopProvider.selectOneProduct(widget.pending.id!, true);
                  // await myShopProvider.deleteProduct(widget.pending.id!);
                  showModalBottomSheet(context: context, builder: (BuildContext context)=> const ShowModalBottomSheetShop( delete: true,));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor


                  ),
                  child: Center(child:Image.asset(Images.delete,width: 25,),),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5,),
        Container(
          decoration:  const BoxDecoration(
            // color: Theme.o/f(context).cardColor

          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(children: [
              InkWell(
                onTap: (){
                  Clipboard.setData(
                      ClipboardData(text: widget.pending.itemNumber!));
                  showCustomSnackBar(
                    getTranslated('The_text_has_been_copied', context),
                    context,
                    isError: false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getTranslated('Product_number', context)!,style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                    ),),
                
                    Text(widget.pending.itemNumber!.toString(),style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                    ),),
                
                  ],
                ),
              ),
              const SizedBox(height: 5,),

              InkWell(
                onTap: (){
                  Clipboard.setData(
                      ClipboardData(text: widget.pending.code!));
                  showCustomSnackBar(
                    getTranslated('The_text_has_been_copied', context),
                    context,
                    isError: false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getTranslated('Product_barcode_sku', context)!,style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                    ),),
                    Text(widget.pending.code!,style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                    ),),

                  ],
                ),
              ),
              const SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated('cost', context)!,style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  Text(PriceConverter.convertPrice(context,widget.pending.pricings!.value!),style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              const SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated('Suggested_selling_price', context)!,style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  Text(PriceConverter.convertPrice(context, widget.pending.pricings!.suggestedPrice!),style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              const SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated('Selling_price_in_my_store', context)!,style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  SizedBox(
                    width: 150,

                    child:  CustomTextFieldWidget(
                      controller: widget.controller,
maxLines: 1,
                      hintText:'140 ر.س',
                      isAmount: true,
                    )
                  )

                ],
              ),
            ],),
          ),
        )
      ],),
    );
  }

}
