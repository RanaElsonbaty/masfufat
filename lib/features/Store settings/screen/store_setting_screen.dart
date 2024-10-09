import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/controllers/store_setting_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

import '../widgets/Store_Settings_shimmer.dart';
import '../widgets/store_section.dart';

class StoreSettingScreen extends StatefulWidget {
  const StoreSettingScreen({super.key});

  @override
  State<StoreSettingScreen> createState() => _StoreSettingScreenState();
}

class _StoreSettingScreenState extends State<StoreSettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<StoreSettingController>(context,listen: false)
        .getLinkedProduct()
        .then((value) {
      Provider.of<StoreSettingController>(context,listen: false).getLen(
          Provider.of<StoreSettingController>(context,listen: false)
              .linkedAccountsList.first.storeDetails!=null
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreSettingController>(
      builder:(context, storeProvider, child) =>  RefreshIndicator(
        onRefresh: ()async{
          storeProvider
              .getLinkedProduct(
            )
              .then((value) {
            storeProvider.getLen(
                storeProvider
                    .linkedAccountsList.first.storeDetails!=null
            );
          });
        },
        color: Theme.of(context).primaryColor,
        child: Scaffold(
          appBar: CustomAppBar(title:getTranslated('Settings_for_linking_my_online_store', context),

          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
             clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Consumer<StoreSettingController>(
              builder:(context, storeProvider, child) =>storeProvider.isLoading==false? storeProvider.linkedAccountsList.isNotEmpty?  Column(children: [
                        ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
                itemCount:  storeProvider.linkedAccountsList.length,
              itemBuilder: (context, index) {

              return StoreSection(store:  storeProvider.linkedAccountsList[index], index: index,);
                        },)
              ],):const NoInternetOrDataScreenWidget(isNoInternet: false):const StoreSettingsShimmer(),
            ),
          ),
        ),
      ),
    );
  }
}
