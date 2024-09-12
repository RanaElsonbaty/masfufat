import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/specification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class ProductSpecificationWidget extends StatelessWidget {
  final String productSpecification;


  const ProductSpecificationWidget({super.key, required this.productSpecification});

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
 crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Text(getTranslated('product_specification', context)??'',style: textMedium ),

      Container(
        height: (productSpecification.isNotEmpty && productSpecification.length > 400) ? 150 : null,
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall).copyWith(bottom: 0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          child: HtmlWidget(productSpecification, textStyle: GoogleFonts.tajawal(
            fontSize: 14,fontWeight: FontWeight.w400
          ), onTapUrl: (String url) {
            return launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
          }),
        ),
      ),

      if(productSpecification.isNotEmpty && productSpecification.length > 400)
        Center(child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SpecificationScreen(specification: productSpecification))),
          child: Text(getTranslated('view_full_detail', context)!, style: titleRegular.copyWith(
            color: Provider.of<ThemeController>(context, listen: false).darkTheme
                ? Colors.white
                : Theme.of(context).primaryColor,
          )),
        )),
    ]);
  }
}
