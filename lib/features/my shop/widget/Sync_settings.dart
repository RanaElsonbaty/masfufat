import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../chat/controllers/chat_controller.dart';

class SyncSettings extends StatefulWidget {
  const SyncSettings({super.key});

  @override
  State<SyncSettings> createState() => _SyncSettingsState();
}

class _SyncSettingsState extends State<SyncSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('Sync_settings', context),
      onBackPressed: () {
Navigator.pop(context,);

      },),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15  ,vertical: 30),
        child: Consumer<MyShopController>(
          builder:(context, myShop, child) =>  Column(children: [
            Row(
              children: [
                Expanded(
                  child: Text(getTranslated('Show_Cost_Price_Tax_Total_Cost_to_clearly_know_the_cost_of_the_product', context)!,
                    overflow: TextOverflow.visible ,
                    style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w400,
                  ),),
                ),
                Switch(value: myShop.switch1, onChanged:(val){
                  myShop.getSwitchState(0,val);
                },
                  activeTrackColor: Theme.of(context).primaryColor,
                  inactiveTrackColor: Colors.white,
                  splashRadius: 0,
                  trackOutlineColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  trackOutlineWidth: const MaterialStatePropertyAll(0),
                  hoverColor: Colors.white,
                  activeColor: Colors.white, // Optional, but recommended for a more contrasting look
                  inactiveThumbColor: Theme.of(context).primaryColor,
                )
              ],
            ),
            const SizedBox(height: 10,),
            const Divider(color: Colors.grey,),
            const SizedBox(height: 10,),


            Row(
              children: [
                Expanded(
                  child: Text(getTranslated('Have_you_enabled_VAT_in_your_store_through_your_platform_settings', context)!,
                    overflow: TextOverflow.visible ,
                    style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w400,
                  ),),
                ),
                Switch(value:  myShop.switch2, onChanged:(val){
                  myShop.getSwitchState(1, val);
                },
                  activeTrackColor: Theme.of(context).primaryColor,
                  inactiveTrackColor: Colors.white,
                  splashRadius: 0,
                  trackOutlineColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  trackOutlineWidth: const MaterialStatePropertyAll(0),
                  hoverColor: Colors.white,
                  activeColor: Colors.white, // Optional, but recommended for a more contrasting look
                  inactiveThumbColor: Theme.of(context).primaryColor,

                )


              ],
            ),
            const SizedBox(height: 5,),

            myShop.switch2?   Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).primaryColor
              ),
              child: Row(children: [
                const SizedBox(width: 5,),

                Expanded(
                  flex: 3,
                  child: Text(getTranslated('You_have_VAT_in_your_store', context)!,
                    overflow: TextOverflow.visible ,
                    style: GoogleFonts.tajawal(
                        fontSize: 14,fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),),
                ),
                 Expanded(
                   flex: 2,
                  child:TextField(
                    controller: myShop.taxController,
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      setState(() {

                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]+'))
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
border: InputBorder.none,
fillColor: Theme.of(context).cardColor,
                    filled: true,
                    hintText: '20',
                    hintStyle: GoogleFonts.tajawal(
                    color: Colors.grey,
                    fontSize: 16.0,
                    ),
                  ),
                 )
                  // CustomTextFieldWidget(
                  //   hintText: '20',
                  //   controller: myShop.taxController,
                  //   showLabelText: false,
                  //   textAlign: TextAlign.center,
                  //   inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]+'))],
                  //
                  // ),
                ),
              ],),
            ):const SizedBox.square(),
            const SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: Text(getTranslated('Note', context)!,
                    overflow: TextOverflow.visible ,
                    style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w400,color: Colors.red
                    ),),
                ),

              ],
            ),
            const SizedBox(height: 10,),

            const Divider(color: Colors.grey,),
            const SizedBox(height: 10,),

            Row(
              children: [
                Expanded(
                  child: Text(getTranslated('Allow_sync_if_profit_ratio_is_less_than', context)!,
                    overflow: TextOverflow.visible ,
                    style: GoogleFonts.tajawal(
                    fontSize: 16,fontWeight: FontWeight.w400,
                  ),),
                ),
                Switch(value: myShop.switch3, onChanged:(val){
                  myShop.getSwitchState(2, val);

                },
                  activeTrackColor: Theme.of(context).primaryColor,
                  inactiveTrackColor: Colors.white,
                  splashRadius: 0,
                  trackOutlineColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  trackOutlineWidth: const MaterialStatePropertyAll(0),
                  hoverColor: Colors.white,
                  activeColor: Colors.white, // Optional, but recommended for a more contrasting look
                  inactiveThumbColor: Theme.of(context).primaryColor,

                )

              ],
            ),
          ],),
        ),
      ),
    );
  }
}
