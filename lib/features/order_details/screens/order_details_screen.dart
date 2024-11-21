import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/cancel_and_support_center_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/order_amount_calculation.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/ordered_product_list_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/shipping_and_billing_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/shipping_info_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/order_details_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final bool isNotification;
  final int? orderId;
  final String? phone;
  final bool fromTrack;
  const OrderDetailsScreen({super.key, required this.orderId, this.isNotification = false, this.phone,  this.fromTrack = false});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {


  void _loadData(BuildContext context) async {
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn() && !widget.fromTrack){
      await Provider.of<OrderDetailsController>(Get.context!, listen: false).getOrderDetails(widget.orderId.toString());
      // await Provider.of<OrderController>(Get.context!, listen: false).initTrackingInfo(widget.orderId.toString());
      await Provider.of<OrderDetailsController>(Get.context!, listen: false).getOrderFromOrderId(widget.orderId.toString());
    }else{
      // await Provider.of<OrderDetailsController>(Get.context!, listen: false).trackOrder(orderId: widget.orderId.toString(),  isUpdate: false);
      await Provider.of<OrderDetailsController>(Get.context!, listen: false).getOrderFromOrderId(widget.orderId.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    if(Provider.of<SplashController>(context, listen: false).configModel == null ){
      Provider.of<SplashController>(context, listen: false).initConfig(context).then((value){
        _loadData(context);
        Provider.of<OrderDetailsController>(context, listen: false).digitalOnly(true);
      });
    }else{
      _loadData(context);
      Provider.of<OrderDetailsController>(context, listen: false).digitalOnly(true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) async{
       if(widget.isNotification){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
       }
       Provider.of<OrderDetailsController>(Get.context!, listen: false).emptyOrderDetails();
        return;
      },
      child: Scaffold(
          appBar: CustomAppBar(title: '${getTranslated('order', context)} ${ widget.orderId.toString()}#'),

        body: Consumer<SplashController>(
          builder: (context, config, _) {
            return  config.configModel != null?
            Consumer<OrderDetailsController>(
              builder: (context, orderProvider, child) {
                double itemTotalAmount = 0;
                double discount = 0;
                double? eeDiscount = 0;
                double tax = 0;
                double shippingCost = 0;

                // orderProvider.orders.
                if (orderProvider.orderDetails != null && orderProvider.orderDetails!.isNotEmpty) {
                  if( orderProvider.orderDetails?[0].order.isShippingFree == 1){
                    shippingCost = 0;
                  }else{
                    shippingCost = orderProvider.orders?.shippingCost??0;
                  }

                  for (var orderDetails in orderProvider.orderDetails!) {
                    if(orderDetails.productDetails!=null){
                    if(orderDetails.productDetails!.productType != null && orderDetails.productDetails!.productType != "physical" ){
                      orderProvider.digitalOnly(false, isUpdate: false);
                    }}
                  }



                  for (var orderDetails in orderProvider.orderDetails!) {
                    itemTotalAmount = itemTotalAmount + (orderDetails.price * orderDetails.qty);
                    discount = discount + orderDetails.discount;
                    tax = tax + orderDetails.tax;
                  }


                  if(orderProvider.orders != null && orderProvider.orders!.orderType == 'POS'){
                    if(orderProvider.orders!.extraDiscountType == 'percent'){
                      eeDiscount = itemTotalAmount * (orderProvider.orders!.extraDiscount/100);
                    }else{
                      eeDiscount = orderProvider.orders!.extraDiscount;
                    }
                  }
                  print(orderProvider.orderDetails);
                }


                return
                  orderProvider.orders!=null&&orderProvider.orderDetails != null ?orderProvider.orderDetails!.isNotEmpty  ?
                ListView(padding: const EdgeInsets.all(0), children: [



                  ShippingInfoWidget(order: orderProvider),

                  // SellerSectionWidget(order: orderProvider),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(getTranslated('Order_informations', context)!,style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),)
                      ],
                    ),
                  ),
                  if(orderProvider.orders != null)
                    OrderProductListWidget(orderType: orderProvider.orders!.orderType,
                      fromTrack: widget.fromTrack,isGuest:0,orderId: orderProvider.orders!.id.toString(), orderModel: orderProvider.orders!,),

                  // PaymentInfoWidget(order: orderProvider),

                  const SizedBox(height: Dimensions.marginSizeDefault),
                  OrderAmountCalculation(orderProvider: orderProvider,itemTotalAmount: itemTotalAmount,discount: discount,eeDiscount: eeDiscount,shippingCost: shippingCost, tax: tax,),




                  const SizedBox(height: Dimensions.paddingSizeSmall,),







                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  CancelAndSupportWidget(orderModel: orderProvider.orders,orderDetailsModel: orderProvider.orderDetails!,),
                ],
                ) : const NoInternetOrDataScreenWidget(isNoInternet: false, ):const OrderDetailsShimmer();
              },
            ):const OrderDetailsShimmer();
          }
        )
      ),
    );
  }
}
