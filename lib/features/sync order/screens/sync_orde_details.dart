
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../order/widgets/product_details.dart';
import '../../product_details/domain/models/product_details_model.dart';
import '../domain/models/Sync_order_model.dart';

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
    late DateTime dateTime;
    String year = '';
    String month = '';
    String day = '';
    String hour = '';
    String minute = '';
    dateTime = widget.syncOrder!.createdAt!;
    String time = '';
// print('adasdasdasd${widget.syncOrder!.orderStatus}');
    year = DateFormat.y().format(dateTime);
    month = DateFormat.M().format(dateTime);
    day = DateFormat.d().format(dateTime);
    hour = DateFormat.H().format(dateTime);
    minute = DateFormat.m().format(dateTime);
    if (int.tryParse(hour)! >= 12) {
      if (int.tryParse(hour) == 12) {
        time = 'Pm';
      } else if (int.tryParse(minute)! >= 0) {
        time = 'Pm';
      } else {
        time = 'Am';
      }
    } else {
      time = 'Am';
    }
    print('syncOrder paymentMethod => ${widget.syncOrder!.paymentMethod}');
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: AppBar(
          iconTheme: IconThemeData(color: ColorResources.getTextTitle(context)),
          backgroundColor: Theme.of(context).cardColor,
          leading: InkWell(
              onTap: () {
               Navigator.pop(context);
              },
              child: Icon(Icons.keyboard_backspace)),
          title: Text(
            getTranslated('ORDER_DETAILS', context)!,
            style: GoogleFonts.tajawal(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.fontSizeLarge),
          )),
      body: Consumer<SyncOrderController>(
        builder: (context, syncOrder, child) => syncOrder.syncOrderDetails !=
            null
            ? RefreshIndicator(
          onRefresh: () async {
            // Provider.of<SyncOrderController>(context, listen: false)
            //     .getOrderDetails(
            //     widget.syncOrder!.id!.toString(), context, true);
            // Provider.of<SyncOrderController>(context, listen: false)
            //     .getCartBill(
            //     widget.syncOrder!,
            //     false,
            //     true,
            //     CouponModel(),
            //     context,
            //     widget.syncOrder!.shippingCost!,
            //     true);
          },
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                "${getTranslated('ORDER_ID', context)} : ",
                                style: titilliumRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                )),
                            TextSpan(
                                text:
                                " ${widget.syncOrder!.id != null ? widget.syncOrder!.id.toString() : ''} ",
                                style: titilliumRegular.copyWith(
                                    fontSize:
                                    Dimensions.fontSizeLarge,
                                    color: ColorResources.getPrimary(
                                        context))),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            child: const Icon(
                              Icons.copy,
                              size: 16,
                            ),
                          ),
                        ),
                        onTap: () {
                          showCustomSnackBar(
                            getTranslated(
                                'The_text_has_been_copied', context),
                            context,
                            isError: false,
                          );
                          Clipboard.setData(ClipboardData(
                              text:
                              widget.syncOrder!.id!.toString()));
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                            '$year/${int.parse(month) > 9 ? month : '0$month'}/${int.parse(day) > 9 ? day : '0$day'} - $time $hour:${int.parse(minute) > 9 ? minute : '0$minute'} ',
                            style: titilliumRegular.copyWith(
                                color: ColorResources.getPrimary(context),
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // SyncOrderDetailsInfo(),
                const SizedBox(
                  height: 10,
                ),
                widget.syncOrder != null &&
                    widget.syncOrder!.details != null
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: ProductSyncOrder(
                    products: products,
                    syncOrder: widget.syncOrder!,
                  ),
                )
                    : SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: Container(
                    // height: ,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: Colors.grey),
                    ),
                    child: Consumer<SyncOrderController>(
                      builder: (context, order, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<SyncOrderController>(
                            builder:(context, cartProvider, child) {
                              double shippingAmount=0;
                              double shippingTaxAmount=0;
                              double productTax=0;
                              double dis=0;
                              double price=0;
                              // double discount=0;
                              widget.syncOrder!.details!.forEach((element) {
                                dis+=element.discount!;
                                // price+=element.product!.unitPrice!;
                                // print('asdasdasd${element.product!.tax}');

                              });

                              products.forEach((element) {
                                try{
                                  price+=element.unitPrice!;

                                }catch(E){

                                }
                                try{
                                  productTax+=element.tax!=null?element.tax!:0;

                                } catch(e){}                                   });

                              shippingAmount=  widget.syncOrder!.shippingCost!=null?widget.syncOrder!.shippingCost!:0;
                              shippingTaxAmount=  widget.syncOrder!.shippingCost!=null?(widget.syncOrder!.shippingCost!*0.15):0;
                              double totalPrice=0;

                              totalPrice=   widget.syncOrder!.orderAmount!=null?  widget.syncOrder!.orderAmount!:0;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${getTranslated('sub_total', context)} :${PriceConverter.convertPrice(context, price)}'),
                                  Text(
                                      '${getTranslated('Shipping_charges', context)} :${PriceConverter.convertPrice(context, shippingAmount)}'),
                                  Text(
                                      '${getTranslated('Discount_on_the_product', context)} :${PriceConverter.convertPrice(context, dis)}'),
                                  Text(
                                      '${getTranslated('Product_tax', context)} :${PriceConverter.convertPrice(context, productTax)}'),
                                  Text(
                                      '${getTranslated('Shipping_tax', context)} :${PriceConverter.convertPrice(context,shippingTaxAmount)}'),
                                  Text(
                                      '${getTranslated('TOTAL_PAYABLE', context)} :${PriceConverter.convertPrice(context, totalPrice)}'),
                                  // Text(
                                  //     'خصم السلة : ${PriceConverter.convertPrice(context, widget.syncOrder!.d)}'),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                widget.syncOrder!.paymentStatus == 'unpaid'&&syncOrder.syncOrderDetails!.orderStatus!='canceled'
                    ? Consumer<SyncOrderController>(
                  builder:(context,order,child) =>InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text(
                              getTranslated('proceed', context)!,
                              style: const TextStyle(fontSize: 20,color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        )
            : const SizedBox(),
      ),
    );
  }
}
