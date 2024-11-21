import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/widget/show_Modal_Bottom_Sheet.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../splash/controllers/splash_controller.dart';
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

      getProfit(double.parse(widget.controller.text)??0.00);


    super.initState();
  }
 @override
  void didUpdateWidget(covariant SyncProductWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
      getProfit(double.parse(widget.controller.text));
  }
TextEditingController profit =TextEditingController(text: '0');
TextEditingController percentage =TextEditingController(text: '0');




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
          child: Consumer<MyShopController>(
            builder:(context, myShopProvider, child) =>  Column(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${getTranslated('cost', context)!} :${PriceConverter.convertPrice(
                                                  context, widget.pending.pricings.value)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.tajawal(
                                    fontSize:  myShopProvider.switch1?14:16, fontWeight: FontWeight.w400),
                              ),
                            ),


                            myShopProvider.switch1?    Expanded(
                              flex: 1,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${getTranslated('tax', context)!} :',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: PriceConverter.convertPrice(
                                          context,
                                         ((widget.pending.taxType == 'percent' ||
                                              widget.pending.taxType != null)
                                              ? ((widget.pending.tax / 100) * widget.pending.pricings.value)
                                              : widget.pending.tax)
                                              ),
                                      style: GoogleFonts.tajawal(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ):const SizedBox.square(),

                            myShopProvider.switch1?  Expanded(
                              child: Text.rich(
                                TextSpan(
                                    children: [
                                TextSpan(
                                text: '${getTranslated('total', context)!} :',
                                style: GoogleFonts.tajawal(
                                  fontSize: 14, fontWeight: FontWeight.w400,
                                ),
                              ),
                                      TextSpan(
                                        text: PriceConverter.convertPrice(
                                          context,
                                       (widget.pending.pricings.value +
                                              (widget.pending.taxType == 'percent' ||
                                                  widget.pending.taxType != null
                                                  ? ((widget.pending.tax / 100) *
                                                  widget.pending.pricings.value)
                                                  : widget.pending.tax)
                                              ),),
                                          style: GoogleFonts.tajawal(
                                            fontSize: 14, fontWeight: FontWeight.w400,
                                            color: Colors.green.shade500
                                          ),
                              
                                        ),
                                        ],

                                      ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                    ),
                            ):const SizedBox.shrink(),
                          ],
                        ),

                        const SizedBox(
                          height: 5,
                        ),       Row(
                          children: [
                            SizedBox(
                              width: 110  .w,
                              child: Text(
                                '${getTranslated('Amount_and_percentage_of_profit', context)!} :',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.tajawal(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Container(
                                height: 35,
                                // width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1,color:double.parse(profit.text)>0?Colors.green: Colors.red)
                                ),
                                child: TextField(
                                  controller: profit,
                                  textAlign: TextAlign.center,

                                  onSubmitted: (val){
                                    getPriceFromProfit(double.parse(val),widget.pending.linkedProduct.price>0.00?widget.pending.linkedProduct.price:widget.pending.pricings.suggestedPrice);
                                  },
                                  onChanged: (val){
                                    getPriceFromProfit(double.parse(val),widget.pending.linkedProduct.price>0.00?widget.pending.linkedProduct.price:widget.pending.pricings.suggestedPrice);

                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Allow digits and decimal point
                                  ],
                                  decoration:  InputDecoration(

                                      suffix: Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),

                                        child: Text(Provider.of<SplashController>(context, listen: false).myCurrency!.symbol,style: TextStyle(color: Theme.of(context).iconTheme.color,height: .8),),
                                      ),
                                    border: InputBorder.none
                                  ),
                                )
                                // Text(PriceConverter.convertPrice(context,double.tryParse(profit.toStringAsFixed(2)))),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Container(
                                height: 35,
                                // width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(width: 1,color: double.parse(profit.text)>0?Colors.green:Colors.red)
                                ),
                                child: TextField(
                                  controller:percentage,

                                  textAlign: TextAlign.center,
                                  onSubmitted: (val){
                                    getProfitFromPercentage(double.parse(val),widget.pending.pricings.value);
                                  },

                                  onChanged: (val){
                                    getProfitFromPercentage(double.parse(val),widget.pending.pricings.value);

                                  }, inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Allow digits and decimal point
                                ],
                                  decoration:  InputDecoration(

                                      suffix: Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Text('%',style: TextStyle(color: Theme.of(context).iconTheme.color,height: .8),),
                                      ),
                                      border: InputBorder.none
                                  ),
                                )
                                // Center(
                                //   child: Text('${percentage.toStringAsFixed(2)} %'),
                                // ),
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
                                    hintText:  '${widget.controller.text} ',
                                    hintStyle: GoogleFonts.tajawal(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey
                                    ),
                                    suffix: Padding(
                                      padding: const EdgeInsets.only(left: 5.0,right: 5),

                                      child: Text(Provider.of<SplashController>(context, listen: false).myCurrency!.symbol,style:  TextStyle(color:  Theme.of(context).iconTheme.color,height: .8),),
                                    ),

                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                    ),
                                  ),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: false),

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Allow digits and decimal point
                                  ],
                                  onChanged: (val){
                                    if(val!=''&&val.isNotEmpty){
                                      getProfit(double.parse(val));

                                    }else{
                                      getProfit(0);

                                    }

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
                        const SizedBox(height: 5,),
                        Row(children: [
                          myShopProvider.switch2?    Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${getTranslated('tax', context)!} :',
                                style: GoogleFonts.tajawal(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                PriceConverter.convertPrice(
                                    context, double.parse(((((double.parse(myShopProvider.taxController.text)/100)*double.parse(widget.controller.text)))).toStringAsFixed(2))),
                                style: GoogleFonts.tajawal(
                                    color: Colors.red,
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ):const SizedBox.square(),
                          const SizedBox(width: 5,),

                          myShopProvider.switch2?  Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${getTranslated('total', context)!} :',
                                style: GoogleFonts.tajawal(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  PriceConverter.convertPrice(
                                      context, double.parse((double.parse(widget.controller.text)+(((double.parse(myShopProvider.taxController.text)/100)*double.parse(widget.controller.text)))).toStringAsFixed(2))),
                                  style: GoogleFonts.tajawal(
                                      color: Colors.green,
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ):const SizedBox.shrink(),
                        ],)
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
      ),
    );
  }
  void getProfit(double val) {
    MyShopController myShop=Provider.of<MyShopController>(context,listen: false);
    
    if(myShop.switch2){
      // double tax =(double.parse(myShop.taxController.text)/100)*double.parse(widget.controller.text);
      val= val ;
    //   +tax
    }


      double value =0.0;
    value = widget.pending.pricings.value
        +
        (widget.pending.taxType == 'percent' || widget.pending.taxType != null
            ? ((widget.pending.tax / 100) * widget.pending.pricings.value)
            : widget.pending.tax);
print(val);
    setState(() {
      profit.text = (val - value).toStringAsFixed(2);
      percentage.text = ((double.parse(profit .text)/ (value)) * 100).toStringAsFixed(2);
    });

  }
  void getPriceFromProfit(double val,double price) {
    MyShopController myShop=Provider.of<MyShopController>(context,listen: false);

    if(myShop.switch2){
      double tax =(double.parse(myShop.taxController.text)/100)*double.parse(widget.controller.text);
      val= val;
          // +tax;
    }

    double value =0.0;
    // value = price;
    value = price
        +
        (widget.pending.taxType == 'percent' || widget.pending.taxType != null
            ? ((widget.pending.tax / 100) * price)
            : widget.pending.tax);


    setState(() {
      // profit.text=(val.toStringAsFixed(2));
    widget.controller.text=(value+val).toStringAsFixed(2);
    percentage.text = ((double.parse(profit.text) / (value)) * 100).toStringAsFixed(2);
    });


  }





  void getProfitFromPercentage(double val,double price) {
    MyShopController myShop=Provider.of<MyShopController>(context,listen: false);

    // if(myShop.switch2){
    //   double tax =(double.parse(myShop.taxController.text)/100)*double.parse(widget.controller.text);
    //   val= val;
    //       +tax;
    // }

    double value =0.0;
    value = price
    // ;
        +
        (widget.pending.taxType == 'percent' || widget.pending.taxType != null
            ? ((widget.pending.tax / 100) * widget.pending.pricings.value)
            : widget.pending.tax);

    setState(() {
      // percentage.text=val.toString();

      profit .text=((val*value)/100).toStringAsFixed(2);
      widget.controller.text=(double.parse(profit.text) +value).toStringAsFixed(2);
    });


  }
}
