import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utill/dimensions.dart';

class StoreBottomSheet extends StatefulWidget {
  const StoreBottomSheet({super.key});

  @override
  State<StoreBottomSheet> createState() => _StoreBottomSheetState();
}

class _StoreBottomSheetState extends State<StoreBottomSheet> {
  List<String> types=[
    'all',
    'Waiting_for_review'
    ,
    'unavailable',
    'Deleted',

  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints : const BoxConstraints(maxHeight: 300,
          minHeight: 200 ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
child: Consumer<MyShopController>(
  builder:(context, myStore, child) =>  Column(

    children: [
      Container(height: 5,width: 40,decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey
      ),),
    SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount:types.length,
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            myStore.getSelectFilter(index);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [

                   Text(getTranslated(types[index], context)!,
                   style: GoogleFonts.tajawal(
                     fontSize: 16
                   ),
                   ),
                  const Spacer(),
                  Checkbox(
                    visualDensity: VisualDensity.compact,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            4)),
                    value: myStore.selectFilter!=null&&myStore.selectFilter==index, checkColor:Colors.white,onChanged: (val){
                    myStore.getSelectFilter(index);


                  },activeColor: Theme.of(context).primaryColor,)

                ],),
              ),
            ),
          ),
        );
      },),
    ),
      CustomButton(buttonText: getTranslated('okay', context)!,onTap: (){
        Navigator.pop(context);
      },

      )
  ],),
),
    );
  }
}
