import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/home_category_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:provider/provider.dart';

class HomeCategoryProductItemWidget extends StatelessWidget {
  final HomeCategoryProduct homeCategoryProduct;
  final int index;
  final bool isHomePage;
  const HomeCategoryProductItemWidget({super.key, required this.homeCategoryProduct, required this.index, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      // color: index.isEven ? null : Theme.of(context).cardColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        if(isHomePage) ...[
          if(index != 0) const SizedBox(height: Dimensions.paddingSizeSmall),

          TitleRowWidget(
            title: homeCategoryProduct.name,
            onTap: () {
              final tIndex =  Provider.of<CategoryController>(context, listen: false).categoryList.indexWhere((element) => element.id == homeCategoryProduct.id);

              // print('homeCategoryProduct --- ${homeCategoryProduct.}')
              Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                  isBrand: false,
                  index:  tIndex,
                  id: homeCategoryProduct.id.toString(),
                  name: homeCategoryProduct.name)));
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

        ],

SingleChildScrollView(
  scrollDirection: Axis.horizontal,

  child: SizedBox(
    height: 320,
    child: ListView.builder(
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.horizontal,
      itemCount: (isHomePage && homeCategoryProduct.products!.length > 4) ? 4
              : homeCategoryProduct.products!.length,
      shrinkWrap: true,
      itemBuilder:(context, i) {
        return SizedBox(
          width: 200,
          child: InkWell(onTap: () {
              Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
                  pageBuilder: (context, anim1, anim2) => ProductDetails(productId: homeCategoryProduct.products![i].id,
                      slug: homeCategoryProduct.products![i].slug, product: homeCategoryProduct.products![i],)));
            },
                child: ProductWidget(productModel: homeCategoryProduct.products![i])),
        );
      },
    ),
  ),
),
        // ListView.builder(
        //     itemCount: (isHomePage && homeCategoryProduct.products!.length > 4) ? 4
        //         : homeCategoryProduct.products!.length,
        //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        //     physics: const NeverScrollableScrollPhysics(),
        //     scrollDirection: Axis.horizontal,
        //
        //     // crossAxisCount: ResponsiveHelper.isTab(context)? 3 : 2,
        //     shrinkWrap: true,
        //     itemBuilder: (BuildContext context, int i) {
        //       return InkWell(onTap: () {
        //         Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
        //             pageBuilder: (context, anim1, anim2) => ProductDetails(productId: homeCategoryProduct.products![i].id,
        //                 slug: homeCategoryProduct.products![i].slug)));
        //       },
        //           child: ProductWidget(productModel: homeCategoryProduct.products![i]));
        //     }),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ],
      ),
    );
  }
}