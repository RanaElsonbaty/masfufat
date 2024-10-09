import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/view_all_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:provider/provider.dart';

import '../screens/brand_and_category_product_screen.dart';



class LatestProductListWidget extends StatelessWidget {
  const LatestProductListWidget({super.key});




  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370 ,
      child: Consumer<ProductController>(builder: (context, prodProvider, child) {
        return (prodProvider.latestProductList?.isNotEmpty ?? false)  ? Column( children: [
          TitleRowWidget(
            title: getTranslated('latest_products', context),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(isBrand: false, id: '0', name: getTranslated('latest_products', context), index: 0,))),
          ),

          const SizedBox(height: Dimensions.paddingSizeSmall),


          SizedBox(
            height:  320,
            // width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,

              itemCount: prodProvider.latestProductList?.length,
              itemBuilder: (context, index,) {
                return SizedBox(
                    width: 200,
                    child: ProductWidget(productModel: prodProvider.latestProductList![index], productNameLine: 1));
              },
            ),
          ),




        ]) : prodProvider.latestProductList == null ? const ProductShimmer(isEnabled: true, isHomePage: true) : const SizedBox();
      }),
    );
  }
}

