import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';

import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductListWidget extends StatefulWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController? scrollController;

  const ProductListWidget({super.key, required this.isHomePage, required this.productType, this.scrollController});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int offset = 1;
    widget.scrollController?.addListener(() {
      if(  widget.scrollController!.position.pixels>= (widget.scrollController!.position.maxScrollExtent-4000.0)

          && !Provider.of<ProductController>(Get.context!, listen: false).filterIsLoading) {
        late int pageSize;
        if(widget.productType == ProductType.bestSelling || widget.productType == ProductType.topProduct ||
            widget.productType == ProductType.newArrival ||widget.productType == ProductType.discountedProduct || widget.productType == ProductType.featuredProduct) {
          if(widget.productType == ProductType.featuredProduct) {
            pageSize = (Provider.of<ProductController>(context, listen: false).featuredPageSize!/50).ceil();
          } else {
            pageSize = (Provider.of<ProductController>(context, listen: false).latestPageSize!/50).ceil();
          }
          if(widget.productType == ProductType.featuredProduct) {
            offset = Provider.of<ProductController>(context, listen: false).lOffsetFeatured;
          } else{
            offset = Provider.of<ProductController>(context, listen: false).lOffset;
          }
        }

        else if(widget.productType == ProductType.justForYou){

        }
        if(offset < pageSize) {
          offset++;
          Provider.of<ProductController>(context, listen: false).showBottomLoader();
          if(widget.productType == ProductType.featuredProduct){
            Provider.of<ProductController>(context, listen: false).getFeaturedProductList(offset.toString());
          }else {
            Provider.of<ProductController>(context, listen: false).getLatestProductList(offset);
          }
        }else{

        }

      }
    });

  }
  @override
  Widget build(BuildContext context) {


    return Consumer<ProductController>(
      builder: (context, prodProvider, child) {
        List<Product>? productList = [];
        if(widget.productType == ProductType.latestProduct) {
          productList = prodProvider.lProductList;
        }
        else if(widget.productType == ProductType.featuredProduct) {
          productList = prodProvider.featuredProductList;
        }else if(widget.productType == ProductType.topProduct) {
          productList = prodProvider.latestProductList;
        }else if(widget.productType == ProductType.bestSelling) {
          productList = prodProvider.latestProductList;
        }else if(widget.productType == ProductType.newArrival) {
          productList = prodProvider.latestProductList;
        }else if(widget.productType == ProductType.justForYou) {
          productList = prodProvider.justForYouProduct;
        }

        return Column(children: [
          !prodProvider.filterFirstLoading ? (productList != null && productList.isNotEmpty) ?
          MasonryGridView.count(
            itemCount: widget.isHomePage? productList.length>4?
            4:productList.length:productList.length,
            crossAxisCount: ResponsiveHelper.isTab(context)? 3 :2,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ProductWidget(productModel: productList![index]);
            },
          ) : const NoInternetOrDataScreenWidget(isNoInternet: false): ProductShimmer(isHomePage: widget.isHomePage ,isEnabled: prodProvider.firstLoading),

          prodProvider.filterIsLoading ? Center(child: Padding(
            padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : const SizedBox.shrink()]);
      },
    );
  }
}

