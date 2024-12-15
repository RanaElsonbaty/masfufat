import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/models/sync_order_details.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/amount_widget.dart';
import '../../../common/basewidget/animated_custom_dialog_widget.dart';
import '../../../common/basewidget/custom_button_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../helper/price_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../address/controllers/address_controller.dart';
import '../../address/screens/saved_address_list_screen.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../checkout/controllers/checkout_controller.dart';
import '../../checkout/widgets/bank_transfer_bottom_sheet.dart';
import '../../checkout/widgets/choose_payment_widget.dart';
import '../../checkout/widgets/coupon_apply_widget.dart';
import '../../checkout/widgets/order_place_dialog_widget.dart';
import '../../checkout/widgets/shipping_details_widget.dart';
import '../../checkout/widgets/wallet_payment_widget.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../payment /controller/payment_controller.dart';
import '../../payment /widgets/checkout widget/payment_section.dart';
import '../../product_details/domain/models/product_details_model.dart';

class OrderCheckout extends StatefulWidget {
  const OrderCheckout({super.key, required this.orderDetailsModel, required this.products});
  final SyncOrderDetailsModel orderDetailsModel;
  final List<ProductDetailsModel> products;

  @override
  State<OrderCheckout> createState() => _OrderCheckoutState();
}

class _OrderCheckoutState extends State<OrderCheckout> {
  TextEditingController couponController =TextEditingController();
  double subTotal=0.00;
  double shippingFee=0.00;
  double discount=0.00;
  double couponDiscount=0.00;
  double tax=0.00;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddressController>(context, listen: false).getAddressList();

    Provider.of<PaymentController>(context,listen: false).getType('sync_order');
    Provider.of<PaymentController>(context,listen: false).getOrderId(widget.orderDetailsModel.id!.toString());
    Provider.of<PaymentController>(context,listen: false).getAmount(widget.orderDetailsModel.orderAmount!);

