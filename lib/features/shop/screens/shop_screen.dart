import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_filter_dialog_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/search_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/overview_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/shop_info_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/shop_product_view_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_image_widget.dart';
import '../../../common/basewidget/product_shimmer_widget.dart';
import '../../../common/basewidget/product_widget.dart';
import '../../product/domain/models/product_model.dart';

class TopSellerProductScreen extends StatefulWidget {
  final int? sellerId;
  final bool? temporaryClose;
  final bool? vacationStatus;
  final String? vacationEndDate;
  final String? vacationStartDate;
  final String? name;
  final String? banner;
  final String? image;
  final bool fromMore;
  const TopSellerProductScreen({super.key, this.sellerId, this.temporaryClose, this.vacationStatus, this.vacationEndDate,
    this.vacationStartDate, this.name, this.banner, this.image, this.fromMore = false});

  @override
  State<TopSellerProductScreen> createState() => _TopSellerProductScreenState();
}

class _TopSellerProductScreenState extends State<TopSellerProductScreen> with TickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool vacationIsOn = false;
  TabController? _tabController;
  int selectedIndex = 0;

  void _load() async{
    // await Provider.of<SellerProductController>(context, listen: false).getSellerProductList(widget.sellerId.toString(), 1, "");
    await Provider.of<ShopController>(Get.context!, listen: false).getSellerInfo(widget.sellerId.toString());
    // await Provider.of<SellerProductController>(Get.c/ontext!, listen: false).getSellerWiseBestSellingProductList(widget.sellerId.toString(), 1);
    // await Provider.of<SellerProductController>(Get.context!, listen: false).getSellerWiseFeaturedProductList(widget.sellerId.toString(), 1);
    // await Provider.of<SellerProductController>(Get.context!, listen: false).getSellerWiseRecommandedProductList(widget.sellerId.toString(), 1);
    // await Provider.of<CouponController>(Get.context!, listen: false).getSellerWiseCouponList(widget.sellerId!, 1);
    // await Provider.of<CategoryController>(Get.context!, listen: false).getSellerWiseCategoryList(widget.sellerId!);
    scrollController.addListener(_scrollListener);
    fetchPage(1);
    // await Provider.of<BrandController>(Get.context!, listen: false).getSellerWiseBrandList(widget.sellerId!);
  }
  ScrollController scrollController = ScrollController();

  bool loading = false;
  bool lastPage = false;
  void _scrollListener() async {
    if (lastPage == false) {
      if (loading == true) {
        return; // Prevent redundant fetches while loading
      }

      final double maxScrollExtent = scrollController.position.maxScrollExtent;
      final double currentScrollPosition = scrollController.position.pixels;

      // Check if scroll position is near the end (adjustable threshold)
      if (currentScrollPosition >= maxScrollExtent - 1000.0) {
        setState(() {
          loading = true;
        });

        await fetchPage(_page).then((value) {
          setState(() {
            loading = false;
            _page = _page + 1;
          });
        });
      }
    } else {}
  }
  static const _pageSize = 50;
  final PagingController pagingController =
  PagingController(firstPageKey: 1);
  int _page=1;
  int get page =>_page;
  bool firstTime=true;
  Future<void> fetchPage(int pageKey) async {
    try {
      firstTime=true;
      // await Provider.of<SellerProductController>(context, listen: false).getSellerProductList(widget.sellerId.toString(), 1, "");
      //
      final List<Product>  newItems = await Provider.of<SellerProductController>(context, listen: false).getSellerProductList(widget.sellerId.toString(), page, "");
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
        lastPage=true;
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
    firstTime=false;

  }
  @override
  void initState() {
    super.initState();

    searchController.clear();
    _load();

  }

  @override
  Widget build(BuildContext context) {
    if (widget.vacationEndDate != null) {
      DateTime vacationDate = DateTime.parse(widget.vacationEndDate!);
      DateTime vacationStartDate = DateTime.parse(widget.vacationStartDate!);
      final today = DateTime.now();
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if (difference >= 0 && widget.vacationStatus! && startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        Provider.of<SellerProductController>(context, listen: false).clearSellerProducts();
        Provider.of<CategoryController>(Get.context!, listen: false).emptyCategory();
        Provider.of<CategoryController>(Get.context!, listen: false).getCategoryList(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: CustomAppBar(title: widget.name),
        body: Consumer<ShopController>(
          builder: (context, sellerProvider, _) {
            return CustomScrollView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 310.0,
              snap: false,
              pinned: true,
              floating: false,
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomImageWidget(
                      image:
                      '${Provider.of<SplashController>(context, listen: false).baseUrls!.shopImageUrl}/${widget.image!}',
                      height: 50,
                      width: 50,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.name!,
                    style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
                // child:
              ),
              // c
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Theme.of(context).iconTheme.color,
                  )),
              // actions: [Text('data')],

              backgroundColor: Theme.of(context).cardColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(''),
                // centerTitle: ,
                background: Consumer<SplashController>(
                  builder:(context, splash, child) =>  Column(
                    children: [
                      SizedBox(height: 120,),
                      ShopInfoWidget(
                          vacationIsOn: vacationIsOn,
                          sellerName: widget.name ?? "",
                          sellerId: widget.sellerId!,
                          banner: widget.banner ?? '',
                          shopImage: widget.image ?? '',
                          temporaryClose: widget.temporaryClose!),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            InkWell(onTap: () => showModalBottomSheet(context: context,
                                isScrollControlled: true, backgroundColor: Colors.transparent,
                                builder: (c) =>  ProductFilterDialog(sellerId: widget.sellerId!)),

                                child: Container(decoration: BoxDecoration(
                                    color: Provider.of<ThemeController>(context, listen: false).darkTheme? Colors.white: Theme.of(context).cardColor,
                                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                                    width: 30,height: 30,
                                    child: Padding(padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(Images.filterImage)))),
                          ],
                        ),
                      ),


                      // if(sellerProvider.shopMenuIndex == 1)
                      Container(color: Theme.of(context).canvasColor,
                          child: SearchWidget(hintText: '${getTranslated('search_hint', context)}', sellerId: widget.sellerId!)),
                    ],
                  ),
                ),
              ),
            ),


          pagingController.itemList != null&&  pagingController.itemList!.isNotEmpty?  SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3,
                  mainAxisExtent: 330),
                  delegate:SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductWidget(productModel:  pagingController.itemList![index] as Product);;
                    },
                      childCount: pagingController.itemList!.length
                  )

            ): SliverToBoxAdapter(
            child:   firstTime? const ProductShimmer(isHomePage: false,
                isEnabled: true):const NoInternetOrDataScreenWidget(isNoInternet: false),),
             if(loading==true)
              SliverToBoxAdapter(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 CircularProgressIndicator(color: Theme.of(context).primaryColor,),
               ],
             ))


          ],
            );
            // return CustomScrollView(
            //   shrinkWrap: true,
            //
            //   physics: const NeverScrollableScrollPhysics(),
            //    slivers: [
            //
            // ]);
          }
        )

      ),
    );
  }

}
class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 120  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}

