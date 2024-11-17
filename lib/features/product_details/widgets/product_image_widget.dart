import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_image_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../utill/images.dart';


class ProductImageWidget extends StatelessWidget {
  final ProductDetailsModel? productModel;
  final PageController controller;
  const ProductImageWidget({super.key, required this.productModel, required this.controller});

  // final PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashController>(context,listen: false);
    return productModel != null?
    Consumer<ProductDetailsController>(
      builder: (context, productController,_) {
        return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

            InkWell(onTap: () {
              // productModel!.productImagesNull! ? null :
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>
                  ProductImageScreen(title: getTranslated('product_image', context),imageList: productModel!.images!)));
            },
              child: (productModel != null && productModel!.images !=null) ?


              Stack(children: [
                SizedBox(
                    height: MediaQuery.of(context).size.width * 0.8,
                  child: productModel!.images != null?
                  PageView.builder(
                    controller: controller,
                    itemCount: productModel!.images!.length,
                    itemBuilder: (context, index) {

                      return
                        // WidgetZoom(
                        // heroAnimationTag: 'null',
                        //  maxScaleFullscreen: MediaQuery.of(context).size.width,
                        //  closeFullScreenImageOnDispose: false,
                        //
                      //  zoomWidget:
                      CustomImageWidget(
                            height: 100,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            image: productModel!.images![index]);
                      // );
                    },
                    onPageChanged: (index) => productController.setImageSliderSelectedIndex(index),
                  ):const SizedBox()),




                // Positioned(top: 16, right: 16,
                //   child: Column(children: [
                //       // FavouriteButtonWidget(backgroundColor: ColorResources.getImageBg(context),
                //       //   productId: productModel!.id),
                //
                //       // if(splashController.configModel!.activeTheme != "default")
                //       // const SizedBox(height: Dimensions.paddingSizeSmall,),
                //       // if(splashController.configModel!.activeTheme != "default")
                //       // InkWell(onTap: () {
                //       //   if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
                //       //     Provider.of<CompareController>(context, listen: false).addCompareList(productModel!.id!);
                //       //   }else{
                //       //     showModalBottomSheet(backgroundColor: const Color(0x00FFFFFF),
                //       //         context: context, builder: (_)=> const NotLoggedInBottomSheetWidget());
                //       //   }
                //       // },
                //       //   child: Consumer<CompareController>(
                //       //     builder: (context, compare,_) {
                //       //       return Card(elevation: 2,
                //       //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                //       //         child: Container(width: 40, height: 40,
                //       //           decoration: BoxDecoration(color: compare.compIds.contains(productModel!.id) ?
                //       //           Theme.of(context).primaryColor: Theme.of(context).cardColor ,
                //       //             shape: BoxShape.circle),
                //       //           child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                //       //             child: Image.asset(Images.compare, color: compare.compIds.contains(productModel!.id) ?
                //       //             Theme.of(context).cardColor : Theme.of(context).primaryColor),)));
                //       //     })),
                //       const SizedBox(height: Dimensions.paddingSizeSmall,),
                //
                //       //
                //       // InkWell(onTap: () {
                //       //     if(productController.sharableLink != null) {
                //       //       Share.share(productController.sharableLink!);
                //       //     }
                //       //   },
                //       //   child: Card(elevation: 2,
                //       //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                //       //     child: Container(width: 40, height: 40,
                //       //       decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                //       //       child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                //       //         child: Image.asset(Images.share, color: Theme.of(context).primaryColor)))))
                //     ])),

                Positioned(left: 0, right: 0, bottom: 5,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      // const SizedBox(),
                      // const Spacer(),
                      // Row(mainAxisAlignment: MainAxisAlignment.center,
                      //     children: _indicators(context)),
                      // const Spacer(),
                      // Provider.of<ProductDetailsController>(context).imageSliderIndex != null?
                      Container(
                        height: 20,
                       width: 60,
                       decoration: BoxDecoration(
                         color: Colors.black.withOpacity(0.40),
                         borderRadius: BorderRadius.circular(8)
                       ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Center(child: Text('${productController.imageSliderIndex!=null?productController.imageSliderIndex!+1:1}/${productModel?.images?.length}'
                          ,style: GoogleFonts.tajawal(
                              color: Colors.white ,
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                            ),
                          )),
                        ),
                      )

                     ])),
                // Positioned(top: 10, left: 0, child: Container(
                //   transform: Matrix4.translationValues(-1, 0, 0),
                //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor,
                //     borderRadius: const BorderRadius.only(
                //       topRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                //       bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                //     ),
                //   ),
                //   child: Center(child: Directionality(textDirection: TextDirection.ltr, child: Text(
                //     PriceConverter.percentageCalculation(context, productModel!.unitPrice, productModel!.discount, productModel!.discountType),
                //     style: textBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center,
                //   ))),
                // )),

              ]):
               const Padding(
                 padding: EdgeInsets.symmetric(vertical: 40),
                 child: NoInternetOrDataScreenWidget(isNoInternet: false,  message: 'no image',icon: Images.noProduct,),
               )),



          ],
        );
      }
    ): const SizedBox();
  }


}
