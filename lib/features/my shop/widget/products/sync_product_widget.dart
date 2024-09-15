import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/widget/show_Modal_Bottom_Sheet.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../domain/model/model.dart';

class SyncProductWidget extends StatefulWidget {
  const SyncProductWidget({
    super.key,
    required this.pending,
    required this.controller,
    required this.index,
  });

  final Deleted pending;

  final TextEditingController controller;
  final int index;

  @override
  State<SyncProductWidget> createState() => _SyncProductWidgetState();
}

class _SyncProductWidgetState extends State<SyncProductWidget> {
  @override
  void initState() {
    getProfit(double.tryParse(widget.controller.text)??0.00);

    super.initState();
  }
  double profit =0.00;
  double percentage =0.00;
  void getProfit(double val) {
    //
double value=widget.pending.pricings.value+(widget.pending.taxType=='percent'?((widget.pending.tax/100)*widget.pending.pricings.value):widget.pending.tax);


setState(() {
  profit = (val - value);
  percentage = (profit / value) * 100;
});
    print("Profit: $profit");
    print("Percentage: $percentage%");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<MyShopController>(
                    builder: (context, myShopProvider, child) {
                      return Checkbox(
                        value: myShopProvider.selectIds
                            .contains(widget.pending.id),
                        onChanged: (val) {
                          myShopProvider.selectOneProduct(
                              widget.pending.id, val!);
                        },
                        // ,
                        side: BorderSide.none,
                        // ,
                        fillColor:
                            myShopProvider.selectIds.contains(widget.pending.id)
                                ? null
                                : MaterialStateProperty.all(Colors.white),

                        // fillColor: MaterialStateProperty.,
                        // fillColor: const MaterialStateProperty(Colors.white),
                        checkColor: Colors.white,

                        activeColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      );
                    },
                  ),
                  Consumer<MyShopController>(
                    builder: (context, myShopProvider, child) => InkWell(
                      onTap: () async {
                        myShopProvider.selectOneProduct(
                            widget.pending.id, true);
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) =>
                                const ShowModalBottomSheetShop(
                                  delete: true,
                                ));
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).cardColor),
                        child: Center(
                          child: Image.asset(
                            Images.delete,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomImageWidget(
                        image: widget.pending.imageUrl,
                        height: 82,
                        width: 84,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 11,
                    child: Text(
                      widget.pending.name,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    // color: Theme.o/f(context).cardColor

                    ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: widget.pending.itemNumber));
                          showCustomSnackBar(
                            getTranslated('The_text_has_been_copied', context),
                            context,
                            isError: false,
                          );
                        },
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${getTranslated('Product_number', context)!} : ',
                              style: GoogleFonts.tajawal(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                widget.pending.itemNumber.toString(),
                                style: GoogleFonts.tajawal(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              Images.copyIcon,
                              width: 15,
                            )
                            // Icon(Ico)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: widget.pending.code));
                          showCustomSnackBar(
                            getTranslated('The_text_has_been_copied', context),
                            context,
                            isError: false,
                          );
                        },
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${getTranslated('Product_barcode_sku', context)!} : ",
                              style: GoogleFonts.tajawal(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                widget.pending.code,
                                style: GoogleFonts.tajawal(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              Images.copyIcon,
                              width: 15,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${getTranslated('cost', context)!} :',
                            style: GoogleFonts.tajawal(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              PriceConverter.convertPrice(
                                  context, widget.pending.pricings.value+(widget.pending.taxType=='percent'?((widget.pending.tax/100)*widget.pending.pricings.value):widget.pending.tax)),
                              style: GoogleFonts.tajawal(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),       Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${getTranslated('Amount_and_percentage_of_profit', context)!} :',
                            style: GoogleFonts.tajawal(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 5,),
                          Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(width: 1,color:profit>0?Colors.green: Colors.red)
                            ),
                            child: Center(
                              child: Text(PriceConverter.convertPrice(context,double.tryParse(profit.toStringAsFixed(2)))),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(width: 1,color: profit>0?Colors.green:Colors.red)
                            ),
                            child: Center(
                              child: Text('${percentage.toStringAsFixed(2)} %'),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 3.0),
                          //   child: Text(
                          //     PriceConverter.convertPrice(
                          //         context, widget.pending.pricings.value+(widget.pending.taxType=='percent'?((widget.pending.tax/100)*widget.pending.pricings.value):widget.pending.tax)),
                          //     style: GoogleFonts.tajawal(
                          //         fontSize: 16, fontWeight: FontWeight.w400),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${getTranslated('Suggested_selling_price', context)!} :',
                            style: GoogleFonts.tajawal(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              PriceConverter.convertPrice(context,
                                  widget.pending.pricings.suggestedPrice),
                              style: GoogleFonts.tajawal(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${getTranslated('Selling_price_in_my_store', context)!} :',
                            style: GoogleFonts.tajawal(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 150,
                            height:50,
                            child: ClipRRect(
                              child: TextFormField(
                                controller: widget.controller,
                                decoration: InputDecoration(
                                  hintText:  '${widget.controller.text} ر.س',
                                  hintStyle: GoogleFonts.tajawal(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: false),

                                  inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
                                ],
                                onChanged: (val){
                                  getProfit(double.parse(val));
                                },

                                textAlign: TextAlign.center,

                              )
                              // CustomTextFieldWidget(
                              //   controller: widget.controller,
                              //   maxLines: 1,
                              //   showBorder: true,
                              //
                              //   showLabelText: false,
                              //   // borderColor: Colors.black,
                              //   filled: true,
                              //   // borderColor: Colors.black,
                              //   labelText: '140 ر.س',
                              //
                              //   hintText: '140 ر.س',
                              //   isAmount: true,
                              // ),
                            ),
                          ),
                          // const SizedBox(width: 15,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
