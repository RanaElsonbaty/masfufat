
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment/controller/payment_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment/widgets/checkout%20widget/payment_section.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/widgets/custom_check_box_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../localization/controllers/localization_controller.dart';
import '../../../main.dart';
import '../../checkout/widgets/payment_method_bottom_sheet_widget.dart';


class AddFundDialogueWidget extends StatefulWidget {
  const AddFundDialogueWidget({super.key, required this.focusNode, required this.inputAmountController});
  final FocusNode focusNode;
  final TextEditingController inputAmountController;

  @override
  State<AddFundDialogueWidget> createState() => _AddFundDialogueWidgetState();
}
List<PaymentMethod> paymentMethods=[];

class _AddFundDialogueWidgetState extends State<AddFundDialogueWidget> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<PaymentController>(Get.context!,listen: false).initSession(Get.context!);

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent,
      child: Padding(padding: const EdgeInsets.all(8.0),
        child: Consumer<CheckoutController>(
          builder: (context, digitalPaymentProvider,_) {
            return Consumer<SplashController>(
              builder: (context, configProvider,_) {
                return SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [


                    Container(decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),
                      child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeExtraLarge, Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeDefault),
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                                child: InkWell(onTap: () => Navigator.pop(context),
                                    child: Align(alignment: Alignment.topRight,child: Icon(Icons.cancel,
                                      color: Theme.of(context).hintColor, size: 30,))),),

                              Text(getTranslated('add_fund_to_wallet', context)!,
                                  style: GoogleFonts.tajawal(fontSize: 18)),
                              const SizedBox(width: 25,),
                            ],
                          ),
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,
                              bottom: Dimensions.paddingSizeDefault),
                            child: Text(getTranslated('add_fund_form_secured_digital_payment_gateways', context)!,
                                style: GoogleFonts.tajawal(fontSize: 14), textAlign: TextAlign.center),),





                          // Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,
                          //     top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault,
                          //     right: Dimensions.paddingSizeDefault),
                          //   child: Row(children: [
                          //     Text('${getTranslated('add_money_via_online', context)}',
                          //         style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeSmall)),
                          //     const SizedBox(width: 3,),
                          //     Text('${getTranslated('fast_and_secure', context)}',
                          //         style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeExtraSmall,
                          //             color: Theme.of(context).hintColor))])),


                          Consumer<PaymentController>(
                            builder:(context, paymentProvider, child) => Consumer<SplashController>(
                                builder: (context, configProvider,_) {
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:paymentProvider.paymentMethod.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return  CustomCheckBoxWidget(index: index,
                                        icon:paymentProvider.paymentMethod[index].image,
                                        name: paymentProvider.paymentMethod[index].name,
                                        id: paymentProvider.paymentMethod[index].id,
                                        title:'');
                                    },
                                  );
                                }),
                          ),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                              child: Container(decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                  border: Border.all(width: .5,color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                  Theme.of(context).hintColor : Theme.of(context).primaryColor.withOpacity(.5))),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [

                                    Provider.of<LocalizationController>(context,listen: false).isLtr?     Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(configProvider.myCurrency!.symbol,
                                          style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                                              color:  Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.75) )),
                                    ):const SizedBox(),
                                    Provider.of<LocalizationController>(context,listen: false).isLtr?   const SizedBox(width: 5,):const SizedBox.shrink(),

                                    Consumer<PaymentController>(
                                      builder:(context, paymentProvider, child) =>  IntrinsicWidth(child: TextField(
                                        controller: widget.inputAmountController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]+'))],
                                        textInputAction: TextInputAction.done,
                                        textAlign: TextAlign.center,
                                        onChanged: (val){
                                          paymentProvider.getAmount(val!=''?double.parse(val):0.00);

                                          // paymentProvider.initiate(context);
                                        },
                                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: InputBorder.none,
                                          hintText: '500',
                                        ),
                                      )),
                                    ),
                                    Provider.of<LocalizationController>(context,listen: false).isLtr==false?   const SizedBox(width: 5,):const SizedBox.shrink(),
                                    Provider.of<LocalizationController>(context,listen: false).isLtr==false?     Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(configProvider.myCurrency!.symbol,
                                          style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                                              color:  Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.75) )),
                                    ):const SizedBox(),

                                  ]))),

                          Consumer<PaymentController>(builder:(context, paymentProvider, child) => paymentProvider.isLoading==false? CheckOutPaymentSection( amount:widget.inputAmountController.text!=''?double.parse(widget.inputAmountController.text):0.0,):const CircularProgressIndicator()),

                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            child: Consumer<CheckoutController>(
                              builder:(context, checkout, child) =>  Consumer<PaymentController>(
                                builder:(context, paymentProvider, child) =>checkout.selectedDigitalPaymentMethodId!=1?  CustomButton(
                                  buttonText: getTranslated('add_fund', context)!,
                                  onTap: widget.inputAmountController.text.trim().isEmpty?null:() {

                                    if(widget.inputAmountController.text.trim().isEmpty){
                                      showCustomSnackBar('${getTranslated('please_input_amount', context)}', context);
                                    }else if(double.parse(widget.inputAmountController.text.trim()) <= 0){
                                      showCustomSnackBar('${getTranslated('please_input_amount', context)}', context);
                                    }else if(digitalPaymentProvider.paymentMethodIndex == -1){
                                      showCustomSnackBar('${getTranslated('please_select_any_payment_type', context)}', context);
                                    }else{
                                      paymentProvider.pay(context);
                                    }
                                  },
                                ):paymentProvider.build(context, false, true),
                              ),
                            ),
                          ),
                        ],),
                      ),
                    ),
                  ],),
                );
              }
            );
          }
        ),
      ),
    );
  }
}