// SliverToBoxAdapter(
//
//
//                   child: ShopInfoWidget(
//                     vacationIsOn: vacationIsOn,
//                     sellerName: widget.name ?? "",
//                     sellerId: widget.sellerId!,
//                     banner: widget.banner ?? '',
//                     shopImage: widget.image ?? '',
//                     temporaryClose: widget.temporaryClose!)),
//               SliverPersistentHeader(pinned: true,
//                   delegate: SliverDelegate(
//                       height:  100,
//
//                       child: Container(color: Theme.of(context).canvasColor,
//                         child: Column(children: [
//                           // if(sellerProvider.shopMenuIndex == 1)
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Row(
//                                 children: [
//                                   InkWell(onTap: () => showModalBottomSheet(context: context,
//                                       isScrollControlled: true, backgroundColor: Colors.transparent,
//                                       builder: (c) =>  ProductFilterDialog(sellerId: widget.sellerId!)),
//
//                                     child: Container(decoration: BoxDecoration(
//                                         color: Provider.of<ThemeController>(context, listen: false).darkTheme? Colors.white: Theme.of(context).cardColor,
//                                         border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
//                                         borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
//                                         width: 30,height: 30,
//                                         child: Padding(padding: const EdgeInsets.all(5.0),
//                                             child: Image.asset(Images.filterImage)))),
//                                 ],
//                               ),
//                             ),
//
//
//                           // if(sellerProvider.shopMenuIndex == 1)
//                             Container(color: Theme.of(context).canvasColor,
//                               child: SearchWidget(hintText: '${getTranslated('search_hint', context)}', sellerId: widget.sellerId!))
//                         ])))),
//
//               SliverToBoxAdapter(
//
//                   child:
//
//                 Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,0),
//                   child: ShopProductViewList(scrollController: _scrollController, sellerId: widget.sellerId!))),