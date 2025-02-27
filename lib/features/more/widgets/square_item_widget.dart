import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SquareButtonWidget extends StatelessWidget {
  final String image;
  final String? title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;
  final bool isWallet;
  final double? balance;
  final bool isLoyalty;
  final String? subTitle;

  const SquareButtonWidget({super.key, required this.image,
    required this.title, required this.navigateTo, required this.count,
    required this.hasCount, this.isWallet = false, this.balance, this.subTitle,
    this.isLoyalty = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Padding(padding: const EdgeInsets.all(8.0),
        child: Container(width: 150, height: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Provider.of<ThemeController>(context).darkTheme ?
              Theme.of(context).primaryColor.withOpacity(.30) : Theme.of(context).primaryColor),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            // Positioned(top: -80,left: -10,right: -10,
            //     child: Container(height: 120, decoration: BoxDecoration(
            //         border: Border.all(color: Colors.white.withOpacity(.07), width: 15),
            //         borderRadius: BorderRadius.circular(100)))),


            // isWallet?
            Padding(padding: const EdgeInsets.all(8.0),
              child: SizedBox(width: 30, height: 30,child: Image.asset(image, color: Colors.white)),
            ),
                // :

            // Center(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            //     child: Image.asset(image, color: ColorResources.white))),
const SizedBox(width: 5,),
            // if(isWallet)
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, children: [

                Text(getTranslated(subTitle, context)??'',
                  // textAlign: TextAlign.end,

                  style: GoogleFonts.tajawal(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),),

              SizedBox(
                width: 80,
                child: Row(
                  children: [
                    isLoyalty? Expanded(
                      flex: 11,
                      child: Text(balance != null? balance!.toStringAsFixed(0) : '0',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:  GoogleFonts.tajawal(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14)),
                    ):

                    Expanded(
                      // flex: ,
                      child: Text(balance != null? PriceConverter.convertPrice(context, balance):'0',
                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,
                          style:  GoogleFonts.tajawal(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14)),
                    )
                  ],
                ),
              )
              ]),

            // hasCount?
            // Consumer<CartController>(builder: (context, cart, child) {
            //   return CircleAvatar(radius: 10, backgroundColor: ColorResources.red,
            //       child: Text(count.toString(), style:  GoogleFonts.tajawal(color: Theme.of(context).cardColor,
            //           fontSize: Dimensions.fontSizeExtraSmall)));
            // }):const SizedBox(),
            // Text(title??'', maxLines: 1,overflow: TextOverflow.clip,
            //     style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
            //         color: Theme.of(context).textTheme.bodyLarge?.color)),
          ])),
      ),
    );
  }
}