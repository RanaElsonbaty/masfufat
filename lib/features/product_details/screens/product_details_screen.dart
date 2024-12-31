import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_image_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/bottom_cart_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_specification_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_title_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/review_and_specification_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/product_details_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/basewidget/custom_image_widget.dart';
import '../../../utill/color_resources.dart';
import '../../my shop/controllers/my_shop_controller.dart';
import '../../product/domain/models/product_model.dart';
import '../domain/models/product_details_model.dart';
import '../widgets/Logistics_information_widget.dart';
import '../widgets/favourite_button_widget.dart';
import '../widgets/reviewComSection.dart';

class ProductDetails extends StatefulWidget {
  final int? productId;
  final String? slug;
  final bool isFromWishList;
  final Product? product;

  const ProductDetails({super.key, required this.productId, required this.slug, this.isFromWishList = false,  this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


  Size widgetSize = const Size(100, 400);

  _loadData( BuildContext context) async{
    // Provider.of<MyShopController>(context,listen: false).getList();
    Provider.of<ProductDetailsController>(context, listen: false).getProductDetails(context, widget.productId.toString(), widget.productId.toString());
    // Provider.of<ReviewController>(context, listen: false).removePrevReview();
    // Provider.of<ProductDetailsController>(context, listen: false).removePrevLink();
    // Provider.of<ReviewController>(context, listen: false).getReviewList(widget.productId, widget.slug, context);
    // Provider.of<ProductController>(context, listen: false).removePrevRelatedProduct();
    // Provider.of<ProductController>(context, listen: false).initRelatedProductList(widget.productId.toString(), context);
    // Provider.of<ProductDetailsController>(context, listen: false).getCount(widget.productId.toString(), context);
    Provider.of<ProductDetailsController>(context, listen: false).getSharableLink(widget.slug.toString(), context);
  }
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    Provider.of<ProductDetailsController>(context, listen: false).selectReviewSection(0, isUpdate: false);
    _loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('product_details', context),
      // showActionButton: true,
        showResetIcon: true,
        reset: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Consumer<ProductDetailsController>(
            builder:(context, productController, child) =>  Row(children: [
              if(productController.sharableLink != null)
              InkWell(onTap: () {
                if(productController.sharableLink != null) {
                  Share.share(productController.sharableLink!,
                    subject:productController.productDetailsModel!.name ,


                  );
                }
              },
                  child: SizedBox(width: 40, height: 40,
                      child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Image.asset(Images.share, color: Theme.of(context).primaryColor))))
,
              const SizedBox(width: 5,),
              widget.product!=null?   FavouriteButtonWidget(backgroundColor: ColorResources.getImageBg(context),
                  productId:widget.productId,product: widget.product!,):const SizedBox.square(),
            ],),
          ),
        ),

      ),

      body: RefreshIndicator(onRefresh: () async => _loadData(context),
        child: Consumer<ProductDetailsController>(
          builder: (context, details, child) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: !details.isDetails?
              Column(children: [

                ProductImageWidget(productModel: details.productDetailsModel, controller: _controller,),
                Divider(
                  color: Colors.grey.shade300,

                ),
                
                Column(children: [
                  if(details.productDetailsModel!=null&& details.productDetailsModel!.images!=null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount:details.productDetailsModel!=null&& details.productDetailsModel!.images!=null?details.productDetailsModel!.images!.length>4?4:details.productDetailsModel!.images!.length:0,
                            itemBuilder: (context, index) {
                              if(index!=3) {
                                return

                                  InkWell(onTap: () {
                                    details
                                        .setImageSliderSelectedIndex(index);
                                    if (_controller.hasClients) {
                                      _controller.animateToPage(index,
                                          duration: const Duration(
                                              microseconds: 50),
                                          curve: Curves.ease);
                                    }
                                  },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1,
                                                    color: Colors.grey),
                                                color: Theme
                                                    .of(context)
                                                    .cardColor,
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                    .paddingSizeExtraSmall)),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                  .paddingSizeExtraSmall),
                                              child: CustomImageWidget(
                                                  height: 60, width: 60,
                                                  image: details.productDetailsModel!
                                                      .images![index]),
                                            )),
                                      ));
                              }else{
                                return  InkWell(
                                  onTap: () {
                                    // productModel!.productImagesNull! ? null :
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                                        ProductImageScreen(title: getTranslated('product_image', context),imageList: details.productDetailsModel!.images!,)));
                                  },
                                  child: Stack(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1,
                                                    color: Colors.grey),
                                                color: Theme
                                                    .of(context)
                                                    .cardColor,
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                    .paddingSizeExtraSmall)),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                  .paddingSizeExtraSmall),
                                              child: CustomImageWidget(
                                                  height: 60, width: 60,
                                                  fit: BoxFit.fill,
                                                  image: details.productDetailsModel!
                                                      .images![index]),
                                            )),
                                      ),
                                      details.productDetailsModel!.images!.length>4?  Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),

                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                  .paddingSizeExtraSmall),
                                              color: Colors.black.withOpacity(0.40)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Center(
                                              child: Text('${(details.productDetailsModel!.images!.length-4)}+',
                                                style: GoogleFonts.tajawal(

                                                    color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ):const SizedBox(),
                                    ],
                                  ),
                                );
                              }
                            },),
                        ),
                      ),
                    ],
                  ),

                  if(details.productDetailsModel!=null&& details.productDetailsModel!.images!=null)
                  const SizedBox(height: 10,),
                  ProductTitleWidget(productModel: details.productDetailsModel,
                      averageRatting: details.productDetailsModel?.averageReview?? "0"),



                  const ReviewAndSpecificationSectionWidget(),


                  details.index==1?productFeatures(details.productDetailsModel!.props!): details.index==3?
                   Column(children: [
                    const SizedBox(height: 5,),
                    ReviewComSection(productDetailsModel:details.productDetailsModel! ,)
                    // ReviewSection(details: details),
                    // _ProductDetailsProductListWidget(scrollController: scrollController),
                  ]):   details.index==0?

                  Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment:MainAxisAlignment.start,children: [
                    (details.productDetailsModel?.desc != null && details.productDetailsModel!.desc!.isNotEmpty) ?
                    Row(
                      children: [
                        ProductSpecificationWidget(
                          productSpecification: details.productDetailsModel!.desc!['value'] ?? '',
                        ),
                      ],
                    ) :const NoInternetOrDataScreenWidget(isNoInternet: false),



                  ],):LogisticsInformationWidget(productDetailsModel: details.productDetailsModel!,),
                ],),
              ],
              ):
              const ProductDetailsShimmer(),
            );
          },
        ),
      ),

      bottomNavigationBar:

      Consumer<ProductDetailsController>(
        builder: (context, details, child) {
          return !details.isDetails?
          BottomCartWidget(product: details.productDetailsModel):const SizedBox();
        }
      ),
    );
  }
  Widget productFeatures(  List<SinglePropModel> prop){
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: prop.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder:  (context, index) {
        return Row(children: [
          Text('${prop[index].property.toString()} : ',style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w500,fontSize: 16,
          ),),   Text(prop[index].value.toString(),style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w500,fontSize: 16,
          ),),
        ],);
      },);
  }
}

