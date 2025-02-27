import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/widgets/order_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/widgets/order_type_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/widgets/order_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const OrderScreen({super.key, this.isBacButtonExist = true});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ScrollController scrollController  = ScrollController();
   bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();
  @override
  void initState() {
    // if(!isGuestMode){


    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Consumer<OrderController>(
        builder: (context, orderController, child) {
          return Column(children: [



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50  ,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    OrderTypeButton(text: getTranslated('All_Order', context), index: 0),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('hanging', context), index: 1),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('Waiting_for_payment', context), index: 2),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('Under_financial_review', context), index: 3),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('New', context), index: 4),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('Preparing', context), index: 6),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('ready', context), index: 5),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('In_progress', context), index: 7),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('DELIVERED', context), index: 8),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('Delivery_failed', context), index: 9),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('Recovering', context), index: 10),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('Retrieved', context), index: 11),
   const SizedBox(width: Dimensions.paddingSizeSmall),
                    OrderTypeButton(text: getTranslated('Canceled', context), index: 12),

                  ],
                ),
              ),
            ),



            Expanded(child: orderController.orderModel != null &&orderController.orderModel!.isNotEmpty? (orderController.orderModel!= null )?
            SingleChildScrollView(
              controller: scrollController,
              child:orderController.selectTypeOrders.isNotEmpty? PaginatedListView(scrollController: scrollController,
                onPaginate: (int? offset) async{
                  await orderController.getOrderList(offset!, orderController.selectedType);
                },
                totalSize: 1,
                offset: 1,
                itemView: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderController.selectTypeOrders.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    // print(orderController.selectTypeOrders[index].orderStatus);
                    return OrderWidget(orderModel: orderController.selectTypeOrders[index]);
                  },
                ),

              ) : const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) ,

            ) : const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) :
            const OrderShimmerWidget()
            )

          ],
          );
        }
    );
  }
}




