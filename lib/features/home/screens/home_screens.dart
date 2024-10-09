import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/controllers/banner_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banners_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/single_banner_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/widgets/category_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/controllers/featured_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/controllers/flash_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/screens/featured_deal_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/screens/flash_deal_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/widgets/featured_deal_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/widgets/flash_deals_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/flash_deal_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/announcement_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/featured_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/search_home_page_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/screens/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/home_category_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/recommended_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/screens/search_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/all_shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/top_seller_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../../brand/screens/brands_screen.dart';
import '../../brand/widgets/brand_list_widget.dart';
import '../../cart/screens/cart_screen.dart';
import '../../payment /controller/payment_controller.dart';
import '../../product/widgets/latest_product_list_widget.dart';
import '../../wishlist/screens/wishlist_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();



}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
 final ScrollController controller =ScrollController();
  static Future<void> loadData(bool reload) async {
    await Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload,'main_banner');
    await   Provider.of<CategoryController>(Get.context!, listen: false).getCategoryList(reload);
    await Provider.of<FlashDealController>(Get.context!, listen: false).getFlashDealList(reload, false);
    await Provider.of<ProductController>(Get.context!, listen: false).getFeaturedProductList('1', reload: reload);
    await Provider.of<FeaturedDealController>(Get.context!, listen: false).getFeaturedDealList(reload);
    await Provider.of<ShopController>(Get.context!, listen: false).getTopSellerList(reload, 1, type: "top");
    await Provider.of<ProductController>(Get.context!, listen: false).getRecommendedProduct();
    Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload,'main_section_banner');
    Provider.of<ProductController>(Get.context!, listen: false).getHomeCategoryProductList(reload);
    Provider.of<AddressController>(Get.context!, listen: false).getAddressList();
    await Provider.of<CartController>(Get.context!, listen: false).getCartData(Get.context!);
    await Provider.of<ProductController>(Get.context!, listen: false).getLatestProductList(1, reload: reload);

    // await Provider.of<ProductController>(Get.context!, listen: false).getLProductList('1', reload: reload);
    await Provider.of<NotificationController>(Get.context!, listen: false).getNotificationList(1);
    if(Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()){
      await  Provider.of<ProfileController>(Get.context!, listen: false).getUserInfo(Get.context!);
    }
    Provider.of<PaymentController>(Get.context!,listen: false).getIsLoading(true,false);
    await   Provider.of<PaymentController>(Get.context!,listen: false).getAmount(( 0));
    await  Provider.of<PaymentController>(Get.context!,listen: false).getApiKey(Get.context!);
    await Provider.of<PaymentController>(Get.context!,listen: false).initiate(Get.context!);
    await Provider.of<PaymentController>(Get.context!,listen: false).getPaymentMethod(Get.context!,'cart');
    Provider.of<PaymentController>(Get.context!,listen: false).cardViewStyle();
    Provider.of<PaymentController>(Get.context!,listen: false).getIsLoading(false,true);
  }


  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    if(Provider.of<SplashController>(context, listen: false).configModel!=null){
      singleVendor = Provider.of<SplashController>(context, listen: false).configModel!.showSellersSection == 1;

    }else{
      Provider.of<SplashController>(context, listen: false).initConfig(context);
    }

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(resizeToAvoidBottomInset: false,
      body: SafeArea(child: RefreshIndicator(
        onRefresh: () async {
          await loadData( true);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController, slivers: [
          SliverAppBar(
            floating: true,
            elevation: 5,
            pinned: false,
            centerTitle: false,
            automaticallyImplyLeading: false,
surfaceTintColor: Theme.of(context).highlightColor,
            backgroundColor: Theme.of(context).highlightColor,
            title: Consumer<ProfileController>(
              builder:(context, profile, child) =>  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<ThemeController>(builder:(context, value, child) =>  Image.asset(value.darkTheme?Images.whiteLogoWithMame:Images.logoWithNameImage,width:value.darkTheme? 120:150,))
                // Container(
                //   height: 50,
                //   width: 50,
                //   decoration:  BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.black,
                //     border: Border.all(width: 1,color: Colors.grey)
                //   ),
                //   child: ClipRRect(
                //       borderRadius: BorderRadius.circular(50),
                //       child: CustomImageWidget(image: profile.userInfoModel!=null?profile.userInfoModel!.image:'')),
                // ),
                //   const SizedBox(width: 5,),
                //   Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(profile.userInfoModel!=null?profile.userInfoModel!.name:"",
                //         overflow: TextOverflow.ellipsis,
                //         style: GoogleFonts.tajawal(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700
                //
                //       ),),Text(profile.userInfoModel!=null?profile.userInfoModel!.id.toString():"",style: GoogleFonts.tajawal(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700
                //
                //       ),),
                //     ],
                //   )
              ],),
            ),

            actions: [

              SizedBox(
                height: 50,
                width: 35,
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    InkWell(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) =>
                        const WishListScreen()
                        )),
                        child:Image.asset(Images.wishlist,width: 25, height: 25,
                          color: Theme.of(context).primaryColor,)),
                    Positioned(
                      top: 5,
                      left: 15  ,
                      child: Consumer<WishListController>(builder:(context, provider, child) {
                        return provider.wishList!=null&&provider.wishList!.isNotEmpty? CircleAvatar(radius:provider.wishList!.length<100? 9:10,backgroundColor: Colors.red,child:
                        Center(
                          child: Text(provider.wishList!.isNotEmpty?provider.wishList!.length.toString():'0',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                                color: Colors.white
                            ),

                          ),
                        ),):const SizedBox();
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5,),
              SizedBox(
                height: 50,
                width: 35,
                // width: 69,

                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    InkWell(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
                        child:Image.asset(Images.notification2,width: 30, height: 30,
                          color: Theme.of(context).primaryColor,)),
                    Positioned(
                      top: 5,
                      left: 15  ,
                      child: Consumer<NotificationController>(builder:(context, provider, child) {
                        return provider.notificationModel.isNotEmpty? CircleAvatar(radius:provider.notificationModel.length<100? 8:10,backgroundColor: Colors.red,child:
                        Center(
                          child: Text(provider.notificationModel.isNotEmpty?provider.notificationModel.length.toString():'0',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                                color: Colors.white
                            ),

                          ),
                        ),):const SizedBox.square();
                      }),
                    ),
                  ],
                ),
              ),  const SizedBox(width: 5,),
              SizedBox(
                height: 50,
                width: 35,
                // width: 69,

                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    InkWell(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen(showBackButton: true,))),
                        child:Image.asset(Images.cartIcon,width: 30, height: 30,
                          color: Theme.of(context).primaryColor,)),
                    Positioned(
                      top: 5,
                      left: 15  ,
                      child: Consumer<CartController>(builder:(context, provider, child) {
                        return provider.cartList.isNotEmpty? CircleAvatar(radius:provider.cartList.length<100? 8:10,backgroundColor: Colors.red,child:
                        Center(
                          child: Text(provider.cartList.isNotEmpty?provider.cartList.length.toString():'0',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 9,
                                color: Colors.white
                            ),

                          ),
                        ),):const SizedBox.square();
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10,),



            ],
          ),

          SliverToBoxAdapter(child:Provider.of<SplashController>(context, listen: false).configModel!=null&&Provider.of<SplashController>(context, listen: false).configModel!.announcement.status !=null&& Provider.of<SplashController>(context, listen: false).configModel!.announcement.status == '1'?
          Consumer<SplashController>(
              builder: (context, announcement, _){
                return (announcement.onOff)?
                AnnouncementWidget(announcement: announcement.configModel!.announcement):const SizedBox();
              }):const SizedBox(),),

          SliverPersistentHeader(pinned: true, delegate: SliverDelegate(
            child: InkWell(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
              child: const Hero(tag: 'search', child: Material(child: SearchHomePageWidget())),
            ),
          )),

          SliverToBoxAdapter(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Consumer<BannerController>(builder:(context, banner, child) =>   BannersWidget(mainBannerList: banner.mainBannerList!=null?banner.mainBannerList!:[],)),
              const SizedBox(height: Dimensions.paddingSizeDefault),



              const CategoryListWidget(isHomePage: true),
              const SizedBox(height: Dimensions.paddingSizeDefault),


              Consumer<FlashDealController>(builder: (context, megaDeal, child) {
                return  megaDeal.flashDeal == null &&megaDeal.flashDealList.isNotEmpty? const FlashDealShimmer(
                ) : megaDeal.flashDealList.isNotEmpty ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: TitleRowWidget(
                      title: getTranslated('flash_deal', context)?.toUpperCase(),
                      eventDuration: megaDeal.flashDeal != null ? megaDeal.duration : null,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashDealScreenView()));
                      },
                      isFlash: true,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Text(getTranslated('hurry_up_the_offer_is_limited_grab_while_it_lasts', context)??'',
                      style: textRegular.copyWith(color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                      Theme.of(context).hintColor : Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault)),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  const FlashDealsListWidget()]) : const SizedBox.shrink();
              }),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),


              Consumer<FeaturedDealController>(
                builder: (context, featuredDealProvider, child) {
                  return  featuredDealProvider.featuredDealProductList != null? featuredDealProvider.featuredDealProductList!.isNotEmpty ?
                  Column(
                    children: [
                      Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                        ),

                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                            child: TitleRowWidget(
                              title: '${getTranslated('featured_deals', context)}',
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturedDealScreenView())),
                            ),
                          ), const FeaturedDealsListWidget(),
                        ]),
                      ]),

                      const SizedBox(height: Dimensions.paddingSizeDefault),
                    ],
                  ) : const SizedBox.shrink() : const FindWhatYouNeedShimmer();}),






              Consumer<BannerController>(builder: (context, footerBannerProvider, child){
                return footerBannerProvider.footerBannerList != null&&footerBannerProvider.footerBannerList!.isNotEmpty ?
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: SingleBannersWidget( bannerModel : footerBannerProvider.footerBannerList!.first,noRadius: false,)):
                const SizedBox();
              }),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              //
              //
              const FeaturedProductWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault),


              // seller view
              singleVendor?
              Consumer<ShopController>(
                  builder: (context, topSellerProvider, child) {
                    return (topSellerProvider.sellerModel != null && (topSellerProvider.sellerModel!=null && topSellerProvider.sellerModel!.isNotEmpty))?
                    TitleRowWidget(title: getTranslated('top_seller', context),
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) =>
                        const AllTopSellerScreen( title: 'top_stores',)))):
                    const SizedBox();
                  }):const SizedBox(),
              singleVendor?const SizedBox(height: Dimensions.paddingSizeSmall):const SizedBox(height: 0),

              singleVendor?
              Consumer<ShopController>(
                  builder: (context, topSellerProvider, child) {
                    return (topSellerProvider.sellerModel != null && (topSellerProvider.sellerModel!=null && topSellerProvider.sellerModel!.isNotEmpty))?
                    Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                        child: SizedBox(height:  230, child: TopSellerView(isHomePage: true, scrollController: _scrollController,))):const SizedBox();}):const SizedBox(),



              const Padding(padding: EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: RecommendedProductWidget()),



              const Padding(padding: EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: LatestProductListWidget()),
              const HomeCategoryProductWidget(isHomePage: true),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              TitleRowWidget(
                title: getTranslated('brand', context),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrandsView())),
              ),
              const SizedBox(height:  Dimensions.paddingSizeSmall),
              BrandListWidget(isHomePage: true,scrollController: controller,),
              // const SizedBox(height: Dimensions.paddingSizeDefault),

              //
            //   const FooterBannerSliderWidget(),
            //   const SizedBox(height: Dimensions.paddingSizeDefault),



              // Consumer<ProductController>(
              //     builder: (ctx,prodProvider,child) {
              //
              //       return Container(decoration: BoxDecoration(
              //           color: Theme.of(context).colorScheme.onSecondaryContainer),
              //           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //             Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeSmall, 0),
              //                 child: Row(children: [
              //                   Expanded(child: Text(prodProvider.title == 'xyz' ? getTranslated('new_arrival',context)!:
              //                   prodProvider.title!, style: titleHeader)),
              //                   prodProvider.latestProductList != null ?
              //                   PopupMenuButton(
              //                     padding: const EdgeInsets.all(0),
              //                     itemBuilder: (context) {
              //                       return [
              //
              //                         PopupMenuItem(
              //                           value: ProductType.newArrival,
              //                           child: Text(getTranslated('new_arrival',context)??'', style: textRegular.copyWith(
              //                             color: prodProvider.productType == ProductType.newArrival ? Theme.of(context).primaryColor :  Theme.of(context).textTheme.bodyLarge?.color,
              //                           )),
              //                         ),
              //
              //                         PopupMenuItem(
              //                           value: ProductType.topProduct,
              //                           child: Text(getTranslated('top_product',context)??'', style: textRegular.copyWith(
              //                             color: prodProvider.productType == ProductType.topProduct ? Theme.of(context).primaryColor :  Theme.of(context).textTheme.bodyLarge?.color,
              //                           )),
              //                         ),
              //
              //                         PopupMenuItem(
              //                           value: ProductType.bestSelling,
              //                           child: Text(getTranslated('best_selling',context)??'', style: textRegular.copyWith(
              //                             color: prodProvider.productType == ProductType.bestSelling ? Theme.of(context).primaryColor :  Theme.of(context).textTheme.bodyLarge?.color,
              //                           )),
              //                         ),
              //
              //                         PopupMenuItem(
              //                           value: ProductType.discountedProduct,
              //                           child: Text(getTranslated('discounted_product',context)??'',  style: textRegular.copyWith(
              //                             color: prodProvider.productType == ProductType.discountedProduct ? Theme.of(context).primaryColor :  Theme.of(context).textTheme.bodyLarge?.color,
              //                           )),
              //                         ),
              //                       ];
              //                     },
              //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
              //                     child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall,
              //                         Dimensions.paddingSizeSmall,
              //                         Dimensions.paddingSizeExtraSmall,Dimensions.paddingSizeSmall ),
              //                         child: Image.asset(Images.dropdown, scale: 3)),
              //                     onSelected: (ProductType value) {
              //                       if(value == ProductType.newArrival){
              //                         Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[0]);
              //                       }else if(value == ProductType.topProduct){
              //                         Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[1]);
              //                       }else if(value == ProductType.bestSelling){
              //                         Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[2]);
              //                       }else if(value == ProductType.discountedProduct){
              //                         Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[3]);
              //                       }
              //                       Provider.of<ProductController>(context, listen: false).getLatestProductList(1, reload: true);
              //                     },
              //                   ) : const SizedBox()])),
              //
              //             Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              //               child: ProductListWidget(isHomePage: false, productType: ProductType.newArrival,
              //                   scrollController: _scrollController),),
              //             const SizedBox(height: Dimensions.homePagePadding)]));}),
            ],
            ),
          )
        ],
        ),
      ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

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
