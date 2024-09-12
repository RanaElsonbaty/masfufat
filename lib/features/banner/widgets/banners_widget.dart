
import 'dart:async';

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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  void initPage() {
    try{
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (controller.page!.round() < widget.mainBannerList.length - 1) {
          // controller.jumpToPage(controller.page!.round() + 1);
          controller.animateToPage(controller.page!.round() + 1, curve: Curves.easeInOutBack,duration: const Duration(seconds:2));
        } else {
          // controller.jumpToPage(0);
          controller.animateToPage(0, curve: Curves.easeInOutBack,duration: const Duration(seconds:5));

        }
      });

      controller.addListener(() {

            _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
          if (controller.page!.round() < widget.mainBannerList.length - 1) {
            controller.animateToPage(controller.page!.round() + 1, curve: Curves.easeInOutBack,duration: const Duration(seconds:2));
          } else {

            controller.animateToPage(0, curve: Curves.easeInOutBack,duration: const Duration(seconds:5));

          }
        });
      });
    }catch(e){
      print('banner jump error ---> $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final pages = List.generate(
        widget.mainBannerList.length ,
            (index,) =>   widget.mainBannerList.isNotEmpty ?
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
      ) : const BannerShimmer(),
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
                    _timer?.cancel();
                    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
                      if (controller.page!.round() < widget.mainBannerList.length - 1) {
                        controller.animateToPage(controller.page!.round() + 1, curve: Curves.easeInOutBack,duration: const Duration(seconds:2));
                      } else {
                        // controller.jumpToPage(0);
                        controller.animateToPage(0, curve: Curves.easeInOutBack,duration: const Duration(seconds:2));

                      }
                    });
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
                    // ,
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