// class _ProductDetailsProductListWidget extends StatelessWidget {
//   const _ProductDetailsProductListWidget({
//     required this.scrollController,
//   });
//
//   final ScrollController scrollController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductDetailsController>(
//         builder: (context, productDetailsController, _) {
//           return Column(children: [
//             Consumer<SplashController>(
//               builder:(context, splash, child) =>  Consumer<SellerProductController>(
//                   builder: (context, sellerProductController, _) {
//                     return (splash.configModel!.showSellersSection==1&&sellerProductController.sellerProduct != null && sellerProductController.sellerProduct != null &&
//                         sellerProductController.sellerProduct!.isNotEmpty)?
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
//                       child: TitleRowWidget(title: getTranslated('more_from_the_shop', context),
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
//                             fromMore: true,
//                             sellerId: productDetailsController.productDetailsModel?.seller?.id,
//                             temporaryClose: productDetailsController.productDetailsModel?.seller?.shop!.temporaryClose==1,
//                             vacationStatus: productDetailsController.productDetailsModel?.seller?.shop!.vacationStatus==1,
//                             vacationEndDate: productDetailsController.productDetailsModel?.seller?.shop!.vacationEndDate,
//                             vacationStartDate: productDetailsController.productDetailsModel?.seller?.shop!.vacationStartDate,
//                             name: productDetailsController.productDetailsModel?.seller?.shop!.name,
//                             banner: productDetailsController.productDetailsModel?.seller?.shop!.banner,
//                             image: productDetailsController.productDetailsModel?.seller?.image,
//                           )));
//
//                         },
//                       ),
//                     ):const SizedBox();
//                   }
//               ),
//             ),
//
//             // Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall),
//             //   child: ShopProductViewList(
//             //       scrollController: scrollController, sellerId: productDetailsController.productDetailsModel!.seller!.id)),
//
//             // Consumer<ProductController>(
//             //     builder: (context, productController,_) {
//             //       return (productController.relatedProductList != null && productController.relatedProductList!.isNotEmpty)?Padding(padding: const EdgeInsets.symmetric(
//             //           vertical: Dimensions.paddingSizeExtraSmall),
//             //           child: TitleRowWidget(title: getTranslated('related_products', context), isDetailsPage: true)): const SizedBox();
//             //     }
//             // ),
//             // const SizedBox(height: 5),
//             // const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//             //   child: RelatedProductWidget(),
//             // ),
//             const SizedBox(height: Dimensions.paddingSizeSmall),
//           ]);
//         }
//     );
//   }
//
// }
