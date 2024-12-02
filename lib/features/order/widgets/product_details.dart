import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../common/basewidget/custom_directionality_widget.dart';
import '../../../common/basewidget/custom_image_widget.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../product_details/domain/models/product_details_model.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../../sync order/domain/models/Sync_order_model.dart';

class ProductSyncOrder extends StatefulWidget {
  const ProductSyncOrder({super.key, this.syncOrder, required this.products});
  final SyncOrderModel? syncOrder;
  final  List<ProductDetailsModel> products;

  @override
  State<ProductSyncOrder> createState() => _ProductSyncOrderState();
}

class _ProductSyncOrderState extends State<ProductSyncOrder> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ListView.builder(
          itemCount: widget.products.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return widget.products.isNotEmpty
                ? InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetails(productId: widget.products[index].id, slug: widget.products[index].slug,),));
              },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: [
                                  Card(color: Theme.of(context).cardColor,
                    child: Column(children: [
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const SizedBox(width: Dimensions.marginSizeDefault),

                        ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                            child: CustomImageWidget(image: widget.products[index].images!=null? widget.products[index].images!.first:'', width: 70, height: 80)),
                        const SizedBox(width: Dimensions.marginSizeDefault),

                        Expanded(flex: 3,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              Expanded(child: Text(widget.products[index].name??'',
                                  style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400),
                                  maxLines: 2, overflow: TextOverflow.ellipsis))]),
                            const SizedBox(height: Dimensions.marginSizeExtraSmall),


                            Row(children: [

                              Text("${getTranslated('price', context)} ${PriceConverter.convertPrice(context, widget.products[index].unitPrice??0.00)}",
                                style: GoogleFonts.tajawal( fontSize: 14,fontWeight: FontWeight.w400),),
                              const Spacer(),
                              Text('${getTranslated('qty', context)} ${widget.syncOrder!.details![index].qty!}',

                                  style: GoogleFonts.tajawal( fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey.shade600)),
SizedBox(width: 10,),
                                  ]),
                            const SizedBox(height: Dimensions.marginSizeExtraSmall),
                            Text('${getTranslated('tax', context)} ${PriceConverter.calculationTaxString(context,widget.products[index].unitPrice, widget.products[index].tax??0.00,widget.products[index].taxType)}',
                              style: GoogleFonts.tajawal( fontSize: Dimensions.fontSizeDefault),),


                            const SizedBox(height: Dimensions.marginSizeExtraSmall),

                            Text('${getTranslated('Total', context)} ${PriceConverter.convertPrice(context,widget.products[index].unitPrice!+PriceConverter.calculationTaxDouble(context,widget.products[index].unitPrice, widget.products[index].tax??0.00,widget.products[index].taxType))}',
                              style: GoogleFonts.tajawal( fontSize: Dimensions.fontSizeDefault),),



                            // const SizedBox(height: Dimensions.paddingSizeSmall),
                          ],
                          ),
                        ),
                      ],
                      ),


                      const SizedBox(height: Dimensions.paddingSizeSmall),


                    ],
                    ),
                                  ),

                                  if(widget.products[index].discount! > 0) Positioned(
                    top: 5,
                    left:  5,
                    right:  5,
                    child: Container(
                      height: 20,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular( Dimensions.paddingSizeExtraSmall ),
                          left: Radius.circular( Dimensions.paddingSizeExtraSmall),
                        ),
                      ),
                      child: CustomDirectionalityWidget(
                        child: Text(
                          PriceConverter.percentageCalculation(
                            context,
                            (widget.products[index].unitPrice! * widget.products[index].currentStock!),
                            widget.products[index].discount,
                            getTranslated('amount', context),
                          ),
                          style: titilliumRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                    ),
                                  )

                                ],
                                ),
                  ),
                )
                : const SizedBox.shrink();
          }),
    );
  }
}
