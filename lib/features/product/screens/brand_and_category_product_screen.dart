import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/paginated_list_view_widget.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;
  const BrandAndCategoryProductScreen({super.key, required this.isBrand, required this.id, required this.name, this.image});

  @override
  State<BrandAndCategoryProductScreen> createState() => _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState extends State<BrandAndCategoryProductScreen> {
  ScrollController scrollController =ScrollController();
  static const _pageSize = 50;
  final PagingController pagingController =
  PagingController(firstPageKey: 1);
  int _page=1;
  int get page =>_page;
  Future<void> fetchPage(int pageKey,bool isBrand ,String id,BuildContext context,bool reloud) async {
    try {
      final List<Product>  newItems = await Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(isBrand,id,context,pageKey,true);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
setState(() {
  _page =(_page+1);

});
    } catch (error) {
      pagingController.error = error;
    }

  }
  @override
  void initState() {

    super.initState();

    initData();


  }
  void initData()async{
    // productController= Provider.of<ProductController>(Get.context!, listen: false);
   // await Future.delayed(const Duration(milliseconds: 500));
   //  productController!.refreshPaging();
   //  Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(widget.isBrand, widget.id, context,1,true);
   pagingController.addPageRequestListener((pageKey) {
      fetchPage(page,widget.isBrand, widget.id, Get.context!,true);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // productController!.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: widget.name),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          return RefreshIndicator(
            onRefresh: ()async{
              pagingController.refresh();
            },
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: PagedMasonryGridView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            physics: const BouncingScrollPhysics(),
                  pagingController: pagingController,

                gridDelegateBuilder: (childCount) =>   SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width> 480? 3 : 2,
                ),
                builderDelegate: PagedChildBuilderDelegate(
                     firstPageProgressIndicatorBuilder: (context) {
                       return const ProductShimmer(isHomePage: false,
                  isEnabled: true);
                     },
                  noMoreItemsIndicatorBuilder: (context) {
                    return const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noProduct,
                message: 'no_product_found',);
                  },
                  newPageErrorIndicatorBuilder: (context) {
                    return const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noProduct,
                      message: 'no_product_found',);
                  },
                  // newPageProgressIndicatorBuilder: (context) {
                  //   return const ProductShimmer(isHomePage: false,
                  //       isEnabled: true);
                  // },
                  noItemsFoundIndicatorBuilder: (context) {
                    return const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noProduct,
                      message: 'no_product_found',);
                  },
                  itemBuilder: (context, item, index) {
               return ProductWidget(productModel: item as Product);

                },),

              ),
            ),
          );
        },
      ),
    );
  }
}
//    // MasonryGridView.count(
//                      //        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                      //        physics: const BouncingScrollPhysics(),
//                      //
//                      //
//                      //        crossAxisCount: MediaQuery.of(context).size.width> 480? 3 : 2,
//                      //        itemCount: productController.brandOrCategoryProductList.length,
//                      //        shrinkWrap: true,
//                      //        itemBuilder: (BuildContext context, int index) {
//                      //          return ProductWidget(productModel: productController.brandOrCategoryProductList[index]);
//                      //        },
//                      //      )
//
//                 // :
//
//             // productController.hasData! ?
//             //
//             //   const ProductShimmer(isHomePage: false,
//             //     isEnabled: true)
//             //     : const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noProduct,
//             //   message: 'no_product_found',),