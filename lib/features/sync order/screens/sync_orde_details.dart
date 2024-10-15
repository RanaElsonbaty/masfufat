
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../home/shimmers/order_details_shimmer.dart';
import '../../order/widgets/product_details.dart';
import '../../product_details/domain/models/product_details_model.dart';
import '../../splash/controllers/splash_controller.dart';
import '../domain/models/Sync_order_model.dart';
import '../widgets/Order_Amount_Calculation.dart';
import '../widgets/Shipping_And_Billing_Widget.dart';
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
    widget.syncOrder!.details!.forEach((element)async {
        await Provider.of<ProductDetailsController>(context, listen: false)
            .getProductDetails(context, element.productId.toString(),'').then((value) {
            setState(() {
              products.add( Provider.of<ProductDetailsController>(context, listen: false).productDetailsModel!);
            });
        });

    });
    // List<ProductDetailsModel> product=[];
    // product.addAll(products);
    // products.addAll(product.reversed);
  }

  @override
  void initState() {
    super.initState();

    getProduct();
    Provider.of<SyncOrderController>(context, listen: false)
        .getOrderDetailsList(widget.syncOrder!.id!.toString(),);

  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      onPopInvoked: (val) async{
        return;
      },
      child: Scaffold(
          appBar: CustomAppBar(title: '${getTranslated('order', context)} ${ widget.syncOrder!.id.toString()}#'),
          // AppBar(elevation: 1, backgroundColor: Theme.of(context).cardColor,
          //     toolbarHeight: 120, leadingWidth: 0, automaticallyImplyLeading: false,
          //     title: Consumer<SyncOrderController>(
          //         builder: (context, orderProvider, _) {
          //           return (orderProvider.syncOrderDetails != null ) ?
          //           const SyncOrderDetailsStatusWidget():const SizedBox();})),

          body: Consumer<SplashController>(
              builder: (context, config, _) {
                return config.configModel != null?
                Consumer<SyncOrderController>(
                  builder: (context, orderProvider, child) {
                    double shippingAmount=0;
                    double productTax=0;
                    double dis=0;
                    for (var element in widget.syncOrder!.details!) {
                      dis+=element.discount!;
                    }
                    double totalPrice=0;

                    for (int i=0;i<products.length;i++) {
                      try{
                        if(products[i].taxType!=null&&products[i].taxType=='percent') {
                          productTax = productTax +
                              (products[i].unitPrice! * (products[i].tax! /
                                  100)) * widget.syncOrder!.details![i].qty!;
                        }else{
                          productTax =productTax+(products[i].tax! * widget.syncOrder!.details![i].qty!);
                        }
                      }catch(E){}
                      try{
                        totalPrice=totalPrice+(products[i].unitPrice!*
                            widget.syncOrder!.details![i].qty!);
                      }catch(E){}
                                                    }

                    try{
                      shippingAmount=  widget.syncOrder!.shippingCost!=null?widget.syncOrder!.shippingCost!:0;

                    }catch(e){}
                    double? eeDiscount = 0;



                      if(orderProvider.syncOrderDetails != null && orderProvider.syncOrderDetails!.orderType == 'POS'){
                        if(orderProvider.syncOrderDetails!.extraDiscountType == 'percent'){
                          eeDiscount = totalPrice * (orderProvider.syncOrderDetails!.extraDiscount!/100);
                        }else{
                          eeDiscount = orderProvider.syncOrderDetails!.extraDiscount;
                        }
                      }



                    return orderProvider.syncOrderDetails != null  ?
                    ListView(padding: const EdgeInsets.all(0), children: [



                      // Container(height: 10, color: Theme.of(context).primaryColor.withOpacity(.1)),
                      //



// 100726

                      const SizedBox(height: Dimensions.paddingSizeDefault),
                       OrderInfoSection(orderDetailsModel: orderProvider.syncOrderDetails!,),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      SyncShippingAndBillingWidget(orderProvider: orderProvider),
                      const SizedBox(height: Dimensions.paddingSizeDefault),


                      // SyncSellerSectionWidget(order: orderProvider),


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
                      ProductSyncOrder(products: products,syncOrder: widget.syncOrder!,),
                      const SizedBox(height: Dimensions.marginSizeDefault),
                      SyncOrderAmountCalculation(orderProvider: orderProvider,itemTotalAmount: totalPrice,discount: dis,eeDiscount: eeDiscount,shippingCost: shippingAmount, tax: productTax,),










                      widget.syncOrder!.paymentStatus == 'unpaid'&&orderProvider.syncOrderDetails!.orderStatus!='canceled'
                          ? Consumer<SyncOrderController>(
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
                      )
                          : const SizedBox.shrink(),

                      const SizedBox(height: 20,),
                  ],
                ):const OrderDetailsShimmer();
              }
          ):const SizedBox();
              }
      ),
          )
    );
  }
}
