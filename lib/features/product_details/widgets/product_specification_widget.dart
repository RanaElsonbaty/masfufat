import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
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
        width: MediaQuery.of(context).size.width,
        // height: (productSpecification.isNotEmpty && productSpecification.length > 400) ? 150 : null,
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall+5).copyWith(bottom: 0),
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


    ]);
  }
}
