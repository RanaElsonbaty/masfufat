import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/widgets/partial_matched_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/widgets/search_filter_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/controllers/search_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_filter_dialog_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/no_internet_screen_widget.dart';

class SearchProductWidget extends StatefulWidget {

  const SearchProductWidget({super.key, });

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  ScrollController scrollController = ScrollController();
  static const _pageSize = 5;

  final PagingController _pagingController = PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Product> newItems =
      await                    Provider.of<SearchProductController>(context,listen: false).searchProduct(
          query: Provider.of<SearchProductController>(context,listen: false).searchController.text,
          offset: pageKey,
        priceMin: Provider.of<SearchProductController>(context, listen: false).minFilterValue.toString(),
priceMax: Provider.of<SearchProductController>(context, listen: false).maxFilterValue.toString(),
        brandIds: Provider.of<CategoryController>(context,listen: false).selectId,
        categoryIds: Provider.of<CategoryController>(context,listen: false).selectId,
        brand:  Provider.of<CategoryController>(context,listen: false).isBrand,
        sort: Provider.of<SearchProductController>(context, listen: false).sortText,
        syncFilter:Provider.of<SearchProductController>(context, listen: false).syncSortText
      );
      pageKey = pageKey + 1;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = _pagingController.nextPageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      _fetchPage(pageKey);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<SearchProductController>(
      builder: (context, searchProductController,_) {
        return Column(children: [
          Container(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(color: Theme.of(context).canvasColor,
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 1),)]),
              child:  SearchSuggestion(pagingController: _pagingController,)),
          const SizedBox(width: Dimensions.paddingSizeDefault,),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(children: [
                  Expanded(child: Text('${getTranslated('product_list', context)}',style: robotoBold,)),


                  InkWell(onTap: () => showModalBottomSheet(context: context,
                      isScrollControlled: true, backgroundColor: Colors.transparent,
                      builder: (c) =>  SearchFilterBottomSheet( pagingController: _pagingController,)),
                    child: Stack(children: [
                        Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                            horizontal: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                          child: SizedBox(width: 25,height: 24,child: Image.asset(Images.sort,
                              color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                              Colors.white:Theme.of(context).primaryColor)),),
                      if(searchProductController.isSortingApplied)
                      CircleAvatar(radius: 5, backgroundColor: Theme.of(context).primaryColor,)
                      ],
                    )),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),


                  InkWell(onTap: () => showModalBottomSheet(context: context,
                      isScrollControlled: true, backgroundColor: Colors.transparent,
                      builder: (c) =>   ProductFilterDialog(fromShop: false,pagingController: _pagingController,)),

                    child: Stack(children: [
                        Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                            horizontal: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                          child: SizedBox(width: 25,height: 24, child: Image.asset(Images.dropdown,
                              color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                              Colors.white:Theme.of(context).primaryColor))),
                      if(searchProductController.isFilterApplied)
                        CircleAvatar(radius: 5, backgroundColor: Theme.of(context).primaryColor,)
                      ],
                    ))
                ]
                )
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeSmall),

          Expanded(
            child: PagedMasonryGridView(

                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                shrinkWrap: true,
                gridDelegateBuilder: (childCount) =>   const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                pagingController: _pagingController,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (context) {
                      return const NoInternetOrDataScreenWidget(
                        isNoInternet: false,
                        icon: Images.noOrder,
                        message: 'no_product_found',
                      );
                    },
                    firstPageErrorIndicatorBuilder: (context) {
                      return const NoInternetOrDataScreenWidget(
                        isNoInternet: false,
                        icon: Images.noOrder,
                        message: 'no_product_found',
                      );
                    },
                    newPageErrorIndicatorBuilder: (c) {
                      return const NoInternetOrDataScreenWidget(
                        isNoInternet: false,
                        icon: Images.noOrder,
                        message: 'no_product_found',
                      );
                    },
                    firstPageProgressIndicatorBuilder: (context) {
                      return const ProductShimmer(isEnabled: true, isHomePage: false);
                    },
                    animateTransitions: false,
                    transitionDuration: const Duration(seconds: 1),
                    newPageProgressIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      );
                    },
                    noMoreItemsIndicatorBuilder: (context) {
                      return const SizedBox.shrink();
                    },
                    itemBuilder: (context, item, index) {
                                return ProductWidget(
                                productModel: item as Product);

                    })),
          ),
            // SingleChildScrollView(
            //   controller: scrollController,
            //   child: PaginatedListView(scrollController: scrollController,
            //       onPaginate: (offset) async{
            //     await searchProductController.searchProduct(query: searchProductController.searchController.text, offset: offset!);
            //       },
            //       totalSize:50,
            //       offset: 1,
            //       enabledPagination: true,
            //       itemView: MasonryGridView.count(
            //         physics: const NeverScrollableScrollPhysics(),
            //         padding: const EdgeInsets.all(0),
            //         crossAxisCount: ResponsiveHelper.isTab(context)? 3: 2,
            //         shrinkWrap: true,
            //         itemCount: searchProductController.searchedProduct!.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return ProductWidget(productModel: searchProductController.searchedProduct![index]);},
            //       )),
            // ),
          ],
        );
      }
    );
  }
}
