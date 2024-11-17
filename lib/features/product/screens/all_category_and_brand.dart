import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_image_widget.dart';
import '../../../common/basewidget/no_internet_screen_widget.dart';
import '../../../common/basewidget/product_shimmer_widget.dart';
import '../../../common/basewidget/product_widget.dart';
import '../../../main.dart';
import '../../../theme/controllers/theme_controller.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../Store settings/controllers/store_setting_controller.dart';
import '../../brand/domain/models/brand_model.dart';
import '../../brand/widgets/brand_list_widget.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/screens/cart_screen.dart';
import '../../my shop/controllers/my_shop_controller.dart';
import '../../notification/controllers/notification_controller.dart';
import '../../notification/screens/notification_screen.dart';
import '../../profile/controllers/profile_contrroller.dart';
import '../../search_product/controllers/search_product_controller.dart';
import '../../search_product/widgets/search_filter_bottom_sheet_widget.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../wishlist/screens/wishlist_screen.dart';
import '../controllers/product_controller.dart';
import '../domain/models/product_model.dart';
import '../widgets/bottom_Navigation_Bar_select_product.dart';

class AllCategoryAndBrand extends StatefulWidget {
  const AllCategoryAndBrand({super.key, this.backButtom=true});
  final bool? backButtom;

  @override
  State<AllCategoryAndBrand> createState() => _AllCategoryAndBrandState();
}

