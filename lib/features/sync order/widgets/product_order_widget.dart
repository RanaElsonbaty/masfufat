import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/models/Sync_order_model.dart';

import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';

class ProductSyncOrder extends StatefulWidget {
  const ProductSyncOrder({super.key,  this.syncOrder, required this.products});
  final SyncOrderModel? syncOrder;
  final  List< ProductDetailsModel> products;

  @override
  State<ProductSyncOrder> createState() => _ProductSyncOrderState();
}

class _ProductSyncOrderState extends State<ProductSyncOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProduct();

  }
//   List< ProductDetailsModel> products=[];
//   void getProduct()async{
//     widget.syncOrder!.details!.forEach((element)async {
//       await Provider.of<ProductDetailsProvider>(context, listen: false)
//           .getProductDetails(context, element.productId.toString()).then((value) {
// setState(() {
//   products.add(  Provider.of<ProductDetailsProvider>(context, listen: false).productDetailsModel!);
//
// });
//
//           });
//     });
//
//
//   }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 0.5, color: Colors.grey)),
        child: ListView.builder(
            itemCount: widget.products.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              double? totalPrice = 0.00;
              if(widget.products.isNotEmpty) {
                totalPrice =
                // 0.00
                ((widget.products[index].unitPrice!=null?widget.products[index].unitPrice!:0.00) *
                    widget.syncOrder!.details![index].qty!);
              }
              // print(
              //     'aaaaaaaaaaaaaaaaaaaaaaaaa${totalPrice} =${(widget.syncOrder!.details![index].product!.unitPrice! * 0.15)}');
              if (widget.products.isNotEmpty) {
                return InkWell(
                onTap: () {
                  // Product ?productModel;
                  // productModel=Product(
                  //     id: widget.products[index].id!,
                  //     im:widget. products[index].images!,
                  //     shippingCost:widget. products[index].shippingCost,
                  //     shortDesc:widget. products[index].shortDesc,
                  //     slug:widget. products[index].slug,
                  //     imageUrl: widget.products[index].images!.first,
                  //     itemNumber:widget. products[index].itemNumber,
                  //     addedBy:widget.products[index].addedBy ,
                  //     discount: widget.products[index].discount,
                  //     discountType:widget.products[index].discountType ,
                  //     displayFor:widget.products[index].displayFor  ,variation:widget.products[index].variation  ,reviews:widget. products[index].reviews,reviewCount:widget. products[index].reviewsCount,tax:widget.products[index].tax ,taxModel:widget.products[index].taxModel ,taxType: widget.products[index].taxType,thumbnail:widget.products[index].thumbnail ,unit: widget.products[index].unit,unitPrice:widget.products[index].unitPrice ,updatedAt:widget. products[index].updatedAt,orderCount: 0,purchasePrice:widget.products[index].purchasePrice ,
                  //     code: widget.products[index].code,currentStock: widget.products[index].currentStock.toString(),name:widget.products[index].name ,minimumOrderQty:widget.products[index].minimumOrderQty ,minQty:widget.products[index].minQty
                  // );
                  // Navigator.push(
                  //     context,
                  //     CustomPageRouteBuilder(
                  //       pageBuilder:
                  //           (context, animation, secondaryAnimation) =>
                  //           ProductsDetailsScreen(
                  //             // index: indexx,
                  //             productModel:productModel,
                  //             // products[index],
                  //             productId:widget.products[index].id!,
                  //             images: widget.products[index].images!,
                  //             // slug:widget. products[index].slug!,
                  //             price:widget.products[index].unitPrice
                  //                 .toString(),
                  //           ),
                  //     ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Image.asset(
                                Images.placeholder,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (c, o, s) => Image.asset(
                                  Images.placeholder_3x1,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover),
                              imageUrl:
                              widget.products[index].images!=null&&widget.products[index].images!.isNotEmpty?widget.products[index].images!.first:'',
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              widget. products[index]
                                  .name !=
                                  null
                                  ? widget.products[index].name!
                                  : '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                              const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Column(
                            children: [
                              Text(
                                getTranslated('quantity', context)!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'x ${widget.syncOrder!.details![index].qty != null ? widget.syncOrder!.details![index].qty!.toString() : '0'}',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Column(
                            children: [
                              Text(
                                getTranslated('price', context)!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                PriceConverter.convertPrice(
                                    context,
                                    widget.products[index]
                                        .unitPrice ?? 0.00),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 3,
                          ),

                          Column(
                            children: [
                              Text(
                                getTranslated('TAX', context)!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                widget. products[index]
                                    .taxModel !=
                                    'exclude'
                                    ? PriceConverter.convertPrice(
                                    context,
                                    widget.products[index].tax ?? 0.00)
                                    : '%${widget.products[index].taxType}',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 3,
                          ),

                          Column(
                            children: [
                              Text(
                                getTranslated('SHIPPING_FEE_', context)!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                PriceConverter.convertPrice(
                                    context,
                                    widget.products[index]
                                        .shippingCost ?? 0.00),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 3,
                          ),

                          Column(
                            children: [
                              Text(
                                getTranslated('total_price', context)!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                PriceConverter.convertPrice(
                                    context, totalPrice),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),

                          // Expanded(
                          //   child: Text(
                          //     products[index].name!=null? products[index].name:'',
                          //     maxLines: 2,
                          //     overflow:
                          //         TextOverflow.visible,
                          //     style: TextStyle(),
                          //   ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