    Provider.of<PaymentController>(context,listen: false).getPaymentMethod(context,'sync_order');
    Provider.of<PaymentController>(context,listen: false).initiate(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: getTranslated('proceed', context)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: ShippingDetailsWidget(hasPhysical: false, billingAddress: true, passwordFormKey: GlobalKey<FormState>())),


            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall),
                child: Text(getTranslated('order_summary', context)??'',
                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),



            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Consumer<CheckoutController>(
                    builder: (context, checkoutController, child) {
                      subTotal=0.00;
                      shippingFee=0.00;
                      discount=0.00;
                      couponDiscount=0.00;
                      tax=0.00;
                      shippingFee=widget.orderDetailsModel.shippingCost!=null?double.parse(widget.orderDetailsModel.shippingCost!.toString()):0.00;

                      for (int i =0 ; i<widget.products.length;i++) {
                        subTotal=subTotal+((widget.products[i].unitPrice!=null?widget.products[i].unitPrice!:0.00)*(widget.orderDetailsModel.externalOrder!.qtys![i]));
                        discount=discount+(widget.products[i].discount!=null?widget.products[i].discount!:0.00);
                        // tax=tax+(widget.products[i].tax!=null?widget.products[i].tax!:0.00);
                        tax=tax+(widget.products[i].unitPrice!*(widget.products[i].tax!/100))*widget.orderDetailsModel.externalOrder!.qtys![i];

                      }
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        AmountWidget(title: '${getTranslated('sub_total', context)} ${' (${widget.products.length} ${getTranslated('items', context)}) '}',
                            amount: PriceConverter.convertPrice(context, subTotal)),
                        AmountWidget(title: getTranslated('shipping_fee', context),
                            amount: PriceConverter.convertPrice(context, shippingFee)),
                        AmountWidget(title: getTranslated('discount', context),
                            amount: PriceConverter.convertPrice(context, discount)),
                        AmountWidget(title: getTranslated('coupon_voucher', context),
                            amount: PriceConverter.convertPrice(context, couponDiscount)),
                        AmountWidget(title: getTranslated('tax', context),
                            amount: PriceConverter.convertPrice(context, tax)),
                        AmountWidget(title: getTranslated('Shipping_tax', context),
                            amount: PriceConverter.convertPrice(context, shippingFee*0.15  )),
                        Divider(height: 5, color: Theme.of(context).hintColor),
                        AmountWidget(title: getTranslated('total_payable', context),
                            amount: PriceConverter.convertPrice(context,
                                (subTotal + shippingFee - discount - couponDiscount + tax+(shippingFee*0.15)))),
                      ]);})),
            const SizedBox(height: 10,),


            if(Provider.of<AuthController>(context, listen: false).isLoggedIn())
              Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  child: CouponApplyWidget(couponController: couponController, orderAmount: (subTotal + shippingFee - discount - couponDiscount + tax))),



            const SizedBox(height: 10,),

            const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: ChoosePaymentWidget(onlyDigital: false)),

            Consumer<PaymentController>(builder:(context, paymentProvider, child) => paymentProvider.isLoading==false? const CheckOutPaymentSection( amount: 0,):const CircularProgressIndicator()),
            const SizedBox(height: 10,),
            Consumer<SyncOrderController>(
              builder:(context, syncOrderProvider, child) =>  Consumer<ProfileController>(
                builder:(context, profileProvider, child) =>  Consumer<PaymentController>(
                  builder:(context, paymentProvider, child) =>  Consumer<CheckoutController>(
                    builder:(context, checkout, child) => checkout.selectedDigitalPaymentMethodId!=1? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: syncOrderProvider.isLoading==false?CustomButton(onTap: ()async{
                        if(checkout.addressIndex == null ) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const SavedAddressListScreen()));
                          showCustomSnackBar(getTranslated('select_a_shipping_address', context), context, isToaster: true);
                          return 0;
                        }
                        int addressID=    checkout.addressIndex??0;

                        print(checkout.selectedDigitalPaymentMethodId);
                        syncOrderProvider.getLoading(true);
                        if(checkout.selectedDigitalPaymentMethodId==4){
                          showAnimatedDialog(context, WalletPaymentWidget(
                              currentBalance: profileProvider.balance ?? 0,
                              orderAmount: (subTotal + shippingFee - discount - couponDiscount + tax),
                              onTap: ()async{if(profileProvider.balance! <
                                  (subTotal + shippingFee - discount - couponDiscount + tax)){
                                showCustomSnackBar(getTranslated('insufficient_balance', context), context, isToaster: true);
                              } else{

                                await syncOrderProvider.placeSyncWalletOrder(widget.orderDetailsModel.id.toString()).then((value) {
                                  if(value.response!=null&&value.response!.statusCode==200){
                                    _callback(true,'','',false);
                                  }else{

                                  }
                                });



                              }}), dismissible: false, willFlip: true);
                        }else if(checkout.selectedDigitalPaymentMethodId==0){
                          try{
                            await   paymentProvider.pay(context).then((value) {
                              if(value==true){
                                _callback(true,'','',false);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }else{

                              }
                            });
                          }catch(e){
                            print(e);

                          }

                        }else if(checkout.selectedDigitalPaymentMethodId==3){
                          showAnimatedDialog(context,  BankTransfer(type: 'order',addressId: int.parse(addressID.toString()),orderId:widget.orderDetailsModel.id.toString() ,), dismissible: true, willFlip: true);

                        }
                        else if(checkout.selectedDigitalPaymentMethodId==5){
                          syncOrderProvider.placeSyncDelayedOrder(widget.orderDetailsModel.id.toString(),addressID.toString(),couponController.text,couponDiscount.toString(),'').then((value) {
                            if(value.response!=null&&value.response!.statusCode==200){
                              _callback(true,value.response!.data,'',false);

                            }else{
                              Navigator.pop(context);


                            }
                          });
                        }else if(checkout.selectedDigitalPaymentMethodId==2){
                          await syncOrderProvider.placeSyncOrderCashOnDelivery(widget.orderDetailsModel.id.toString(),couponController.text,couponDiscount.toString(),'',addressID).then((value) {
                            if(value.response!=null&&value.response!.statusCode==200){
                              _callback(true,value.response!.data,'',false);

                            }else{
                              Navigator.pop(context);


                            }
                          });
                        }
                        syncOrderProvider.getLoading(false);

                      },
                        buttonText: '${getTranslated('proceed', context)}',
                      ): Row(
                        mainAxisAlignment: MainAxisAlignment.center, children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),
                        )],),
                    ):paymentProvider.build(context, false,true),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],),
      ),
    );
  }
  void _callback(bool isSuccess, String message, String orderID, bool createAccount) async {
    if(isSuccess) {
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);

      showAnimatedDialog(context, OrderPlaceDialogWidget(
        icon: Icons.check,
        title: getTranslated(createAccount ? 'order_placed_Account_Created' : 'order_placed', context),
        description: getTranslated('your_order_placed', context),
        isFailed: false,
      ), dismissible: false, willFlip: true);
    }else {
      showCustomSnackBar(message, context, isToaster: true);
    }
  }

}
