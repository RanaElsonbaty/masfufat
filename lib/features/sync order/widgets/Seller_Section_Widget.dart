import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/domain/models/seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';

import '../../shop/controllers/shop_controller.dart';

class SyncSellerSectionWidget extends StatefulWidget {
  final SyncOrderController? order;
  const SyncSellerSectionWidget({super.key, this.order});

  @override
  State<SyncSellerSectionWidget> createState() => _SyncSellerSectionWidgetState();
}

class _SyncSellerSectionWidgetState extends State<SyncSellerSectionWidget> {
  SellerModel? sellerModel ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var element in Provider.of<ShopController>(context,listen: false).sellerModel!) {
      if(element.id==widget.order?.syncOrderDetails!.sellerId!){
     setState(() {
       sellerModel=element;
     });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return sellerModel!=null?Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      color: Theme.of(context).highlightColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(onTap: (){
          if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
            Provider.of<ChatController>(context, listen: false).setUserTypeIndex(context, 1);
            if(sellerModel != null){
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(
                id: sellerModel!.id,
                name:
                // order!.orderDetails![0].order?.sellerIs == 'admin' ?
                // "${Provider.of<SplashController>(context, listen: false).configModel?.companyName}"
                // :
                sellerModel!.name,
                userType: 1,
                image:
                // order!.orderDetails![0].order?.sellerIs == 'admin' ?
                // "${Provider.of<SplashController>(context, listen: false).configModel?.companyFavIcon?.path}"
                //     :
                sellerModel!.image,
              )));


            }else{
              showCustomSnackBar(getTranslated('seller_not_available', context), context,isToaster: true);
            }
          }else{
            showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=> const NotLoggedInBottomSheetWidget());}
        },
          child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: Row(children: [
              Icon(Icons.storefront_outlined, color: Theme.of(context).primaryColor, size: 20),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),

              if( widget.order != null && widget.order!.syncOrderDetails != null && widget.order!.syncOrderDetails != null&&sellerModel!=null)
                SizedBox(width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(maxLines: 1, overflow: TextOverflow.ellipsis,

                        '${sellerModel!.name} ',
                        style: textRegular.copyWith())),
              const Spacer(),
              SizedBox(width: Dimensions.iconSizeDefault, child: Image.asset(Images.chat))

            ]),
          ),
        ),
      ]),
    ):const SizedBox.shrink();
  }
}
