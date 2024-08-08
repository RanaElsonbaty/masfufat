import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  final int index;
  final bool isDigital;
  final String? icon;
  final String name;
  final String title;
  final int id;

  const CustomCheckBoxWidget(
      {super.key,
      required this.index,
      this.isDigital = false,
      this.icon,
      required this.name,
      required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    // print('name --->  $icon');
    return Consumer<CheckoutController>(
      builder: (context, order, child) {
        return InkWell(
          onTap: () => order.setDigitalPaymentMethodName(index, name,id),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              ),
              child: Row(children: [
                Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          Provider.of<ThemeController>(context, listen: false)
                                  .darkTheme
                              ? Theme.of(context).hintColor.withOpacity(.5)
                              : Theme.of(context).primaryColor.withOpacity(.25),
                    ),
                    child: Checkbox(
                          visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeExtraLarge)),
                        value: order.paymentMethodIndex == index,
                        activeColor: Colors.green,
                        checkColor: Theme.of(context).cardColor,
                        onChanged: (bool? isChecked) =>
                            order.setDigitalPaymentMethodName(index, name,id))),
                SizedBox(
                    height: 40,
                    child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        child:icon!.startsWith('https://')?CustomImageWidget(image: icon!):Image.asset(icon!))),
               id!=4? Text(
                  getTranslated(name, context)!,
                  style:
                      textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                ):const SizedBox.shrink(),
              ]),
            ),
          ),
        );
      },
    );
  }
}
