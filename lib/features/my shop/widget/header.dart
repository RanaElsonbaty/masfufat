import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/widget/show_Modal_Bottom_Sheet.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'bottomSheet.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key, required this.index, required this.pending});
  final int index;
final bool pending;
  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyShopController>(
      builder:(context, myShopProvider, child) =>  SizedBox(
        height: widget.index==0? 100:60,
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.index==0?   InkWell(
                  onTap: (){
                    showModalBottomSheet(context: context, builder: (BuildContext context)=>const ShowModalBottomSheetShop(delete: false,));

                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(getTranslated('Save_and_sync_now', context)!,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.tajawal(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Image.asset(Images.syncIcon
                            ,
                            color: Colors.white,width: 20,)
                        ],),
                    ),
                  ),
                ):const SizedBox.shrink(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.ss
                children: [

                  // widget.index!=0? const Spacer():const SizedBox.shrink(),

                Checkbox(
                  value: myShopProvider.selectAll,
                  onChanged: (val){
                    myShopProvider.getSelectProduct(myShopProvider.selectIndex);
                  },
                  checkColor: Colors.white,

                  fillColor:  MaterialStatePropertyAll(myShopProvider.selectAll?Theme.of(context).primaryColor:const Color(0xffFAEBEB)),
                  side: BorderSide.none,

                  activeColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
               Padding(
                 padding: const EdgeInsets.only(top: 4.0),

                 child: Text(getTranslated('Select_all', context)!,style: GoogleFonts.tajawal(
                   fontWeight: FontWeight.w500,
                   fontSize: 14
                 ),),
               ),


               const Spacer(),
                // myShopProvider.selectIndex==2?InkWell(
                //   onTap: (){
                //     showModalBottomSheet(
                //       context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                //       builder: (c) =>   const StoreBottomSheet(),
                //     );
                //   },
                //   child: Container(
                //     height: 45,
                //     width: 55,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: Theme.of(context).cardColor,
                //         boxShadow: [
                //           BoxShadow(
                //               color:
                //               Colors.black.withOpacity(0.3),
                //               spreadRadius: 1,
                //               blurRadius: 2)
                //         ]
                //     ),
                //     child: const Icon(Icons.filter_list),
                //   ),
                // ):const SizedBox.shrink(),
                // const SizedBox(width: 10,),
                // InkWell(
                //   onTap:    () {
                //     myShopProvider.getSearch();
                //   },
                //   child: Container(
                //     height: 45,
                //     width: 55,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Theme.of(context).cardColor,
                //         boxShadow: [
                //           BoxShadow(
                //               color:
                //               Colors.black.withOpacity(0.3),
                //               spreadRadius: 1,
                //               blurRadius: 2)
                //         ]),
                //     child: Padding(
                //       padding: const EdgeInsets.all(4.0),
                //       child: Image.asset(
                //         Images.search,
                //         color: Theme.of(context).iconTheme.color,
                //       ),
                //     ),
                //   ),
                // ),   const SizedBox(width: 10,),
                InkWell(
                   onTap: () {
                     showModalBottomSheet(context: context, builder: (BuildContext context)=> const ShowModalBottomSheetShop(delete: true));
                   },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Images.delete,
                      color: Colors.red,
                      width: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),

                  child: Text(getTranslated('Delete_all', context)!,style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),),
                ),

                const SizedBox(width: 10,),
              ],),
            ),

          ],
        ),
      ),
    );
  }
}
