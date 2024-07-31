import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectTypeSection extends StatefulWidget {
  const SelectTypeSection({super.key, required this.title, required this.subTitle, required this.index});
  final String title;
  final String subTitle;
final int index;

  @override
  State<SelectTypeSection> createState() => _SelectTypeSectionState();
}

class _SelectTypeSectionState extends State<SelectTypeSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Consumer<MyShopController>(
        builder:(context, myShopProvider, child) =>  InkWell(
          onTap: () {
            myShopProvider.selectType(widget.index);
          },
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              // color: Colors.black,
              color: myShopProvider.selectIndex==widget.index?Theme.of(context).primaryColor:Colors.white,
              border: Border.all(width: .8,color: Colors.grey),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(
                  '${getTranslated(widget.title, context)}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.tajawal(
                  fontSize: 15
                      ,
                    color: myShopProvider.selectIndex==widget.index?Colors.white:Colors.black,
                    fontWeight: FontWeight.w700
                ),),
                  widget.subTitle!=''? Text("${getTranslated(widget.subTitle, context)}",
                  textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,

                  style: GoogleFonts.tajawal(
                    fontSize: 11,
                      color: myShopProvider.selectIndex==widget.index?Colors.white:Colors.black,

                      fontWeight: FontWeight.w500

                ),):const SizedBox.shrink(),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}
