import 'package:dotted_border/dotted_border.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/animated_custom_dialog_widget.dart';
import '../../../common/basewidget/custom_button_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import 'order_place_dialog_widget.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({super.key, required this.type, this.orderId=''});
  final String type;
  final String ?orderId;

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  void _callback(bool isSuccess, String message, String orderID, bool createAccount) async {
    if(isSuccess) {
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
      showAnimatedDialog(Get.context!, OrderPlaceDialogWidget(
        icon: Icons.check,
        title: getTranslated(createAccount ? 'order_placed_Account_Created' : 'order_placed', Get.context!),
        description: getTranslated('your_order_placed', Get.context!),
        isFailed: false,
      ), dismissible: false, willFlip: true);
    }else {
      showCustomSnackBar(message, Get.context!, isToaster: true);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<SplashProvider>(context,listen: false).initConfig(context);
    super.initState();
    getCardBank(    Provider.of<SplashController>(context,listen: false));
  }
  TextEditingController controller  =TextEditingController();
  List<SelectedListItem> card = [

  ];

  void getCardBank(SplashController splash){
    if( splash.configModel!=null&&    splash.configModel!.paymentMethods.bankTransfer.banks.isNotEmpty){
      for (var element in splash.configModel!.paymentMethods.bankTransfer.banks) {
        card.add(SelectedListItem(name: element.name,value: element.accountNumber));
      }
      // Provider.of<CheckoutController>(context,listen: false).getSelectBank(
      //     splash.configModel!.paymentMethods.bankTransfer.banks.first.name,false);
      // getDeatils( splash.configModel!.paymentMethods.bankTransfer.banks.first.name, splash.configModel!.paymentMethods.bankTransfer.banks.first.accountNumber.toString());

    }

  }
  String iBAN ='';
  String bankAccountNumber ='';
  String bankName ='';
  void getDeatils(String name,String cardID){
    for (var element in Provider.of<SplashController>(context,listen: false).configModel!.paymentMethods.bankTransfer.banks) {
      if(element.name==name||element.accountNumber==cardID){
        setState(() {
          bankAccountNumber=element.accountNumber;
          iBAN=element.iban;
          bankName=element.name;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Consumer<SplashController>(
        builder: (context, splash, child) => SizedBox(
          // height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width-100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // bank_Transfer
                      getTranslated('bank_transfer', context)!,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const SizedBox(
                          child: Icon(Icons.clear),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [

                              InkWell(
                                onTap: () {
                                  DropDownState(
                                    DropDown(
                                      bottomSheetTitle: const Text(
                                        '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      data: card
                                          .map((e) => SelectedListItem(
                                        value: e.value.toString(),
                                        name: e.name,
                                      ))
                                          .toList(),
                                      isSearchVisible: true,
                                      selectedItems: (selectedList) {
                                        if (selectedList.isNotEmpty) {
                                          splash.getSelectBank(
                                              selectedList.first.name,true);
                                          getDeatils(selectedList.first.name,selectedList.first.value.toString());
                                        }
                                      },
                                      enableMultipleSelection: false,
                                    ),
                                  ).showModal(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  child: Container(
                                    height: 38,
                                    width:  MediaQuery.of(context).size.width-150,
                                    decoration: BoxDecoration(
                                      // color: Colors.grey[500],
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8)),
                                    child:  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              splash.selectBank,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: (){
                            showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false,
                            );
                            Clipboard.setData(ClipboardData(
                                text:
                                bankName.toString()));
                          },
                          child: Image.asset(
                            Images.copy,
                            height: 20,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      bankName,
                      style: GoogleFonts.tajawal(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: (){
                        showCustomSnackBar(
                          getTranslated(
                              'The_text_has_been_copied',
                              context),
                          context,
                          isError: false,
                        );
                        Clipboard.setData(ClipboardData(
                            text:
                            bankAccountNumber.toString()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${getTranslated('Bank_account_number', context)} : $bankAccountNumber ',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.tajawal(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Image.asset(
                            Images.copy,
                            height: 15,
                            color: Theme.of(context).iconTheme.color,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        showCustomSnackBar(
                          getTranslated(
                              'The_text_has_been_copied',
                              context),
                          context,
                          isError: false,
                        );
                        Clipboard.setData(ClipboardData(
                            text:
                            iBAN.toString()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${getTranslated('IBAN_number_for_the_bank_account', context)} : $iBAN',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.tajawal(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Image.asset(
                            Images.copy,
                            height: 15,
                            color: Theme.of(context).iconTheme.color,
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hintText:
                    getTranslated('The_name_of_the_account_holder', context),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                        splash.pickImage();
                    },
                    child: DottedBorder(
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      color: Colors.grey,
                      child: Container(
                        height: 50,
                        width:MediaQuery.of(context).size.width-125,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return
                              // provider.attachment == null ?
                              Center(
                                child: Text(
                                  getTranslated(
                                      'Please_attach_the_transfer_receipt',
                                      context)!,
                                  style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                ));

                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 20),

              const SizedBox(
                height: 25,
              ),
              Consumer<SyncOrderController>(
                builder:(context, order, child) =>  Consumer<CheckoutController>(
                  builder:(context, checkOut, child) =>  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                                buttonText: getTranslated('cancel', context),
                                backgroundColor: Theme.of(context).hintColor,
                                onTap: () => Navigator.of(context).pop())),
                        const SizedBox(width: Dimensions.paddingSizeDefault),
                        Expanded(
                            child:  CustomButton(
                              buttonText: getTranslated('submit', context),
                              // textcolor: Colors.white,
                              onTap: () {
                                if(splash.bankTransferImage!=null&&controller.text.isNotEmpty){
                                  if(widget.type=='checkOut'){
                checkOut.createPaymentWithBankTransfer(context,splash.bankTransferImage! , controller.text, ).then((value) {

                  _callback(value.error != null ? false : true,
                      value.response!.data.toString(),'',false);
                  if(value.error != null ){
                     Provider.of<CartController>(Get.context!, listen: false).getCartData(Get.context!);
                    Provider.of<CartController>(Get.context!, listen: false).setCartData();
                  }


                });
                                  }else if(widget.type=='order'){
                order.bankAndDelayedPayment(widget.orderId!,'bank_transfer','',splash.bankTransferImage!,controller.text,context).then((value) {
                    _callback(value.error != null ? false : true,
                      value.response!.data.toString(),'',false);
                  Navigator.pop(context);

                });
                                  }
                                }
                                Navigator.pop(context);

                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
