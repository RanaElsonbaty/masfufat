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

import '../../../utill/images.dart';


class ProductImageWidget extends StatelessWidget {
  final ProductDetailsModel? productModel;
  final PageController controller;
  const ProductImageWidget({super.key, required this.productModel, required this.controller});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashController>(context,listen: false);
    return productModel != null?
    Consumer<ProductDetailsController>(
      builder: (context, productController,_) {
        return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

            InkWell(onTap: () {
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

                      CustomImageWidget(
                            height: 100,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            image: productModel!.images![index]);
                    },
                    onPageChanged: (index) => productController.setImageSliderSelectedIndex(index),
                  ):const SizedBox()),





                Positioned(left: 0, right: 0, bottom: 5,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
