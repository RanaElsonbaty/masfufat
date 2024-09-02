import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class FaqScreen extends StatefulWidget {
  final String? title;
  const FaqScreen({super.key, required this.title});

  @override
  FaqScreenState createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {
  // List<bool> isExpanded = [];
  @override
  Widget build(BuildContext context) {
    // var splashController = Provider.of<SplashController>(context, listen: false);
    // isExpanded=List.filled(splashController.configModel!.faq.isNotEmpty?splashController.configModel!.faq.length:0, false);
    return Scaffold(
      body: Consumer<SplashController>(
        builder:(context, splashController, child) =>  Column(children: [
          CustomAppBar(title: widget.title),

          splashController.configModel!.faq.isNotEmpty? Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                itemCount: Provider.of<SplashController>(context, listen: false).configModel!.faq.length,
                itemBuilder: (ctx, index){
                  return  Consumer<SplashController>(
                    builder: (ctx, faq, child){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Flexible(child: ExpansionTile(

                                  collapsedShape: const ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    side: BorderSide(width: 1,color: Colors.grey),
                                  ),
                                  shape: const ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    side: BorderSide(width: 1,color: Colors.grey),

                                  ),
                                onExpansionChanged: (val){
                                  splashController.getIsExpanded(index,val);

                                },
                                  collapsedBackgroundColor: Theme.of(context).cardColor,
                                  expandedAlignment: Alignment.topLeft,
                                  trailing: Icon(splashController.isExpanded[index]==false?Icons.add:Icons.minimize),
                                  iconColor: Theme.of(context).primaryColor,
                                  title: Text(faq.configModel!.faq[index].question,
                                      style: GoogleFonts.tajawal(fontWeight: FontWeight.w500,fontSize: 16)),
                                  // leading: Icon(Icons.collections_bookmark_outlined,color:ColorResources.getTextTitle(context)),
                                  children: [
                                    Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: Dimensions.paddingSizeSmall),
                                      child: Text(faq.configModel!.faq[index].answer,

                                          style: GoogleFonts.tajawal(
                                        fontSize: 16,fontWeight: FontWeight.w400,
                                      ), textAlign: TextAlign.start))])),
                              ]),
                          ],),
                      );
                    },
                  );
                }),
          ): const NoInternetOrDataScreenWidget(isNoInternet: false)

        ],),
      ),
    );
  }
}
