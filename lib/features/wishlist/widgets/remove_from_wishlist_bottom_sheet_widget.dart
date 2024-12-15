import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:provider/provider.dart';

class RemoveFromWishlistBottomSheet extends StatelessWidget {
  final int productId;
  final int index;
  const RemoveFromWishlistBottomSheet({super.key, required this.productId, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 120,height: 5,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.5), borderRadius: BorderRadius.circular(20))),
        const SizedBox(height: 20,),

        // Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        //   child: SizedBox(width: 60,child: Image.asset(Images.removeWish)),),
        // const SizedBox(height: Dimensions.paddingSizeDefault,),

        Text(getTranslated('remove_from_wish', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

        // Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
        //   child: Text('${getTranslated('remove_this_item', context)}'),),
        const SizedBox(height: 40),


        Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [

            Expanded(
              child: SizedBox(child: CustomButton(buttonText: '${getTranslated('remove', context)}',
                  backgroundColor: Colors.red, onTap: (){
                Provider.of<WishListController>(context, listen: false).removeWishList(productId, index: index);
                Navigator.of(context).pop();
              })),
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault,),

            Expanded(
              child: SizedBox(child: CustomButton(buttonText: '${getTranslated('cancel', context)}',
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.2),
                textColor: Theme.of(context).textTheme.bodyLarge?.color,
                onTap: ()=> Navigator.pop(context),)),
            ),
          ],),
        )
      ],),
    );
  }
}
