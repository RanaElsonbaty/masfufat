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
  const LinkedProductWidget({super.key, required this.linked});
final Linked linked;
  @override
  State<LinkedProductWidget> createState() => _LinkedProductWidgetState();
}

class _LinkedProductWidgetState extends State<LinkedProductWidget> {
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
                return Checkbox(value: myShopProvider.selectIds.contains(widget.linked.id!), onChanged: (val){
                  myShopProvider.selectOneProduct(widget.linked.id!,val!);
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
                child:  CustomImageWidget(image: widget.linked.imageUrl!,height: 82,width: 84,)),
            const SizedBox(width: 10,),
            Expanded(
              flex: 11,
              child: Text(widget.linked.name!,
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
                  myShopProvider.selectOneProduct(widget.linked.id!, true);
                  // await myShopProvider.deleteProduct(widget.pending.id!);
                  showModalBottomSheet(context: context, builder: (BuildContext context)=> const ShowModalBottomSheetShop( delete: true,));
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFFCFCFC)


                  ),
                  child: Center(child:Image.asset(Images.delete,width: 25,),),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5,),
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFFFCFCFC)

          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(children: [
              InkWell(
                onTap: (){
                  Clipboard.setData(
                      ClipboardData(text: widget.linked.itemNumber!));
                  showCustomSnackBar(
                    getTranslated('The_text_has_been_copied', context),
                    context,
                    isError: false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('رقم المنتج',style: GoogleFonts.tajawal(
                        fontSize: 16,fontWeight: FontWeight.w500
                    ),),

                    Text(widget.linked.itemNumber!.toString(),style: GoogleFonts.tajawal(
                        fontSize: 16,fontWeight: FontWeight.w500
                    ),),

                  ],
                ),
              ),
              const SizedBox(height: 5,),

              InkWell(
                onTap: (){
                  Clipboard.setData(
                      ClipboardData(text: widget.linked.code!));
                  showCustomSnackBar(
                    getTranslated('The_text_has_been_copied', context),
                    context,
                    isError: false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('باركود المنتج sku',style: GoogleFonts.tajawal(
                        fontSize: 16,fontWeight: FontWeight.w500
                    ),),
                    Text(widget.linked.code!,style: GoogleFonts.tajawal(
                        fontSize: 16,fontWeight: FontWeight.w500
                    ),),

                  ],
                ),
              ),
              const SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('التكلفة',style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  Text(PriceConverter.convertPrice(context,widget.linked.pricings!.value!),style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              const SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('سعر البيع المقترح',style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  Text(PriceConverter.convertPrice(context, widget.linked.pricings!.suggestedPrice!),style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              const SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('سعر البيع في متجري',style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  Text(PriceConverter.convertPrice(context, widget.linked.ownPrice!=null? widget.linked.ownPrice:0.00),style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),
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
    );
  }
}
