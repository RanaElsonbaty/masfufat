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
    return Consumer<MyShopController>(
      builder:(context, myShopProvider, child) =>  InkWell(
        onTap: () {
          myShopProvider.selectType(widget.index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${getTranslated(widget.title, context)}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 2,
              style: GoogleFonts.tajawal(
              fontSize: 14
                  ,
                color:myShopProvider.selectIndex==widget.index?Theme.of(context).primaryColor: Theme.of(context).iconTheme.color,
                fontWeight: FontWeight.w500
            ),),
          ),
            myShopProvider.selectIndex==widget.index?  Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ):const SizedBox.shrink()
          //   widget.subTitle!=''? Text("${getTranslated(widget.subTitle, context)}",
          //   textAlign: TextAlign.center,
          //     overflow: TextOverflow.ellipsis,
          //
          //   style: GoogleFonts.tajawal(
          //     fontSize: 11,
          //       color: Theme.of(context).iconTheme.color,
          //
          //       fontWeight: FontWeight.w500
          //
          // ),):const SizedBox.shrink(),
        ],),
      ),
    );
  }
}
