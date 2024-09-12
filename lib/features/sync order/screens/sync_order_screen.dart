import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/widgets/sync_order_type_buttom_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/no_internet_screen_widget.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../order/widgets/order_shimmer_widget.dart';
import '../domain/models/Sync_order_model.dart';
import '../widgets/orderWidget.dart';

class SyncOrderScreen extends StatefulWidget {
  const SyncOrderScreen({super.key});

  @override
  State<SyncOrderScreen> createState() => _SyncOrderScreenState();
}

class _SyncOrderScreenState extends State<SyncOrderScreen> {
  ScrollController scrollController = ScrollController();
  static const _pageSize = 5;

  final PagingController _pagingController = PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<SyncOrderModel> newItems =
          await Provider.of<SyncOrderController>(context, listen: false)
              .getOrderList(
                  Provider.of<SyncOrderController>(context, listen: false).type,
                  pageKey.toString());
      pageKey = pageKey + 1;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = _pagingController.nextPageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SyncOrderController>(
      builder: (context, syncOrderProvider, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                children:  [
                  SyncOrderTypeButtomWidget(text: 'All_Order', index: 0, pagingController: _pagingController,),
                  const  SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'hanging', index: 1, pagingController: _pagingController),
                  const  SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'Waiting_for_payment', index: 2, pagingController: _pagingController),
                  const  SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'Under_financial_review', index: 3, pagingController: _pagingController),
                  const   SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'New', index: 4, pagingController: _pagingController),
                  const   SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'Preparing', index: 5, pagingController: _pagingController),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'ready', index: 6, pagingController: _pagingController),
                  const  SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'In_progress', index: 7, pagingController: _pagingController),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'DELIVERED', index: 8, pagingController: _pagingController),
                 const SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'Delivery_failed', index: 9, pagingController: _pagingController),
                 const SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'Recovering', index: 10, pagingController: _pagingController),
                 const SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'Retrieved', index: 11, pagingController: _pagingController),
                 const SizedBox(width: Dimensions.paddingSizeSmall),
                  SyncOrderTypeButtomWidget(text: 'Canceled', index: 12, pagingController: _pagingController),

                ],
              ),
            ),
          ),
          Expanded(
            child: PagedListView(
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                shrinkWrap: true,
                pagingController: _pagingController,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (context) {
                      return const NoInternetOrDataScreenWidget(
                        isNoInternet: false,
                        icon: Images.noOrder,
                        message: 'no_order_found',
                      );
                    },
                    firstPageErrorIndicatorBuilder: (context) {
                      return const NoInternetOrDataScreenWidget(
                        isNoInternet: false,
                        icon: Images.noOrder,
                        message: 'no_order_found',
                      );
                    },
                    newPageErrorIndicatorBuilder: (c) {
                      return const NoInternetOrDataScreenWidget(
                        isNoInternet: false,
                        icon: Images.noOrder,
                        message: 'no_order_found',
                      );
                    },
                    firstPageProgressIndicatorBuilder: (context) {
                      return const SizedBox(
                          height: 1000,
                          child: OrderShimmerWidget());
                    },
                    animateTransitions: false,
                    transitionDuration: const Duration(seconds: 1),
                    newPageProgressIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      );
                    },
                    noMoreItemsIndicatorBuilder: (context) {
                      return const SizedBox.shrink();
                    },
                    itemBuilder: (context, item, index) {
                      return SyncOrderWidget(
                        orderModel: item as SyncOrderModel,
                      );
                    })),
          ),
          //     Expanded(child:syncOrderProvider.isLoading==false? syncOrderProvider.orderList.isNotEmpty ?
          //     SingleChildScrollView(
          //       controller: scrollController,
          //       child: PaginatedListView(scrollController: scrollController,
          //         onPaginate: (int? offset) async{
          //         syncOrderProvider.getOrderList('all', offset.toString());
          //           // await orderController.getOrderList(offset!, orderController.selectedType);
          //         },
          //         totalSize: 1,
          //         offset: 1,
          // enabledPagination: true,
          //
          //         itemView: ListView.builder(
          //           shrinkWrap: true,
          //           physics: const NeverScrollableScrollPhysics(),
          //           itemCount: syncOrderProvider.orderList.length,
          //           padding: const EdgeInsets.all(0),
          //           itemBuilder: (context, index) => SyncOrderWidget(orderModel: syncOrderProvider.orderList[index]),
          //         ),
          //
          //       ),
          //     ) : const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) :
          //     const OrderShimmerWidget()
          //     )
        ],
      ),
    );
  }
}