class _AllCategoryAndBrandState extends State<AllCategoryAndBrand> {


bool isBrand=false;
  ScrollController scrollController =ScrollController();
   int pageSize = 20;
  final PagingController<int, Product> pagingController =
  PagingController<int, Product>(firstPageKey: 1);
  int _page=1;
  int get page =>_page;
  Future<void> fetchPage(int pageKey,bool isBrands ,String id,BuildContext context,bool reloud) async {
    try {
      setState(() {
        pageSize=isBrand?20:25;
      });
      final List<Product>  newItems = await Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(

          isBrand,selectIndexBrand!=null?selectIndexBrand!:0,Provider.of<CategoryController>(context,listen: false).brandCategoryList[selectIndexCategory].id.toString(),context,pageKey,true
          ,'',Provider.of<SearchProductController>(context, listen: false).syncSortText,
          Provider.of<SearchProductController>(context, listen: false).sortText,
          '&from_price=${ Provider.of<SearchProductController>(context, listen: false).minFilterValue.toString()}&to_price=${Provider.of<SearchProductController>(context, listen: false).maxFilterValue.toString()}',false
      );
      final isLastPage = newItems.length < pageSize;
      _page=_page+1;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
        setState(() {
          lastPage=true;
        });
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }

    } catch (error) {
      pagingController.error = error;
    }

  }
  @override
  void dispose() {

    pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    if(Provider.of<MyShopController>(Get.context!,listen: false).pendingList.isEmpty||Provider.of<MyShopController>(Get.context!,listen: false).linkedList.isEmpty){
      Provider.of<MyShopController>(Get.context!,listen: false).getList();

    }
    Provider.of<ProductController>(context,listen: false).clearSelectProduct(notify: false);


    scrollController.addListener(_scrollListener);
      fetchPage(page,false, Provider.of<CategoryController>(context,listen: false).categoryList.isNotEmpty?Provider.of<CategoryController>(context,listen: false).categoryList[selectIndexCategory].id.toString():'0', Get.context!,true);

  }

  int selectIndexCategory=0;
  int? selectIndexBrand;
  String selectBrandName='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:     AppBar(
          elevation: 5,
          centerTitle: false,
          automaticallyImplyLeading: false,
          surfaceTintColor: Theme.of(context).highlightColor,
          backgroundColor: Theme.of(context).highlightColor,
          title: Consumer<ProfileController>(
            builder:(context, profile, child) =>  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Consumer<ThemeController>(builder:(context, value, child) =>  Image.asset(value.darkTheme?Images.whiteLogoWithMame:Images.logoWithNameImage,width:value.darkTheme? 120:150,))

              ],
            ),

          ),
       actions: [  SizedBox(
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
                     child: Text(provider.notificationModel.isNotEmpty?provider.totalNotification.toString():'0',
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
         const SizedBox(width: 10,),],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        // controller: scrollController,
        child: Consumer<ProductController>(
          builder:(context, product, child) =>  Column(
            children: [
              const SizedBox(height: 10,),
              // brand view
              Consumer<CategoryController>(
                builder:(context, category, child) =>  Consumer<BrandController>(builder:(context, brand, child) =>
                    SizedBox(
                      height: 80,
                      child:BrandListWidget(isHomePage: true, scrollController: ScrollController(),   selectId:selectIndexBrand , selectBrand: (BrandModel val)async{

                         if(selectIndexBrand==val.id){
                           await category.getCategoryList(true);
                           selectIndexCategory=0;

                           selectIndexBrand=null;
                           setState(() {
                             _page=1;
                             isBrand=false;

                             lastPage = false;
                             loading=false;
                           });
                           pagingController.refresh();

                           fetchPage(page,false, Provider.of<CategoryController>(Get.context!,listen: false).brandCategoryList[selectIndexCategory].id.toString(), Get.context!,true);
                           // scrollController.addListener(_scrollListener);

                         }else{
                           await category.getBrandCategoryList(val.id).then((value) async{
                         if(value==true){
                           selectIndexCategory=0;
                           selectIndexBrand=val.id;

                           setState(() {
                             selectBrandName=val.name;
                             isBrand=true;

                             _page=1;

                             lastPage = false;
                             loading=false;
                           });
                           pagingController.refresh();

                           fetchPage(page,isBrand, Provider.of<CategoryController>(Get.context!,listen: false).brandCategoryList.isNotEmpty?Provider.of<CategoryController>(Get.context!,listen: false).brandCategoryList.first.id.toString():'0', Get.context!,true);
                           // scrollController.addListener(_scrollListener);

                         }else{
                           selectIndexCategory=0;
                           await category.getCategoryList(true);
                           selectIndexBrand=null;
                           setState(() {
                             _page=1;
                             isBrand=false;

                             lastPage = false;
                             loading=false;
                           });
                           pagingController.refresh();
                           fetchPage(page,isBrand, Provider.of<CategoryController>(Get.context!,listen: false).brandCategoryList[selectIndexCategory].id.toString(), Get.context!,true);
                           //
                           // scrollController.addListener(_scrollListener);

                         }
                           });



                         }
                         product.clearSelectProduct();
                         scrollController.animateTo(
                           scrollController.position.minScrollExtent,
                           duration: const Duration(milliseconds: 1000),
                           curve: Curves.easeOut,
                         );
                       print(selectIndexBrand);
                      },)
                    ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // category view
                  Consumer<CategoryController>(
                    builder:(context, category, child) {
                      return Container(
                        width: 120,
                        color: Colors.black,
                        height: MediaQuery.of(context).size.height-100.h,
                        child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics:
                        const AlwaysScrollableScrollPhysics(),
                        itemCount: category.brandCategoryList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()async{

                              selectIndexCategory=index;
                              product.clearSelectProduct();

                              setState(() {
                                _page=1;

                                lastPage = false;
                                loading=false;
                              });
                              pagingController.refresh();

                              fetchPage(page,isBrand, Provider.of<CategoryController>(context,listen: false).brandCategoryList[selectIndexCategory].id.toString(), Get.context!,true);
                              // scrollController.addListener(_scrollListener);




                              scrollController.animateTo(
                                scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                              );

                            },
                            child: Container(

                              decoration: BoxDecoration(
                                color:selectIndexCategory==index? Theme.of(context).cardColor:null
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5),
                                child: Column(children: [
                                  CustomImageWidget(image: category.brandCategoryList[index].iconUrl,width: 80,),
                                  Text(category.brandCategoryList[index].name,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.tajawal(
                                    color:selectIndexCategory==index?Colors.black: Colors.white
                                  ),)
                                ],),
                              ),
                            ),
                          );
                      },),
                    );
                    },
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Column(
                      children: [
                        // select name and count / filter
                        Consumer<ProductController>(
                          builder:(context, product, child) =>  Consumer<CategoryController>(
                            builder:(context, category, child) =>  Consumer<BrandController>(
                              builder:(context, brand, child) {
                                return Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width/1.42,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                  Text(product.productCount.toString(),style: GoogleFonts.cairo(
                                    color: Colors.white,
                                  ),),
                                  Text('${category.brandCategoryList.isNotEmpty?category.brandCategoryList[selectIndexCategory].name.toString():''} ${selectIndexBrand!=null?'/':''} ${selectIndexBrand!=null?selectBrandName:""}',style: GoogleFonts.cairo(
                                    color: Colors.white,
                                  ),),
                                    InkWell(onTap: () {
                                      showModalBottomSheet(context: context,
                                          isScrollControlled: true, backgroundColor: Colors.transparent,
                                          builder: (c) =>  SearchFilterBottomSheet( pagingController: pagingController,)).then((value) {
                                        setState(() {
                                          _page=1;

                                          lastPage = false;
                                          loading=false;
                                        });
                                        product.clearSelectProduct();
                                        pagingController.refresh();

                                        fetchPage(page,false, Provider.of<CategoryController>(context,listen: false).categoryList[selectIndexCategory].id.toString(), Get.context!,true);
                                        scrollController.addListener(_scrollListener);


                                      });
                                      _page=1;

                                    },
                                        child: Stack(children: [
                                          Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                                      ),
                                            child:  SizedBox(width: 20,height: 20,child: Image.asset(Images.filterIcon)),),])),

                                ],),
                              );
                              },
                            ),
                          ),
                        ),




                        // product view
                        SizedBox(
                          height:MediaQuery.of(context).size.height-200,
                          child: PagedGridView<int ,Product>(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            pagingController: pagingController,
                            scrollController: scrollController,
                            showNoMoreItemsIndicatorAsGridChild: false,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing:0,crossAxisSpacing: 0,mainAxisExtent: 330
                            ),
                            builderDelegate: PagedChildBuilderDelegate(
                              firstPageProgressIndicatorBuilder: (context) {
                                return const ProductShimmer(isHomePage: false,
                                    isEnabled: true);

                              },
                              noMoreItemsIndicatorBuilder: (context) {
                                return const NoInternetOrDataScreenWidget(isNoInternet: false,
                                  viewImages: false,
                                  message: 'end_page',);
                              },
                              newPageErrorIndicatorBuilder: (context) {
                                return const NoInternetOrDataScreenWidget(isNoInternet: false,
                                  viewImages: false,
                                  message: 'end_page',);
                              },
                              // newPageProgressIndicatorBuilder: (context) {
                              //   return const ProductShimmer(isHomePage: false,
                              //       isEnabled: true);
                              // },
                              noItemsFoundIndicatorBuilder: (context) {
                                return const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noProduct,
                                  message: 'no_product_found',);
                              },
                              firstPageErrorIndicatorBuilder:(context) {
                                return const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noProduct,
                                  message: 'no_product_found',);
                              },
                              itemBuilder: (context, item, index) {
                                return ProductWidget(productModel: item, selectActive: true,);

                              },),

                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:pagingController.itemList!=null?SelectProductWidget(products: pagingController.itemList! ,):const SizedBox.shrink()
    );
  }




  bool loading = false;
  bool lastPage = false;
  //  Check if scroll position is near the end and call _fetchPage to load more product
  void _scrollListener() async {
    // if no more product this fun is stop
    if (lastPage == false) {
      if (loading == true) {
        return; // Prevent redundant fetches while loading
      }

      final double maxScrollExtent = scrollController.position.maxScrollExtent;
      final double currentScrollPosition = scrollController.position.pixels;

      // Check if scroll position is near the end
      if (currentScrollPosition >= maxScrollExtent - 8000.0) {
        setState(() {
          loading = true;
        });

        await fetchPage(page,isBrand, Provider.of<CategoryController>(context,listen: false).categoryList[selectIndexCategory].id.toString(), Get.context!,true).then((value) {
          setState(() {
            loading = false;
            // _page =(_page+1);

          });
        });
      }
    }
  }
}
