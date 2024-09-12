import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utill/images.dart';
import '../domain/models/product_model.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget(
      {super.key,
      this.productModel,
      this.isCategory = false});
  final bool? isCategory;
  final Product? productModel;

  @override
  Widget build(BuildContext context) {
    String url = '${AppConstants.baseUrl}/storage/app/public/product/sa/';
    // String url1 = Provider.of<SplashProvider>(context, listen: false)
    //     .configModel
    //     .baseUrls
    //     .productImageUrl;
    final controller = PageController(viewportFraction: 1, keepPage: true);
    final pages = List.generate(
      productModel!.images != null
              ? productModel!.images!.length
              : 1,
      (index) => Container(
          height: 360,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // color: Colors.grey.shade300,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child:
              Container(
                  color: const Color(0XFFFFFFFF),
                  height: 155,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        // bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Image.asset(
                        Images.placeholder,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      errorWidget: (c, o, s) => Image.asset(Images.placeholder,
                          height: 140, fit: BoxFit.cover),
                      imageUrl: productModel!.images != null
                          ? productModel!.images![index].compareTo(url) == 1
                              ? productModel!.images!.isNotEmpty ? productModel!.images![index] : ''
                              : "$url${productModel!.images![index]}"
                          : Images.placeholder,
                      width: double.infinity,
                      // height: 140,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
    );

    return Stack(children: [
      Container(
        height: isCategory!
                ? 140
                : 155,
        color: const Color(0xFFFFFFFF),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: PageView.builder(
            controller: controller,

            itemCount: pages.length,
            itemBuilder: (_, index) {

              return pages[index % pages.length];
            },
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top:productModel!.currentStock!=0? 140
                  : 125,
        ),
        child: Align(
          alignment: AlignmentDirectional.topCenter,
          child: SmoothPageIndicator(
            controller: controller,
            count: pages.isNotEmpty ? pages.length : 1,
            effect: const ExpandingDotsEffect(
              strokeWidth: 5,

              activeDotColor: Color(0xFF5A409B),
              dotHeight:  4,
              dotWidth:  4,

            ),
          ),
        ),
      ),
    ]);
  }
}
