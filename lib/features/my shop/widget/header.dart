import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/widget/show_Modal_Bottom_Sheet.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key, required this.index});
  final int index;

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyShopController>(
      builder:(context, myShopProvider, child) =>  SizedBox(
        height: 100,
        child: Row(children: [
          Checkbox(
            value: true,
            onChanged: (val){},
            checkColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)),
          ),

       widget.index==0?   Expanded(
            child: InkWell(
onTap: (){
  showModalBottomSheet(context: context, builder: (BuildContext context)=>ShowModalBottomSheetShop(delete: false,));

},
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
              
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
              
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(getTranslated('Save_and_sync_now', context)!,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      ),
                    ),
                      const SizedBox(width: 5,),
                      Image.asset(Images.sync
                      ,
                      color: Colors.white,width: 20,)
                  ],),
                ),
              ),
            ),
          ):const SizedBox.shrink(),
         widget.index!=0? const Spacer():const SizedBox.shrink(),
          const SizedBox(width: 10,),
          InkWell(
            onTap:    () {
              myShopProvider.getSearch();
            },
            child: Container(
              height: 45,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                        color:
                        Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  Images.search,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),   const SizedBox(width: 10,),
          InkWell(
             onTap: () {
               showModalBottomSheet(context: context, builder: (BuildContext context)=>ShowModalBottomSheetShop(delete: true,));
             },
            child: Container(
              height: 45,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                        color:
                        Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Images.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
        ],),
      ),
    );
  }
}
