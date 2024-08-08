import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/controllers/store_setting_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../common/basewidget/webView.dart';
import '../../../localization/language_constrants.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/images.dart';
import '../domain/model/store_setting_model.dart';

class StoreSection extends StatefulWidget {
  const StoreSection({super.key, required this.store, required this.index});
final StoreSettingModel store;
final int index;
  @override
  State<StoreSection> createState() => _StoreSectionState();
}

class _StoreSectionState extends State<StoreSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 0.2, color: Colors.grey),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 6),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Image.asset(
                            Images.placeholder,
                            fit: BoxFit.cover,
                          ),
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                      imageUrl:widget.store
                          .logo!,
                      errorWidget: (c, o, s) =>
                          Image.asset(
                              Images.placeholder,
                              fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 11,
                    child: Text(
                      '${getTranslated("Link_with_the_platform", context)} ${widget.store.appName}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  widget.store.appName=='salla'?    Consumer<StoreSettingController>(
                    builder:(context, storeProvider, child) =>  Switch(
                      value: storeProvider
                          .activeSwitch[widget.index],
                      activeColor:
                      Theme.of(context).primaryColor,
                      onChanged: (value) {

                        if(value==true){
                          if(widget.store.appName=='salla'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WepView(
                              url:"${AppConstants.baseUrl}/salla/oauth/redirect" ,
                              check: false,
                              StoreSetting: true,
                            ),));}else{
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => Dialog(

                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("${getTranslated('associated_store', context)}${widget.store.appName}",
                                          style: GoogleFonts.tajawal(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child:  Text(getTranslated('Close', context)!,
                                            style: GoogleFonts.tajawal(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            );
                            //   associated_store
                          }
                        }else{
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Dialog(

                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${getTranslated('Doـyouـwantـtoـunlinkـtheـstore', context)}",
                                        style: GoogleFonts.tajawal(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {

                                              Navigator.pop(context);
                                            },
                                            child:  Text(getTranslated('NO', context)!,
                                              style: GoogleFonts.tajawal(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),),
                                          ),Consumer<StoreSettingController>(
                                            builder:(context, storeProvider, child) =>  TextButton(
                                              onPressed: () async{
                                                await storeProvider.unlinkLinkedAccount();
                                                await storeProvider.getLinkedProduct();
                                                if(storeProvider.isSucsses!){
                                                  showCustomSnackBar(
                                                      getTranslated(
                                                          'Theـstoreـhasـbeenـsuccessfullyـunlinked',
                                                          Get.context!),
                                                      Get.context!,
                                                      isError: true,
                                                      isToaster: false);
                                                  storeProvider.getActive(
                                                      value, widget.index);
                                                }

                                                Navigator.pop(Get.context!);
                                              },
                                              child:  Text(getTranslated('YES', context)!,
                                                style: GoogleFonts.tajawal(
                                                  fontSize: 18,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w700,
                                                ),),
                                            ),
                                          ),

                                        ],)
                                    ],
                                  ),
                                ),
                              )
                          );
                        }
                      },
                    ),
                  ):const SizedBox(),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 4),
                    child: Text(
                      '${ getTranslated(
                          "application_key", context)} ',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  InkWell(
                    onTap: () {
                      if(widget.store.token!=null){
                        showCustomSnackBar(
                            getTranslated(
                                'The_text_has_been_copied',
                                context),
                            context,
                            isError: false);
                        Clipboard.setData(ClipboardData(
                            text:
                            "${widget.store.token}"));}else{
                        showCustomSnackBar(
                            getTranslated(
                                'Thereـisـnoـapplicationـkeyـcurrently',
                                context),
                            context,
                            isError: true,isToaster: false);
                        // Thereـisـnoـapplicationـkeyـcurrently
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(8),
                          border: Border.all(
                              width: 0.3,
                              color: Colors.grey)),
                      child: const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.copy, size: 18),
                          // Image.asset(Images.co)
                          // SizedBox(
                          //   width: 3,
                          // ),
                          // Text(
                          //   getTranslated(
                          //     "Copy_the_application_key",
                          //     context,
                          //   ),
                          //   style: TextStyle(
                          //       fontWeight:
                          //           FontWeight.w600),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 25,),

                  widget.store.appName=='salla'&&  widget.store.store!=null?   Text(getTranslated('associatedـwith', context)!,
                    style: GoogleFonts.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
                  ):const SizedBox(),
                  const SizedBox(width: 5,),
                  widget.store.appName=='salla'&&  widget.store.store!=null?    Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WepView(
                          url:  widget.store.store!.domain ,
                          check: false,
                          StoreSetting: true,
                        ),));
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).primaryColor,

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text( widget.store.store!.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white
                            ),)),
                        ),
                      ),
                    ),
                  ):const SizedBox(),

                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(8),
                    border: Border.all(
                        width: 0.5,
                        color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      widget.store
                          .token!=null?  widget.store
                          .token
                          .toString():'no key',
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.visible),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
