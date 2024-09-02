import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class MenuButtonWidget extends StatelessWidget {
  final String image;
  final String? title;
  final Widget navigateTo;
  final bool isNotification;
  final bool isProfile;
  const MenuButtonWidget({super.key, required this.image, required this.title, required this.navigateTo,
    this.isNotification = false, this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: isNotification? Consumer<NotificationController>(
            builder: (context, notificationController, _) {
              return CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,
                child: Text(notificationController.totalNotification.toString(),
                    style: textRegular.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeSmall)),
              );}):

        isProfile? Consumer<ProfileController>(
            builder: (context, profileProvider, _) {
              return CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,
                  child: Text('profileProvider.userInfoModel?.referCount.toString()',
                      style: textRegular.copyWith(color: ColorResources.white,
                          fontSize: Dimensions.fontSizeSmall)));}):
        const Icon(Icons.arrow_forward_ios_sharp,size: 15,),


        leading: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).primaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(image, width: 20, height: 20, fit: BoxFit.contain,
              color: Colors.white,),
          ),
        ),

        title: Text(title!, style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
        // trailing: const Icon(Icons.arrow_forward_ios_sharp,size: 15,),
        // subtitle: ,

        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => navigateTo)));
  }
}