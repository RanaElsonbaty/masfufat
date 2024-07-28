
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/controllers/wallet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/widgets/custom_check_box_widget.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent,
      child: Padding(padding: const EdgeInsets.all(8.0),
        child: Consumer<CheckoutController>(
          builder: (context, digitalPaymentProvider,_) {
            return Consumer<SplashController>(
              builder: (context, configProvider,_) {
                return SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                      child: InkWell(onTap: () => Navigator.pop(context),
                          child: Align(alignment: Alignment.topRight,child: Icon(Icons.cancel,
                            color: Theme.of(context).hintColor, size: 30,))),),

                    Container(decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),
                      child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeExtraLarge, Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeDefault),
                        child: Column(children: [
                          Text(getTranslated('add_fund_to_wallet', context)!,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,
                              bottom: Dimensions.paddingSizeDefault),
                            child: Text(getTranslated('add_fund_form_secured_digital_payment_gateways', context)!,
                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),),


                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            child: Container(decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                              border: Border.all(width: .5,color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                              Theme.of(context).hintColor : Theme.of(context).primaryColor.withOpacity(.5))),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(configProvider.myCurrency!.symbol!,
                                        style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                                            color:  Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.75) )),
                                  ),

                                IntrinsicWidth(child: TextField(
                                  controller: widget.inputAmountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]+'))],
                                  textInputAction: TextInputAction.done,
                                  textAlign: TextAlign.center,
                                  style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: 'Ex: 500',
                                  ),
                                )),
                              ]))),


                          Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,
                              top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault,
                              right: Dimensions.paddingSizeDefault),
                            child: Row(children: [
                              Text('${getTranslated('add_money_via_online', context)}',
                                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                              Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                                child: Text('${getTranslated('fast_and_secure', context)}',
                                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context).hintColor)))])),


                          Consumer<SplashController>(
                              builder: (context, configProvider,_) {
                                paymentMethods =[
                                  if(configProvider.configModel!.paymentMethods.delayed.enabled)
                                    PaymentMethod(  configProvider.configModel!.paymentMethods.delayed.name.toString(),   configProvider.configModel!.paymentMethods.delayed.logo, 0),
                                  if(configProvider.configModel!.paymentMethods.wallet.enabled)
                                    PaymentMethod(  configProvider.configModel!.paymentMethods.wallet.name.toString(),   configProvider.configModel!.paymentMethods.wallet.logo, 1),
                                  if(configProvider.configModel!.paymentMethods.fatoorah.enabled==1)
                                    PaymentMethod(  configProvider.configModel!.paymentMethods.fatoorah.name.toString(),   configProvider.configModel!.paymentMethods.fatoorah.logo, 2),
                                  if(configProvider.configModel!.paymentMethods.bankTransfer.enabled==1)
                                    PaymentMethod(  configProvider.configModel!.paymentMethods.bankTransfer.name.toString(),   configProvider.configModel!.paymentMethods.bankTransfer.logo, 2),
                                  if(configProvider.configModel!.paymentMethods.cashOnDelivery.enabled)
                                    PaymentMethod(  configProvider.configModel!.paymentMethods.cashOnDelivery.name.toString(),   configProvider.configModel!.paymentMethods.cashOnDelivery.logo, 2),

                                ];
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount:paymentMethods.length??0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index){
                                    return  CustomCheckBoxWidget(index: index,
                                      icon:paymentMethods[index].image,
                                      name: paymentMethods[index].name,
                                      title:'');
                                  },
                                );
                              }),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            child: CustomButton(
                              buttonText: getTranslated('add_fund', context)!,
                              onTap: () {
                                // if(digitalPaymentProvider.selectedDigitalPaymentMethodName.isEmpty){
                                //   digitalPaymentProvider.setDigitalPaymentMethodName(0,
                                //       configProvider.configModel!.paymentMethods![0].keyName!);
                                // }
                                if(widget.inputAmountController.text.trim().isEmpty){
                                  showCustomSnackBar('${getTranslated('please_input_amount', context)}', context);
                                }else if(double.parse(widget.inputAmountController.text.trim()) <= 0){
                                  showCustomSnackBar('${getTranslated('please_input_amount', context)}', context);
                                }else if(digitalPaymentProvider.paymentMethodIndex == -1){
                                  showCustomSnackBar('${getTranslated('please_select_any_payment_type', context)}', context);
                                }else{
                                  Provider.of<WalletController>(context, listen: false).addFundToWallet(widget.inputAmountController.text.trim(), digitalPaymentProvider.selectedDigitalPaymentMethodName);
                                }
                              },
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