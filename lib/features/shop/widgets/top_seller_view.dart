import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/top_seller_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/seller_card.dart';
import 'package:provider/provider.dart';



class TopSellerView extends StatefulWidget {
  final bool isHomePage;
  final ScrollController scrollController;
   const TopSellerView({super.key, required this.isHomePage, required this.scrollController});

  @override
  State<TopSellerView> createState() => _TopSellerViewState();
}

class _TopSellerViewState extends State<TopSellerView> {
  @override
  Widget build(BuildContext context) {
    return widget.isHomePage ? Consumer<ShopController>(
      builder: (context, topSellerProvider, child) {
        return topSellerProvider.sellerModel != null? (topSellerProvider.sellerModel != null && topSellerProvider.sellerModel!.isNotEmpty) ?
            ListView.builder(
              itemCount: topSellerProvider.sellerModel?.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: widget.isHomePage? Axis.horizontal : Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return topSellerProvider.sellerModel?[index].seller!.showSellersSection==1?SizedBox(width: 260,
                  child: SellerCard(sellerModel: topSellerProvider.sellerModel?[index], isHomePage: widget.isHomePage,
                      index: index,length: topSellerProvider.sellerModel?.length ?? 0)):const SizedBox();
              },
            ) : const SizedBox():const TopSellerShimmer();

      },
    ):Consumer<ShopController>(
      builder: (context, topSellerProvider, child) {
        return topSellerProvider.sellerModel != null? (topSellerProvider.sellerModel != null && topSellerProvider.sellerModel!.isNotEmpty) ?
        SingleChildScrollView(
          controller: widget.scrollController,
          child:  ListView.builder(
            itemCount: topSellerProvider.sellerModel?.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: widget.isHomePage? Axis.horizontal : Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return topSellerProvider.sellerModel?[index].seller!.showSellersSection==1 ?SizedBox(
                height: 250,
                child: SellerCard(sellerModel: topSellerProvider.sellerModel?[index], isHomePage: widget.isHomePage,
                    index: index,length: topSellerProvider.sellerModel?.length??0),
              ):const SizedBox();
            },
          ),
        ) : const SizedBox():const SellerShimmer();

      },
    );
  }
}



