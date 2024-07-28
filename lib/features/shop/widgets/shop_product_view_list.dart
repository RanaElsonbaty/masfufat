import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../product/domain/models/product_model.dart';

class ShopProductViewList extends StatefulWidget {
  final ScrollController scrollController;
  final int sellerId;
  const ShopProductViewList({super.key, required this.scrollController, required this.sellerId});

  @override
  State<ShopProductViewList> createState() => _ShopProductViewListState();
}

class _ShopProductViewListState extends State<ShopProductViewList> {
  ScrollController scrollController =ScrollController();
  static const _pageSize = 50;
  final PagingController pagingController =
  PagingController(firstPageKey: 1);
  int _page=1;
  int get page =>_page;
  Future<void> fetchPage(int pageKey) async {
    try {
      // await Provider.of<SellerProductController>(context, listen: false).getSellerProductList(widget.sellerId.toString(), 1, "");
      //
      final List<Product>  newItems = await Provider.of<SellerProductController>(context, listen: false).getSellerProductList(widget.sellerId.toString(), page, "");
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
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(page);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SellerProductController>(
      builder: (context, productController, _) {
        return  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PagedMasonryGridView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              physics: const BouncingScrollPhysics(),
              pagingController: pagingController,

              gridDelegateBuilder: (childCount) =>   const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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

        //   productController.sellerProduct != null ? (productController.sellerProduct!.products != null &&
        //     productController.sellerProduct!.products!.isNotEmpty)?
        // PaginatedListView(scrollController: widget.scrollController,
        //     onPaginate: (offset) async=> await productController.getSellerProductList(widget.sellerId.toString(), offset!, "", reload: false),
        //     totalSize: productController.sellerProduct?.totalSize,
        //     offset: productController.sellerProduct?.offset,
        //     itemView: MasonryGridView.count(
        //       itemCount: productController.sellerProduct?.products?.length,
        //       crossAxisCount: ResponsiveHelper.isTab(context)? 3 : 2,
        //       padding: const EdgeInsets.all(0),
        //       physics: const NeverScrollableScrollPhysics(),
        //       shrinkWrap: true,
        //       itemBuilder: (BuildContext context, int index) {
        //         return ProductWidget(productModel: productController.sellerProduct!.products![index]);
        //       },
        //     )) : const NoInternetOrDataScreenWidget(isNoInternet: false):
        // const ProductShimmer(isEnabled: true, isHomePage: false);
      }
    );
  }
}
