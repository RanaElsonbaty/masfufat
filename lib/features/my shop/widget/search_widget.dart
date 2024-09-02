import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import 'bottomSheet.dart';

class MyShopSearchWidget extends StatefulWidget {
  const MyShopSearchWidget({super.key, required this.selectIndex});
  final int selectIndex;

  @override
  State<MyShopSearchWidget> createState() => _MyShopSearchWidgetWidgetState();
}

class _MyShopSearchWidgetWidgetState extends State<MyShopSearchWidget> {
  TextEditingController controller =TextEditingController();
  FocusNode searchFocusNode =FocusNode();
  @override
  Widget build(BuildContext context) {
    return Consumer<MyShopController>(
      builder:(context, myShopProvider, child) =>  Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,top: 20),
        child: SizedBox(
          height: 55,

          child: TextFormField(
            controller: controller,
            focusNode: searchFocusNode,
            textInputAction: TextInputAction.search,
            onChanged: (val){
                myShopProvider.search(myShopProvider.selectIndex, val);
            },
            onFieldSubmitted: (value) {

            },
            
            style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    borderSide: BorderSide(color: Colors.grey[300]!)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    borderSide: BorderSide(color: Colors.grey[300]!)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    borderSide: BorderSide(color: Colors.grey[300]!)),
                hintText: getTranslated('search_product', context),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(Images.searchIcon,color: Colors.grey,width: 15,height: 15,),
                ),
                suffixIcon: SizedBox(width: controller.text.isNotEmpty? 70 : 50,
                  child: Row(children: [
                    if(controller.text.isNotEmpty)
                      InkWell(onTap: (){

                      }, child: const Icon(Icons.clear, size: 20,)),


                 InkWell(onTap: (){
                   if(widget.selectIndex==2){
                     showModalBottomSheet(
                       context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                       builder: (c) =>   const StoreBottomSheet(),
                     );
                   }
                    },
                      child: Padding(padding: const EdgeInsets.all(5),
                        child: Container(width: 40, height: 40,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                            child: SizedBox(width : 18,height: 18, child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Image.asset(   widget.selectIndex==2?Images.filterImage:Images.search, color: Colors.white),
                            ))),
                      ),
                    ),
                  ],
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}
