
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment%20/controller/payment_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/controllers/search_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/widgets/custom_check_box_widget.dart';
import 'package:provider/provider.dart';

import '../../splash/domain/models/config_model.dart';

class PaymentMethodBottomSheetWidget extends StatefulWidget {
  final bool onlyDigital;
  const PaymentMethodBottomSheetWidget({super.key, required this.onlyDigital,});
  @override
  PaymentMethodBottomSheetWidgetState createState() => PaymentMethodBottomSheetWidgetState();
}
class PaymentMethodBottomSheetWidgetState extends State<PaymentMethodBottomSheetWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutController>(
      builder: (context, checkoutProvider, _) {
        return Container(constraints : BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9,
            minHeight: MediaQuery.of(context).size.height * 0.5 ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: Center(child: Container(width: 35,height: 4,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                      color: Theme.of(context).hintColor.withOpacity(.5))))),

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Text(getTranslated('choose_payment_method', context)??'',
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault)),

                    ])),


              Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, children: [


                               Consumer<PaymentController>(
                      builder: (context, configProvider,_) {

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: configProvider.paymentMethod.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return  CustomCheckBoxWidget(index: index,
                              icon: configProvider.paymentMethod[index].image,
                              name:configProvider. paymentMethod[index].name,
                              title:'',
                              id: configProvider. paymentMethod[index].id,
                            );
                          },
                        );
                      }
                  ),



                  CustomButton(buttonText: '${getTranslated('save', context)}',
                  onTap: ()=> Navigator.of(context).pop()),
                ],
              ),

            ]),
          ),
        );
      }
    );
  }
}

class FilterItemWidget extends StatelessWidget {
  final String? title;
  final int index;
  const FilterItemWidget({super.key, required this.title, required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: Row(children: [
          Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: InkWell(onTap: ()=> Provider.of<SearchProductController>(context, listen: false).setFilterIndex(index),
                child: Icon(Provider.of<SearchProductController>(context).filterIndex == index?
                Icons.check_box_rounded: Icons.check_box_outline_blank_rounded,
                    color: Provider.of<SearchProductController>(context).filterIndex == index?
                    Theme.of(context).primaryColor: Theme.of(context).hintColor.withOpacity(.5))),
          ),
          Expanded(child: Text(title??'', style: textRegular.copyWith())),
        ],),),
    );
  }
}

class CategoryFilterItem extends StatelessWidget {
  final String? title;
  final bool checked;
  final Function()? onTap;
  const CategoryFilterItem({super.key, required this.title, required this.checked, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: Row(children: [
          Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: InkWell(onTap: onTap,
                child: Icon(checked? Icons.check_box_rounded: Icons.check_box_outline_blank_rounded,
                    color: checked? Theme.of(context).primaryColor: Theme.of(context).hintColor.withOpacity(.5)))),
          Expanded(child: Text(title??'', style: textRegular.copyWith())),
        ],),),
    );
  }
}
class PaymentMethod {
  String name;
  String image;
  int id;
  PaymentMethod(this.name, this.image, this.id);
}

