import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/domain/models/notification_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


class NotificationDialogWidget extends StatelessWidget {
  final NotificationItemModel notificationModel;
  const NotificationDialogWidget({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Material(child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: Dimensions.paddingSizeDefault,),

          InkWell(onTap: ()=>Navigator.of(context).pop(),
            child: Container(width: 40,height: 5,decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(20)))),
          const SizedBox(height: 20,),


            // notificationModel.image != "null"?
            // Container(height: 100, width: 100,
            //   margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            //   decoration: BoxDecoration( color: Theme.of(context).primaryColor.withOpacity(0.20),borderRadius: BorderRadius.circular(12)),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(12),
            //     child: CustomImageWidget(image: '${notificationModel.image}',
            //       height:50, width: 50),
            //   )):
            // const SizedBox(),
            // const SizedBox(height: Dimensions.paddingSizeLarge),

            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Text(notificationModel.title!, textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeLarge+15))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: HtmlWidget(notificationModel.description!,textStyle: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w400
          ), onTapUrl: (String url) {
            return launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
          }),
        ),
            // Padding(padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            //   child: Text(notificationModel.description!, textAlign: TextAlign.center,
            //       style: titilliumRegular.copyWith(
            //         fontSize: 24
            //       ))),
        Padding(padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(DateConverter.isoStringToLocalDateAndTime(notificationModel.createdAt!), textAlign: TextAlign.center,
                style: titilliumRegular.copyWith(
                    // fontSize: 25
                ))),

          const SizedBox(height: Dimensions.paddingSizeSmall)
          ],
        ),
    ),
    );
  }
}
