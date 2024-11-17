import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/domain/models/notification_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/widget/notification_dialog_widget.dart';
import 'package:provider/provider.dart';

class NotificationItemWidget extends StatefulWidget {
  final NotificationItemModel notificationItem;
  final int index;
  const NotificationItemWidget({super.key, required this.notificationItem, required this.index});

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  bool seen=false;
  void initSeen(){
  int userId=  Provider.of<ProfileController>(context,listen: false).userInfoModel!.id;
  for (var element in widget.notificationItem.seen!) {
    if(element==userId.toString()){
      seen=true;
    }
    // print(widget.notificationItem.seen_by);
  }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();initSeen();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap:(){
      Provider.of<NotificationController>(context, listen: false).seenNotification(widget.notificationItem.id!,widget.index,);
      showModalBottomSheet(backgroundColor: Colors.transparent,
          context: context, builder: (context) =>
              NotificationDialogWidget(notificationModel: widget.notificationItem));},
        child: Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
            color: Theme.of(context).cardColor,
            child: ListTile(leading: Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(40),
                  child: Container(decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.15), width: .35),
                      borderRadius: BorderRadius.circular(40)),
                      child: CustomImageWidget(width: 50,height: 50,
                          image: '${widget.notificationItem.image}'))),



              if(widget.notificationItem.seen == null)
                CircleAvatar(backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.75),radius: 3)]),
                title: Text(widget.notificationItem.title??'',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

                subtitle: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(widget.notificationItem.createdAt!)),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                        color: ColorResources.getHint(context))),
              trailing:seen==false? Icon(Icons.remove_red_eye,color: Colors.green.shade500,size: 20,):SizedBox(),
            )
        
        
        ));
    
  }
}