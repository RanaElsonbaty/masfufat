
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/controllers/banner_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banner_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../domain/models/banner_model.dart';



class BannersWidget extends StatefulWidget {
  const BannersWidget({super.key, required this.mainBannerList});
  final   List<BannerModel> mainBannerList;

  @override
  State<BannersWidget> createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  PageController controller=PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final pages = List.generate(
        widget.mainBannerList.length ,
            (index,) =>  widget.mainBannerList != null ? widget.mainBannerList.isNotEmpty ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(height: width * 0.40, width: width,
          child:InkWell(
            onTap: () {
              if(widget.mainBannerList[index].resourceId != null){
                Provider.of<BannerController>(context,listen: false).clickBannerRedirect(context,
                    widget.mainBannerList[index].resourceId,
                    widget.mainBannerList[index].resourceType =='product'?
                    widget.mainBannerList[index].product : null,
                    widget.mainBannerList[index].resourceType);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                  Theme.of(context).primaryColor.withOpacity(.1) :
                  Theme.of(context).primaryColor.withOpacity(.05)),
                  child: CustomImageWidget(image: widget.mainBannerList[index].photo.toString(),fit: BoxFit.fill,)
              ),
            ),
          ),
        ),
      ) : const SizedBox() : const BannerShimmer(),
    );
    return Column(children: [
        Consumer<BannerController>(
          builder: (context, bannerProvider, child) {
            return Column(children: [

              SizedBox(
                height:  width * 0.40,
                child: PageView.builder(
                  controller: controller,
                  itemCount:pages.length ,
                  onPageChanged: (val){
                  },
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
const SizedBox(height: 10,),
                if( bannerProvider.mainBannerList != null &&  bannerProvider.mainBannerList!.isNotEmpty)
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count:  widget.mainBannerList.length,
                  axisDirection: Axis.horizontal,
                  effect: SwapEffect(
                    dotHeight: 5,
                    dotWidth: 8,
                    activeDotColor: Theme.of(context).primaryColor
                  ),
                ),
              )
            ],
            );
          },
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

