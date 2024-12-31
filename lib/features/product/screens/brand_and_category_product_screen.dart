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
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/custom_themes.dart';
import '../../category/controllers/category_controller.dart';
import '../../category/domain/models/category_model.dart';
import '../../search_product/controllers/search_product_controller.dart';
import '../../search_product/widgets/search_filter_bottom_sheet_widget.dart';
import '../widgets/bottom_Navigation_Bar_select_product.dart';
import '../widgets/select_product_top.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final int index;
  final String? image;
  const BrandAndCategoryProductScreen({super.key, required this.isBrand, required this.id, required this.name, this.image, required this.index});

  @override
  State<BrandAndCategoryProductScreen> createState() => _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState extends State<BrandAndCategoryProductScreen> {
  ScrollController scrollController =ScrollController();
  static const _pageSize = 25;
  final PagingController<int,Product> pagingController =
  PagingController<int,Product>(firstPageKey: 1);
  int _page=1;
  int get page =>_page;
  Future<void> fetchPage(int pageKey,bool isBrand ,String id,BuildContext context,bool reloud) async {
    try {

      final List<Product>  newItems = await Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(
          isBrand,int.parse(id),isBrand?'0':id,context,pageKey,true
      ,searchController.text,Provider.of<SearchProductController>(context, listen: false).syncSortText,
          Provider.of<SearchProductController>(context, listen: false).sortText,
          '&from_price=${ Provider.of<SearchProductController>(context, listen: false).minFilterValue.toString()}&to_price=${Provider.of<SearchProductController>(context, listen: false).maxFilterValue.toString()}'
          , true
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
    Provider.of<ProductController>(context,listen: false).clearSelectProduct(notify: false);
    initData();


  }
  void initData()async{
   pagingController.addPageRequestListener((pageKey) {
      fetchPage(page,widget.isBrand, widget.id, Get.context!,true);
    });
  }
  TextEditingController searchController =TextEditingController();
  FocusNode focusNode =FocusNode();
  int selectIndex=0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // productController!.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: widget.name,
        // reset: Row(children: [
        //   const SizedBox(width: 10,),
        //
        //   InkWell(
        //       onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen(showBackButton: true,))),
        //       child: Image.asset(Images.bag2, width: 25, height: 25,color: Theme.of(context).iconTheme.color)),
        //
        //   const SizedBox(width: 15,),
        //   Stack(
        //     children: [
        //       InkWell(
        //           onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
        //           child:Image.asset(Images.search,width: 25, height: 25,
        //             color: Theme.of(context).iconTheme.color,)),
        //     ],
        //   ),
        //
        //   const SizedBox(width: 10,),
        //
        // ],),
        // showResetIcon: true,
      ),
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

                    child: Row(
                      children: [
                        Expanded(
                          flex: 11,
                          child: Material(child: TextFormField(
                            controller: searchController,
                            // focusNode: searchProvider.searchFocusNode,
                            textInputAction: TextInputAction.search,
                            onChanged: (val){
                              // if(val.isNotEmpty){
                              _page=1;
                                                  pagingController.refresh();
                              // }
                            },
                            onFieldSubmitted: (value) {

                            },

                            style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                            decoration: InputDecoration(
                                isDense: false,
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
                                // suffixIcon:
                            ),
                          ),

                          ),
                        ),
                        SizedBox(width:    60,
                          child: focusNode.hasFocus?const SizedBox.shrink():  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(onTap: () {
                                  showModalBottomSheet(context: context,
                                      isScrollControlled: true, backgroundColor: Colors.transparent,
                                      builder: (c) =>  SearchFilterBottomSheet( pagingController: pagingController,));
                                  _page=1;

                                },
                                    child: Stack(children: [
                                      Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                                          horizontal: Dimensions.paddingSizeExtraSmall),

                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).primaryColor,
                                            border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25))),
                                        child:  SizedBox(width: 28,height: 28,child: Image.asset(Images.filterIcon)),),])),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SelectProductTop(products:pagingController.itemList??[], select: productController.productSelect.isNotEmpty,showOrgnalWidget: false,),
                ),
           widget.isBrand==false?     Consumer<CategoryController>(
             builder:(context, categoryProvider, child) => categoryProvider.categoryList[widget.index].childes.isNotEmpty?  Container(
                    height: 60,
                    alignment: AlignmentDirectional.centerStart,
                    child: Consumer<CategoryController>(
                                builder:(context, categoryProvider, child) => ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,

                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  itemCount: categoryProvider.categoryList[widget.index].childes.length+1,
                                  itemBuilder: (context, index) {
                                    late CategoryModel subCategory;
                                    if(index != 0) {
                                      subCategory = categoryProvider.categoryList[widget.index].childes[index-1];
                                    }
                                    if(index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: InkWell(
                                          onTap: (){
                 if( selectIndex!=index) {
                   setState(() {
                     selectIndex = index;
                     _page = 1;
                   });

                   fetchPage(page, widget.isBrand, widget.id.toString(), Get.context!, true);
                   pagingController.refresh();
                 }
                                          },
                                          child: Container(
                                            height:35,
                                            decoration: BoxDecoration(
                                              color:selectIndex==index?Theme.of(context).primaryColor: const Color(0xFFEFECF5),
                                              borderRadius: BorderRadius.circular(12),

                                            ),child:Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Center(
                                              child: Text(getTranslated('all_products', context)!,style: GoogleFonts.tajawal(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                 color:  selectIndex==index?Colors.white:Colors.black
                                              ),),
                                                                                    ),
                                            ),

                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: InkWell(
                                          onTap: (){
                                            if( selectIndex!=index){
                                            setState(() {
                                              selectIndex=index;
                                              _page=1;

                                            });
                                            fetchPage(page,widget.isBrand, subCategory.id.toString(), Get.context!,true);
             pagingController.refresh();}
                                          },
                                          child: Container(
                                            height:35,
                                            decoration: BoxDecoration(
                                              color:selectIndex==index?Theme.of(context).primaryColor: const Color(0xFFEFECF5),
                                              borderRadius: BorderRadius.circular(12),

                                            ),child:Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Center(
                                                child: Text(subCategory.name,style: GoogleFonts.tajawal(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                  color: selectIndex==index?Colors.white:Colors.black
                                                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                  },
                                ),
                    ),
                  ):const SizedBox.square(),
           ):const SizedBox.shrink(),
                Expanded(
                  child: PagedGridView<int,Product>(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                physics: const BouncingScrollPhysics(),
                      pagingController: pagingController,
                  
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                   mainAxisSpacing: 5,crossAxisSpacing: 5,mainAxisExtent: 330
                   ),
                    showNoMoreItemsIndicatorAsGridChild: false,
                    builderDelegate: PagedChildBuilderDelegate(
                         firstPageProgressIndicatorBuilder: (context) {
                           return const ProductShimmer(isHomePage: false,
                      isEnabled: true);
                         },
                      noMoreItemsIndicatorBuilder: (context) {
                        return const NoInternetOrDataScreenWidget(isNoInternet: false,
                          viewImages: false,
                          message: '',);
                      },
                      newPageErrorIndicatorBuilder: (context) {
                        return const NoInternetOrDataScreenWidget(isNoInternet: false,
                          viewImages: false,
                          message: '',);
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
                   return ProductWidget(productModel: item,selectActive: true,);
                  
                    },),
                  
                  ),
                ),
              ],
            ),
          );
        },
      ),
        // bottomNavigationBar:pagingController.itemList!=null?Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 3),
        //   child: SelectProductWidget(products: pagingController.itemList! ,),
        // ):const SizedBox.shrink()

    );
  }
}
