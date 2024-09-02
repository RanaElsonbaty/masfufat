import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../domain/models/brand_model.dart';

class BrandListWidget extends StatefulWidget {
  final bool isHomePage;
  final ScrollController scrollController;
  const BrandListWidget({super.key, required this.isHomePage, required this.scrollController});

  @override
  State<BrandListWidget> createState() => _BrandListWidgetState();
}

class _BrandListWidgetState extends State<BrandListWidget> {
  ScrollController controller =ScrollController();
  static const _pageSize = 5;
  final PagingController pagingController =
  PagingController(firstPageKey: 1);
  int _page=2;
  int get page =>_page;
  Future<void> fetchPage(int pageKey,) async {
    try {

      final List<BrandModel>  newItems = await Provider.of<BrandController>(Get.context!, listen: false).getBrandList(true,page);
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
    // TODO: implement initState
    super.initState();
    initData();
    // controller.addListener(() { });
  }
  void initData()async{
    // productController= Provider.of<ProductController>(Get.context!, listen: false);
    // await Future.delayed(const Duration(milliseconds: 500));
    //  productController!.refreshPaging();
    //  Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(widget.isBrand, widget.id, context,1,true);
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(page,);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<BrandController>(
      builder: (context, brandProvider, child) {

        return  widget.isHomePage?
            SizedBox(
              height: 100,
              child: PagedListView(
                  pagingController: pagingController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                   physics: const AlwaysScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate(itemBuilder: (context, item, index) {
                    BrandModel brand =item as BrandModel;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(splashColor: Colors.transparent, highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                                        isBrand: true,
                                        index: index,
                                        id:  brand.id.toString(),
                                        name:brand.name,
                                        image: brand.image)));
                                  },
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Container(width: ResponsiveHelper.isTab(context)? 120 :60, height: ResponsiveHelper.isTab(context)? 120 :60,
                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          color: Theme.of(context).highlightColor,
                                          boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme ?
                                          null :[BoxShadow(color: Colors.grey.withOpacity(0.12), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))]),
                                      child: Consumer<SplashController>(
                                        builder:(context, splashProvider, child) =>  ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            child: CustomImageWidget(image: '${splashProvider.baseUrls?.brandImageUrl}/${brand.image}',fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ],
                                  ),
                                              ),
                    );
                  },)),
            ):
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   physics: const AlwaysScrollableScrollPhysics(),
        //   controller: widget.scrollController,
        //   child: PaginatedListView(
        //     scrollController: widget.scrollController,
        //     onPaginate: (int? offset) async => brandProvider.getBrandList(false,offset!),
        //     totalSize: 30,
        //     offset: 1,
        //   // onEndOfPage: () =>
        //     itemView: SizedBox(
        //       height: 100,
        //
        //       child: ListView.builder(
        //         itemCount: brandProvider.brandList.length,
        //         scrollDirection: Axis.horizontal,
        //         shrinkWrap: true,
        //         controller: widget.scrollController,
        //         physics: const  NeverScrollableScrollPhysics(),
        //         itemBuilder: (context, index) => InkWell(splashColor: Colors.transparent, highlightColor: Colors.transparent,
        //         onTap: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
        //               isBrand: true,
        //               id: brandProvider.brandList[index].id.toString(),
        //               name: brandProvider.brandList[index].name,
        //               image: brandProvider.brandList[index].image)));
        //         },
        //         child: Padding(padding: EdgeInsets.only(left : Provider.of<LocalizationController>(context, listen: false).isLtr ?
        //         Dimensions.paddingSizeDefault : 0,
        //             right: brandProvider.brandList.length == brandProvider.brandList.indexOf(brandProvider.brandList[index]) + 1? Dimensions.paddingSizeDefault :
        //             Provider.of<LocalizationController>(context, listen: false).isLtr ? 0 : Dimensions.paddingSizeDefault),
        //           child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        //             Container(width: ResponsiveHelper.isTab(context)? 120 :60, height: ResponsiveHelper.isTab(context)? 120 :60,
        //               decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)),
        //                   color: Theme.of(context).highlightColor,
        //                   boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme ?
        //                   null :[BoxShadow(color: Colors.grey.withOpacity(0.12), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))]),
        //               child: Consumer<SplashController>(
        //                 builder:(context, splashProvider, child) =>  ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(5)),
        //                     child: CustomImageWidget(image: '${splashProvider.baseUrls?.brandImageUrl!}/${brandProvider.brandList[index].image}',fit: BoxFit.fill)),
        //               ),
        //             ),
        //           ],
        //           ),
        //         ),
        //                     ),),
        //     ),
        //   ),
        // ) :
        PagedGridView(
            pagingController: pagingController,
            shrinkWrap: true,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: (1/1.3),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5),
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate(itemBuilder: (context,  item, index) {
              BrandModel brand =item as BrandModel;
              return InkWell(splashColor: Colors.transparent, highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                      isBrand: true,
                      id: brand.id.toString() ,
                      index: index,
                      name: brand.name,
                      image: brand.image)));
                },
                child: Padding(padding: const EdgeInsets.only(left : 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Container(width: ResponsiveHelper.isTab(context)? 120 :60, height: ResponsiveHelper.isTab(context)? 120 :60,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)),
                          color: Theme.of(context).highlightColor,
                          boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme ?
                          null :[BoxShadow(color: Colors.grey.withOpacity(0.12), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))]),
                      child: Consumer<SplashController>(
                        builder:(context, splashProvider, child) =>  ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: CustomImageWidget(image: '${splashProvider.baseUrls?.brandImageUrl}/${brand.image}',fit: BoxFit.fill)),
                      ),
                    ),
                  ],
                  ),
                ),
              );
            },));
        // SingleChildScrollView(
        //   controller: controller,
        //   physics: AlwaysScrollableScrollPhysics(),
        //   child: PaginatedListView(
        //     enabledPagination: true,
        //     scrollController: controller,
        //     onPaginate:  (offset) async =>  await brandProvider.getBrandList(false,offset!),
        //
        //     totalSize: 10,
        //     offset: 1,
        //     itemView: GridView.builder(
        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 4,
        //           childAspectRatio: (1/1.3),
        //           mainAxisSpacing: 10,
        //           crossAxisSpacing: 5),
        //       padding: EdgeInsets.zero,
        //       itemCount:  brandProvider.brandList.length,
        //       shrinkWrap: true,
        //       physics: const NeverScrollableScrollPhysics(),
        //       itemBuilder: (BuildContext context, int index) {
        //
        //         return InkWell(
        //           onTap: () {
        //             Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
        //                 isBrand: true,
        //                 id: brandProvider.brandList[index].id.toString(),
        //                 name: brandProvider.brandList[index].name,
        //                 image: brandProvider.brandList[index].image)));
        //           },
        //           child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        //             Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        //               child: Container(decoration: BoxDecoration(color: Theme.of(context).cardColor,
        //                   borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        //                 child: Consumer<SplashController>(builder:   (context, splashProvider, child) =>   CustomImageWidget(image:'${splashProvider.baseUrls?.brandImageUrl!}/${brandProvider.brandList[index].image}',fit: BoxFit.fill,)),),)),
        //
        //             SizedBox(height: (MediaQuery.of(context).size.width/4) * 0.3,
        //                 child: Center(child: Text(brandProvider.brandList[index].name, maxLines: 1, overflow: TextOverflow.ellipsis,
        //                     textAlign: TextAlign.center, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))),
        //           ],
        //           ),
        //         );
        //
        //       },
        //     ),
        //   ),
        // )
        //     : BrandShimmerWidget(isHomePage: widget.isHomePage);

      },
    );
  }
}


