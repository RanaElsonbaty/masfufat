import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/screens/order_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/widgets/Order_Details_Status_Widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../sync order/screens/sync_orde_details.dart';

class GuestTrackOrderScreen extends StatefulWidget {
  const GuestTrackOrderScreen({super.key});

  @override
  State<GuestTrackOrderScreen> createState() => _GuestTrackOrderScreenState();
}

class _GuestTrackOrderScreenState extends State<GuestTrackOrderScreen> {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(Provider.of<OrderController>(context,listen: false).orderModel==null){
      Provider.of<OrderController>(context,listen: false).getOrderList(1, 'all');
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('TRACK_ORDER', context)),
      body: Consumer<OrderDetailsController>(
        builder: (context, orderTrackingProvider, _) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Form(
              key: formKey,
              child: ListView(children: [
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Row(
                  children: [
                    Text(getTranslated('order_number', context)!,style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    ),)
                  ],
                ),
                CustomTextFieldWidget(controller: orderIdController,
                  prefixIcon: Images.orderIdIcon,
                  isAmount: true,
                  backGroundColor: const Color(0xffEFECF5),
                  inputType: TextInputType.phone,
                  showLabelText: false,
                  hintText: getTranslated('order_id', context),
                  labelText: getTranslated('order_id', context),
                  required: true,
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'order_id_is_required'),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                // CustomTextFieldWidget(
                //   isAmount: true,
                //   inputType: TextInputType.phone,
                //   prefixIcon: Images.callIcon,
                //   controller: phoneNumberController,
                //   inputAction: TextInputAction.done,
                //   hintText: '123 1235 123',
                //   required: true,
                //   labelText: '${getTranslated('phone_number', context)}',
                //   validator: (value)=> ValidateCheck.validateEmptyText(value, 'phone_number_is_required'),
                //
                // ),
                // const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                Consumer<OrderController>(
                  builder:(context, orderProvider, child) =>  CustomButton(
                    isLoading: orderTrackingProvider.searching,
                    buttonText: '${getTranslated('TRACK_ORDER', context)}',
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      String orderId = orderIdController.text.trim();
                      bool syncOrder=true;
                      syncOrder= getOrderType(orderProvider,orderId);
                      // print(syncOrder);
                          await orderTrackingProvider.trackOrder(
                              orderId: orderId.toString(), isUpdate: true)
                              .then((value) {
                            if (value.response?.statusCode == 200) {
                              if (value.response?.data != null) {
                                if(syncOrder==false){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (_) =>
                                      OrderSyncDetailsScreen(orderId: int.parse(orderId),)));
                                }else{
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (_) =>
                                    OrderDetailsScreen(
                                      fromTrack: false,
                                      orderId: int.parse(
                                          orderIdController.text.trim()),

                                    )));
                                }
                              }
                            }else{
                              showCustomSnackBar(getTranslated('order_not_found', context), context,isError: true);
                            }
                          });

                    },
                  ),
                ),

              ]),
            ),
          );
        }
      )
    );
  }
  bool getOrderType(OrderController orderProvider,String orderId){
    if (orderProvider.orderModel != null) {
      print('not null');
      // Check if any element matches the condition
      return orderProvider.orderModel!.any((element) => element.id.toString() == orderId);
    }

    return false;
  }
}
