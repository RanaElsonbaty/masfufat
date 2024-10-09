import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../domain/models/brand_model.dart';

class BrandListWidget extends StatefulWidget {
  final bool isHomePage;
  final ScrollController scrollController;
  final Function? selectBrand;
  final int? selectId;

  const BrandListWidget({super.key, required this.isHomePage, required this.scrollController, this.selectBrand, this.selectId});

  @override
  State<BrandListWidget> createState() => _BrandListWidgetState();
}

class _BrandListWidgetState extends State<BrandListWidget> {
  ScrollController controller =ScrollController();
  static const _pageSize = 5;
  final PagingController<int,BrandModel> pagingController =
  PagingController(firstPageKey: 1);
  int _page=1;
  int get page =>_page;
  List<BrandModel> brandList=[];
  List<BrandModel> searchBrandList=[];

  Future<void> fetchPage(int pageKey,) async {
    try {

      final List<BrandModel>  newItems = await Provider.of<BrandController>(Get.context!, listen: false).getBrandList(true,page);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
// setState(() {
//   brandList.addAll(newItems);
//   searchBrandList.addAll(newItems);
//
// });
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
        // setState(() {
          // brandList.addAll(newItems);
          // searchBrandList.addAll(newItems);
        // });
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
    brandList=[];
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
  TextEditingController textController=TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {

    return Consumer<BrandController>(
      builder: (context, brandProvider, child) {

        return  widget.isHomePage?
            SizedBox(
              height: 100,
              child: PagedListView<int ,BrandModel>(
                  pagingController: pagingController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                   physics: const AlwaysScrollableScrollPhysics(),

                  builderDelegate: PagedChildBuilderDelegate(
                    newPageErrorIndicatorBuilder: (context) {
                      return SizedBox();
                    },
                    firstPageErrorIndicatorBuilder:  (context) {
                      return SizedBox();
                    },
                    itemBuilder: (context, item, index) {
                    // BrandModel brand =item;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(splashColor: Colors.transparent, highlightColor: Colors.transparent,
                                  onTap:widget.selectBrand!=null?(){
                        widget.selectBrand!(item);
                                  }: () {
                        
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                                        isBrand: true,
                                        index: index,
                                        id:  item.id.toString(),
                                        name:item.name,
                                        image: item.image)));
                                  },
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Container(width: ResponsiveHelper.isTab(context)? 120 :60, height: ResponsiveHelper.isTab(context)? 120 :60,
                                      decoration: BoxDecoration(borderRadius:  BorderRadius.circular(100),
                                          color: Theme.of(context).highlightColor,
                                          border: widget.selectBrand!=null&&widget.selectId!=null&&widget.selectId==item.id?Border.all(width: 2,color: Theme.of(context).primaryColor):Border.all(width: 0,color: Colors.transparent),

                                          boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme ?
                                          null :[BoxShadow(color: Colors.grey.withOpacity(0.12), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))]
                                        ),
                                      child: Consumer<SplashController>(
                                        builder:(context, splashProvider, child) =>  ClipRRect(borderRadius:  BorderRadius.circular(100),
                                            child: CustomImageWidget(image: '${splashProvider.baseUrls?.brandImageUrl}/${item.image}',fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ],
                                  ),
                                              ),
                    );
                  },)),
            ):

        SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0),
                child: CustomTextFieldWidget(
                  controller: textController,
                  hintText: getTranslated('search', context),
                  labelText: getTranslated('search', context),
                  showLabelText: false,
                  prefixIcon: Images.searchIcon,
                  onChanged: (text) {
                    pagingController.itemList!.sort((a, b) {
                      if (a.name.contains(text) && !b.name.contains(text)) {
                        return -1; // a matches, b doesn't
                      } else if (!a.name.contains(text) && b.name.contains(text)) {
                        return 1; // b matches, a doesn't
                      } else  if (a.name.contains(text) && b.name.contains(text)) {
                        return 0; // no match or both match
                      }else {
                        return -1;
                      }
                    });
                    setState(() {

                    });
//
                  },

                ),
              ),
              PagedGridView<int ,BrandModel>(
                  pagingController: pagingController,
                  shrinkWrap: true,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                  scrollDirection: Axis.vertical,
                  scrollController: controller,

                  physics: const NeverScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate(itemBuilder: (context,  item, index) {
                    BrandModel brand =
                    item;
                      return InkWell(splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) =>
                              BrandAndCategoryProductScreen(
                                  isBrand: true,
                                  id: brand.id.toString(),
                                  index: index,
                                  name: brand.name,
                                  image: brand.image)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme
                                  .of(context)
                                  .primaryColor
                                  .withOpacity(0.20)
                          ),
                          child: Center(
                            child: Container(
                              width: ResponsiveHelper.isTab(context) ? 120 : 80,
                              height: ResponsiveHelper.isTab(context)
                                  ? 120
                                  : 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1, color: Colors.grey)
                              ),
                              // decoration: BoxDecoration(borderRadius:  BorderRadius.circular(50),
                              // color: Theme.of(context).highlightColor,
                              // boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme ?
                              // null :[BoxShadow(color: Colors.grey.withOpacity(0.12), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))]),
                              child: Consumer<SplashController>(
                                builder: (context, splashProvider, child) =>
                                    ClipOval(
                                    // backgroundColor: Colors.white,

                                        child: CustomImageWidget(
                                          image: '${splashProvider.baseUrls
                                              ?.brandImageUrl}/${brand
                                              .image}', fit: BoxFit.fill,)),
                              ),
                            ),
                          ),
                        ),
                      );
                    // }else {
                    //   return SizedBox();
                    // }
                  },)),
            ],
          ),
        );
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


