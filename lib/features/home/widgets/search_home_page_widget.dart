import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/qr_code_scanner.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../utill/images.dart';

class SearchHomePageWidget extends StatelessWidget {
  const SearchHomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraExtraSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.homePagePadding,
            vertical: Dimensions.paddingSizeSmall),
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Provider.of<LocalizationController>(context, listen: false)
                          .isLtr
                      ? Dimensions.homePagePadding
                      : Dimensions.paddingSizeExtraSmall,
                  right: Provider.of<LocalizationController>(context, listen: false)
                          .isLtr
                      ? Dimensions.paddingSizeExtraSmall
                      : Dimensions.homePagePadding),
              height: 60,
              width: MediaQuery.of(context).size.width-80,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                // color: Theme.of(context).cardColor,
                boxShadow: Provider.of<ThemeController>(context).darkTheme
                    ? null
                    : [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 0))
                      ],
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(getTranslated('search_hint', context) ?? '',
                    style:
                        textRegular.copyWith(color: Theme.of(context).hintColor)),
                const Spacer(),
                InkWell(
                  onTap: ()async{
                        await Permission.camera.request();
                        if (await Permission.camera.isDenied) {

                        } else {
                          Navigator.push(Get.context!,MaterialPageRoute(builder:   (context) => const QrCodeScanner(fromHome: true,)));

                        }


                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimensions.paddingSizeExtraSmall))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Images.barcode,width: 15,color: Colors.white,),
                    ),
                  ),
                ),
                    const SizedBox(width: 5,),

              ]),
            ),
            const SizedBox(width: 5,),

            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.paddingSizeExtraSmall))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(Images.filterIcon,width: 15,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
