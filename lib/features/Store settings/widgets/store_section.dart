import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
          horizontal: 15.0, vertical: 10),
      child: Consumer<StoreSettingController>(
        builder:(context, storeProvider, child) =>  Container(
          
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).iconTheme.color!.withOpacity(0.12),
                  offset: const Offset(6, 12),
                  blurRadius: 32,
                spreadRadius: 0
              )
            ],
            color:  storeProvider
                .activeSwitch[widget.index]?Theme.of(context).primaryColor:Theme.of(context).scaffoldBackgroundColor,
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
                        height: 40,
                        width: 40,
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
                        style:  TextStyle(
                          color: storeProvider
                              .activeSwitch[widget.index]?Colors.white:null ,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ),
                    const Spacer(),
                    // widget.store.appName=='salla'?
                    Consumer<StoreSettingController>(
                      builder:(context, storeProvider, child) =>  InkWell(
                        onTap: (){

                          if(storeProvider
                              .activeSwitch[widget.index]==false){
                            if(widget.store.appName=='salla'){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const WepView(
                                url:"${AppConstants.baseUrl}/salla/oauth/redirect" ,
                                check: false,
                                storeSetting: true,
                              ),));}else{
                              showBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) => Container(
                                    height: 250,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("${getTranslated('associated_store', context)}${widget.store.appName}",
                                            style: GoogleFonts.tajawal(
                                              color: storeProvider
                                                  .activeSwitch[widget.index]?Colors.white:null ,
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
                                                color: storeProvider
                                                    .activeSwitch[widget.index]?Colors.white:null ,
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
                            showBottomSheet(
                                context: context,

                                builder: (BuildContext context) => Container(

                                  height: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("${getTranslated('Doـyouـwantـtoـunlinkـtheـstore', context)}",
                                          style: GoogleFonts.tajawal(
                                            fontSize: 20,
                                            color: storeProvider
                                                .activeSwitch[widget.index]?Theme.of(context).iconTheme.color:null ,
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
                                                        storeProvider
                                                            .activeSwitch[widget.index], widget.index);
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
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: storeProvider
                                .activeSwitch[widget.index]?Colors.red:Colors.green
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Center(child:Text(storeProvider
                                .activeSwitch[widget.index]?getTranslated('Unlink', context)!:getTranslated("link", context)!,style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white
                            ),),),
                          ),
                        ),
                      )
                    ),
                        // :const SizedBox(),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    widget.store.appName=='salla'&&  widget.store.store!=null?   Expanded(
                      child: Text('${getTranslated('Link_status', context)!} : ${getTranslated('associatedـwith', context)!} ${widget.store.store!.name}',
                        style: GoogleFonts.tajawal(
                            fontSize: 16,
                            color: storeProvider
                                .activeSwitch[widget.index]?Colors.white:null ,
                            fontWeight: FontWeight.w500
                      
                        ),
                      ),
                    ):Expanded(
    child: Text('${getTranslated('Link_status', context)!} : ${getTranslated('Not_related', context)}',
    style: GoogleFonts.tajawal(
    fontSize: 16,
    color: Colors.white ,
    fontWeight: FontWeight.w500

    ),
    ),),
          

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15),
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
                            "application_key", context)} :',
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                            color: storeProvider
                                .activeSwitch[widget.index]?Colors.white:null ,
                            fontWeight: FontWeight.w600),
                      ),
                    ),



                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0),
                child: InkWell(
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
                        color: Colors.white,
                        border: Border.all(

                            width: 0.5,
                            color: Colors.grey)),

                    child:Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            widget.store
                                .token!=null?  widget.store
                                .token
                                .toString():'no key',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.black ,
                            ),
                            overflow: TextOverflow.visible),
                      ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Image.asset(Images.documentCopy,width: 20,height: 20,color: Colors.black,),
                            ),
                    ],)
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
