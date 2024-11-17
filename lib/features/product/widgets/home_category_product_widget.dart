import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/widgets/home_category_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class HomeCategoryProductWidget extends StatefulWidget {
  final bool isHomePage;
  final ScrollController scrollController;
  const HomeCategoryProductWidget({super.key, required this.isHomePage, required this.scrollController});

  @override
  State<HomeCategoryProductWidget> createState() => _HomeCategoryProductWidgetState();
}

class _HomeCategoryProductWidgetState extends State<HomeCategoryProductWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }
 int _page =2;
  bool loading = false;
  bool lastPage = false;
  void _scrollListener() async {
    Provider.of<ProductController>(Get.context!, listen: false).initPageEnd();
    if(Provider.of<ProductController>(Get.context!, listen: false).pageEnd==false){
    // if no more product this fun is stop
    if (lastPage == false) {
      if (loading == true) {
        return; // Prevent redundant fetches while loading
      }

      final double maxScrollExtent = widget.scrollController.position.maxScrollExtent;
      final double currentScrollPosition = widget.scrollController.position.pixels;

      // Check if scroll position is near the end
      if (currentScrollPosition >= maxScrollExtent - 1000.0) {
        setState(() {
          loading = true;
        });

        await Provider.of<ProductController>(Get.context!, listen: false)
            .getHomeCategoryProductList(false, _page)
            .then((value) {
          if (value == false) {
            setState(() {
              lastPage == true;
              loading = false;
            });
          } else {
            setState(() {
              loading = false;
              _page = (_page + 1);
            });
          }
        });
      }


      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, homeCategoryProductController, child) {
        return homeCategoryProductController.homeCategoryProductList!=null&&homeCategoryProductController.homeCategoryProductList!=null ?
        Column(
          children: [
            ListView.builder(
                itemCount: homeCategoryProductController.homeCategoryProductList!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return homeCategoryProductController.homeCategoryProductList![index].products!=null&& homeCategoryProductController.homeCategoryProductList![index].products!.isNotEmpty?HomeCategoryProductItemWidget(homeCategoryProduct: homeCategoryProductController.homeCategoryProductList!,
                  index: index, isHomePage: widget.isHomePage):const SizedBox.shrink();
                }),
            if(loading==true)
              Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
          ],
        )
            : const SizedBox();
      },
    );
  }
}


