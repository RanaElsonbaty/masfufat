import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/widget/show_Modal_Bottom_Sheet.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


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
        height: widget.index==0||widget.index==2? 100:myShopProvider.selectIds.isEmpty?60:80,
        child: Column(
          children: [

            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment:myShopProvider.selectIds.isEmpty?MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
              children: [
                // const SizedBox(width: 2,),
                // if(myShopProvider.selectIds.isNotEmpty)
                // // widget.index==0||widget.index==2?
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       child: Text("${getTranslated('Specific_products', context)!} ${myShopProvider.selectIds.length}",style: GoogleFonts.tajawal(
                //         fontWeight: FontWeight.w600,
                //         fontSize: 14,
                //       ),),
                //     ),
                        // :const SizedBox(),
                if(widget.index==0||widget.index==2)
                  Expanded(
                    child: InkWell(
                    onTap: (){
                      showModalBottomSheet(context: context, builder: (BuildContext context)=> ShowModalBottomSheetShop(delete: false,index: widget.index,));

                    },
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      // widtdh: MediaQuery.of(context).size.width/2,
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
                            Image.asset(Images.syncIcon,
                              color: Colors.white,width: 20,),

                          ],),
                      ),
                    ),
                                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
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

                 child: Text("${getTranslated('Select_all', context)!} ${myShopProvider.selectIds.isNotEmpty?"(${myShopProvider.selectIds.length})":""}",style: GoogleFonts.tajawal(
                   fontWeight: FontWeight.w500,
                   fontSize: 14
                 ),),
               ),


               const Spacer(),
                InkWell(
                   onTap: () {
                     if(myShopProvider.selectIds.isNotEmpty) {
                       showModalBottomSheet(context: context, builder: (
                           BuildContext context) =>
                       const ShowModalBottomSheetShop(delete: true));
                     }else{
                       showCustomSnackBar(getTranslated('Please_select_one_or_more_products_to_delete', context), context);
                     }
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
