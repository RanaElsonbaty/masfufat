import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/priority_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/support_ticket_type_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/types_model_bottom_sheet_widget.dart';

class AddTicketScreen extends StatefulWidget {

  const AddTicketScreen({super.key, });

  @override
  AddTicketScreenState createState() => AddTicketScreenState();
}

class AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _issueTypeController = TextEditingController();
  final FocusNode _subjectNode = FocusNode();
  List<TicketModel> issueTypeList = [
    TicketModel(Images.websiteProblem, 'website_problem'),
    TicketModel(Images.partnerRequest, 'partner_request'),
    TicketModel(Images.complaint, 'complaint'),
    TicketModel(Images.infoQuery, 'info_inquiry'),
  ];

  final FocusNode _descriptionNode = FocusNode();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('add_new_ticket', context),),
      body: Consumer<SupportTicketController>(
        builder: (context, supportTicketProvider, _) {
          return ListView(physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge), children: [

            // Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeTwelve),
            //     decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(.125),
            //         border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.15)),
            //         borderRadius: BorderRadius.circular(Dimensions.paddingSizeEight)),
            //     margin:  const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
            //     child: Row(children: [
            //       // SizedBox(width: 20, child: Image.asset(widget.ticketModel.icon)),
            //       Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            //           child: Text(getTranslated(widget.ticketModel.title, context)!, style: GoogleFonts.tajawal()))])),


      Row(
        children: [
          Text(getTranslated('the_topic', context)!,style: GoogleFonts.tajawal(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),)
        ],
      ),
            const SizedBox(height: 5,),
            Padding(padding: const EdgeInsets.only(bottom:Dimensions.homePagePadding),
              child: InkWell(onTap: ()=> showModalBottomSheet(backgroundColor: Colors.transparent,
                  context: context, builder: (_)=> const TypeModelBottomSheetWidget()),
                child: Container(width: MediaQuery.of(context).size.width * .5, height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).cardColor, border: Border.all(color: Theme.of(context).hintColor.withOpacity(.5))),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Row(children: [
                        Expanded(child: Text(supportTicketProvider.selectedType, maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,color: Colors.grey.shade700))),
                        const Icon(Icons.keyboard_arrow_down)]))))),

                Row(
                  children: [
                    Text(getTranslated('Priority', context)!,style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),)
                  ],
                ),
                const SizedBox(height: 5,),
  Padding(padding: const EdgeInsets.only(bottom:Dimensions.homePagePadding),
              child: InkWell(onTap: ()=> showModalBottomSheet(backgroundColor: Colors.transparent,
                  context: context, builder: (_)=> const PriorityBottomSheetWidget()),
                child: Container(width: MediaQuery.of(context).size.width * .5, height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).cardColor, border: Border.all(color: Theme.of(context).hintColor.withOpacity(.5))),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Row(children: [
                        Expanded(child: Text(supportTicketProvider.selectedPriority, maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,color: Colors.grey.shade700))),
                        const Icon(Icons.keyboard_arrow_down)]))))),

                Row(
                  children: [
                    Text(getTranslated('Ticket_Title', context)!,style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),)
                  ],
                ),
                const SizedBox(height: 5,),
            CustomTextFieldWidget(
              focusNode: _subjectNode,
              nextFocus: _descriptionNode,
              required: true,
              inputAction: TextInputAction.next,
              showLabelText: false  ,

              labelText: '${getTranslated('subject', context)}',
              hintText: getTranslated('write_your_subject', context),
              controller: _subjectController,),
            const SizedBox(height: Dimensions.paddingSizeLarge),
                Row(
                  children: [
                    Text(getTranslated('specification', context)!,style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),)
                  ],
                ),
                const SizedBox(height: 5,),
            CustomTextFieldWidget(
              required: true,
              focusNode: _descriptionNode,
              inputAction: TextInputAction.newline,
              hintText: getTranslated('issue_description', context),
              inputType: TextInputType.multiline,
              controller: _descriptionController,
              showLabelText: false  ,
              labelText: '${getTranslated('description', context)}',
              maxLines: 5),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                Row(
                  children: [
                    Text(getTranslated('Attachments', context)!,style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),)
                  ],
                ),
                const SizedBox(height: 5,),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount : supportTicketProvider.pickedImageFileStored.length + 1 ,
                itemBuilder: (BuildContext context, index){
                  return index ==  supportTicketProvider.pickedImageFileStored.length ?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(onTap: ()=> supportTicketProvider.pickMultipleImage(false,),
                      child: DottedBorder(
                        strokeWidth: 0.5,
                        dashPattern: const [10,5],
                        color: Theme.of(context).hintColor,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(Dimensions.paddingSizeSmall),
                        child: Stack(children: [
                          ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                            child:  SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width, child: Center(child: Text(getTranslated('Download_attachments', context)!,style: GoogleFonts.tajawal(
                              color: Theme.of(context).primaryColor,

                            ),)))),
                          Positioned(bottom: 0, right: 0, top: 0, left: 0,
                            child: Container(decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall))))]))),
                  ) :
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1,color: Colors.grey)
                    ),
                    height: 100,
                    child: Stack(children: [
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                        child: Container(decoration: const BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),),
                          child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
                            child:  Image.file(File(supportTicketProvider.pickedImageFileStored[index].path),
                              width: MediaQuery.of(context).size.width, height:50, fit: BoxFit.cover)))),


                      Positioned(top:0,right:0,
                        child: InkWell(onTap :() => supportTicketProvider.pickMultipleImage(true, index: index),
                          child: Container(decoration: const BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))),
                              child: const Padding(padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.delete_forever_rounded,color: Colors.red,size: 15)))))]),
                  );
                },
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10)
          ),
                Provider.of<SupportTicketController>(context).isLoading ?
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 40, height: 40, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                  ],
                ) :
                Consumer<SupportTicketController>(key: _scaffoldKey,
                  builder: (context, supportTicketProvider, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                    child: CustomButton(buttonText: getTranslated('submit', context), onTap: () {
                      if (_subjectController.text.isEmpty) {
                        showCustomSnackBar(getTranslated('subject_is_required', context), context);
                      } else if (_descriptionController.text.isEmpty) {
                        showCustomSnackBar(getTranslated('description_is_required', context), context);
                      }else if (supportTicketProvider.selectedPriorityIndex == -1) {
                        showCustomSnackBar(getTranslated('priority_is_required', context), context);
                      } else {
                        SupportTicketBody supportTicketModel = SupportTicketBody('${getTranslated(supportTicketProvider.selectedType, context)}',
                            _subjectController.text, _descriptionController.text, supportTicketProvider.selectedPriority);
                        supportTicketProvider.createSupportTicket(supportTicketModel);
                      }
                    }),
                  ),
                ),
          ]);
        }),

      // bottomNavigationBar:
    );
  }
}
