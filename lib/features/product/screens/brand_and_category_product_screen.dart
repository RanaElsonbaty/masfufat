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

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../localization/language_constrants.dart';
import '../../../theme/controllers/theme_controller.dart';
import '../../../utill/custom_themes.dart';
import '../../search_product/controllers/search_product_controller.dart';
import '../../search_product/widgets/search_filter_bottom_sheet_widget.dart';

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
      final List<Product>  newItems = await Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(
          isBrand,id,context,pageKey,true
      ,searchController.text,Provider.of<SearchProductController>(context, listen: false).syncSortText,
          Provider.of<SearchProductController>(context, listen: false).sortText,
          '&from_price=${ Provider.of<SearchProductController>(context, listen: false).minFilterValue.toString()}&to_price=${Provider.of<SearchProductController>(context, listen: false).maxFilterValue.toString()}'
      //       sort: Provider.of<SearchProductController>(context, listen: false).sortText,
        //         syncFilter:Provider.of<SearchProductController>(context, listen: false).syncSortText
      );
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
    focusNode.addListener(() { });
    initData();


  }
  void initData()async{
   pagingController.addPageRequestListener((pageKey) {
      fetchPage(page,widget.isBrand, widget.id, Get.context!,true);
    });
  }
  TextEditingController searchController =TextEditingController();
  FocusNode focusNode =FocusNode();

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                  child: SizedBox(
                    height: 55,

                    child: Hero(
                      tag: 'search',
                      child: Material(child: TextFormField(
                        controller: searchController,
                        // focusNode: searchProvider.searchFocusNode,
                        textInputAction: TextInputAction.search,
                        onChanged: (val){
                          // if(val.isNotEmpty){
pagingController.refresh();
                          // }
                        },
                        onFieldSubmitted: (value) {
                        },

                        style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                borderSide: BorderSide(color: Colors.grey[300]!)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                borderSide: BorderSide(color: Colors.grey[300]!)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                borderSide: BorderSide(color: Colors.grey[300]!)),
                            hintText: getTranslated('search_product', context),
                            suffixIcon: SizedBox(width:   focusNode.hasFocus?50: 110,
                              child: Row(children: [
                                focusNode.hasFocus?const SizedBox.shrink():  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      InkWell(onTap: () => showModalBottomSheet(context: context,
                                          isScrollControlled: true, backgroundColor: Colors.transparent,
                                          builder: (c) =>  SearchFilterBottomSheet( pagingController: pagingController,)),
                                          child: Stack(children: [
                                            Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                                                horizontal: Dimensions.paddingSizeExtraSmall),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                                              child: SizedBox(width: 25,height: 24,child: Image.asset(Images.sort,
                                                  color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                                  Colors.white:Theme.of(context).primaryColor)),),])),
                                    ],
                                  ),
                                ),
                                InkWell(onTap: (){
                                  if(searchController.text.trim().isNotEmpty) {
                                    focusNode.unfocus();
                                    try{
                                     pagingController.refresh();

                                    } catch(e){}
                                  }else{
                                    showCustomSnackBar(getTranslated('enter_somethings', context), context);
                                  }
                                },
                                  child: Padding(padding: const EdgeInsets.all(5),
                                    child: Container(width: 40, height: 50,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                                        child: SizedBox(width : 18,height: 18, child: Padding(
                                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                          child: Image.asset(Images.search, color: Colors.white),
                                        ))),
                                  ),
                                ),
                              ],
                              ),
                            )
                        ),
                      ),
                      ),
                    ),
                  ),
                ),

                Expanded(
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
              ],
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