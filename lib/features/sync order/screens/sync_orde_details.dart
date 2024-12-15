
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../home/shimmers/order_details_shimmer.dart';
import '../../order/widgets/product_details.dart';
import '../../product_details/domain/models/product_details_model.dart';
import '../../splash/controllers/splash_controller.dart';
import '../domain/models/Sync_order_model.dart';
import '../widgets/Order_Amount_Calculation.dart';
import '../widgets/order_info_section.dart';
import 'order_checkout.dart';

class OrderSyncDetailsScreen extends StatefulWidget {
  final int? orderId;

  final SyncOrderModel? syncOrder;
  const OrderSyncDetailsScreen(
      {super.key, @required this.orderId,
        this.syncOrder});

  @override
  State<OrderSyncDetailsScreen> createState() => _OrderSyncDetailsScreenState();
}

class _OrderSyncDetailsScreenState extends State<OrderSyncDetailsScreen> {
  List<ProductDetailsModel> products=[];
  void getProduct()async{
    Provider.of<SyncOrderController>(context, listen: false).syncOrderDetails!.externalOrder!.items!.forEach((element)async {
        await Provider.of<ProductDetailsController>(context, listen: false)
            .getProductDetails(context, element.toString(),'').then((value) {
          if(Provider.of<ProductDetailsController>(context, listen: false).noProductFount){
            showCustomSnackBar(getTranslated('no_product_Found', Get.context!), Get.context!,isError: true,time: 4);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const DashBoardScreen(orderError: true,),));
          }
            setState(() {
              products.add( Provider.of<ProductDetailsController>(context, listen: false).productDetailsModel!);
            });
        });

    });

  }

  @override
  void initState() {

    Provider.of<SyncOrderController>(context, listen: false)
        .getOrderDetailsList(widget.orderId.toString(),).then((value) {
      getProduct();

    });
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(title: '${getTranslated('order', context)} ${ widget.orderId.toString()}#'),

        body: Consumer<SplashController>(
            builder: (context, config, _) {

              return
              Consumer<SyncOrderController>(
                builder: (context, orderProvider, child) {
                  double shippingAmount = 0;
                  double productTax = 0;
                  double dis = 0;
                  double? eeDiscount = 0;
                  double totalPrice = 0;
                  if(orderProvider.syncOrderDetails!=null) {

                    dis += orderProvider.syncOrderDetails!.discountAmount!;

                    for (int i = 0; i < products.length; i++) {
                      try {
                        if (products[i].taxType != null &&
                            products[i].taxType == 'percent') {
                          productTax = productTax +
                              (products[i].unitPrice! * (products[i].tax! /
                                  100)) *
                                  orderProvider.syncOrderDetails!.externalOrder!
                                      .qtys![i];
                        } else {
                          productTax = productTax + (products[i].tax! *
                              orderProvider.syncOrderDetails!.externalOrder!
                                  .qtys![i]);
                        }
                      } catch (E) {}
                      try {
                        totalPrice = totalPrice + (products[i].unitPrice! *
                            orderProvider.syncOrderDetails!.externalOrder!
                                .qtys![i]);
                      } catch (E) {}
                    }

                    try {
                      shippingAmount =
                          orderProvider.syncOrderDetails!.shippingCost! ?? 0;
                    } catch (e) {}



                    if (orderProvider.syncOrderDetails != null &&
                        orderProvider.syncOrderDetails!.orderType == 'POS') {
                      if (orderProvider.syncOrderDetails!.extraDiscountType ==
                          'percent') {
                        eeDiscount = totalPrice *
                            (orderProvider.syncOrderDetails!.extraDiscount! /
                                100);
                      } else {
                        eeDiscount =
                            orderProvider.syncOrderDetails!.extraDiscount;
                      }
                    }
                  }

                  return orderProvider.syncOrderDetails != null  ?
                  ListView(padding: const EdgeInsets.all(0), children: [




                    const SizedBox(height: Dimensions.paddingSizeDefault),
                     OrderInfoSection(orderDetailsModel: orderProvider.syncOrderDetails!,),
                    const SizedBox(height: Dimensions.paddingSizeDefault),


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
                    ProductSyncOrder(products: products,syncOrder: orderProvider.syncOrderDetails!,),
                    const SizedBox(height: Dimensions.marginSizeDefault),
                    SyncOrderAmountCalculation(orderProvider: orderProvider,itemTotalAmount: totalPrice,discount: dis,eeDiscount: eeDiscount,shippingCost: shippingAmount, tax: productTax,),










    if(orderProvider.syncOrderDetails!.paymentStatus == 'unpaid'&&orderProvider.syncOrderDetails!.orderStatus!='canceled')                      //     ?
                    Consumer<SyncOrderController>(
                      builder:(context,order,child) =>InkWell(
                        onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>  OrderCheckout(orderDetailsModel: orderProvider.syncOrderDetails!, products: products,),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                                child: Text(
                                  getTranslated('proceed', context)!,
                                  style:  GoogleFonts.tajawal(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),
                                )),
                          ),
                        ),
                      ),
                    ),
                        // : const SizedBox.shrink(),

                    const SizedBox(height: 20,),
                ],
              ):const OrderDetailsShimmer();
            }
        );
            }
    ),
        );
  }
}
