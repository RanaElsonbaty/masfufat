import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/support_ticket_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/support_ticket_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/support_ticket_type_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_loggedin_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/filter_bottom_sheet.dart';
import 'add_ticket_screen.dart';


class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({super.key});
  @override
  State<SupportTicketScreen> createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen> {
  TextEditingController controller=TextEditingController();

  @override
  void initState() {
    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      Provider.of<SupportTicketController>(context, listen: false).getSupportTicketList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('support_ticket', context)),
        floatingActionButton: Provider.of<AuthController>(context, listen: false).isLoggedIn()?
        SizedBox(height: 70,
          child: InkWell(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTicketScreen( )));

            // showModalBottomSheet(context: context, isScrollControlled: true,
            //   backgroundColor: Theme.of(context).primaryColor,
            //   builder: (con) => const SupportTicketTypeWidget());
            },
              child:
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: const Padding(padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add,color: Colors.white,)
                  // CustomButton(radius: Dimensions.paddingSizeExtraSmall,
                  // buttonText: getTranslated('add_new_ticket', context))
                  ,),
              )
          ),):const SizedBox(),
      body: Consumer<SupportTicketController>(
        builder: (context, support, child) {
            return Provider.of<AuthController>(context, listen: false).isLoggedIn()?

            RefreshIndicator(onRefresh: () async => await support.getSupportTicketList(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),

                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child:  SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: controller,
                          // focusNode: searchProvider.searchFocusNode,
                          textInputAction: TextInputAction.search,
                          onChanged: (val){
                            if(val.isNotEmpty&&val!=''){

                              support.getSearch(val,support.isFilter,support.filterType);
                            }else{
                              support.getSearch('',support.isFilter,support.filterType);

                            }
                          },
                          onFieldSubmitted: (val) {
                            if(val.isNotEmpty&&val!=''){

                              support.getSearch(val,support.isFilter,support.filterType);
                            }else{
                              support.getSearch('',support.isFilter,support.filterType);

                            }

                          },

                          style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge),
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  borderSide: BorderSide(color: Colors.grey[300]!)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  borderSide: BorderSide(color: Colors.grey[300]!)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  borderSide: BorderSide(color: Colors.grey[300]!)),
                              hintText: getTranslated('search_product', context),
                              suffixIcon: SizedBox(width: controller.text.isNotEmpty? 70 : 50,
                                child: Row(children: [
                                  if(controller.text.isNotEmpty)
                                    InkWell(onTap: (){
                                      setState(() {
                                        support.getSearch("",support.isFilter,support.filterType);

                                        controller.clear();
                                      });
                                    }, child: const Icon(Icons.clear, size: 20,)),


                                  InkWell(onTap: (){
                                    showModalBottomSheet(backgroundColor: Colors.transparent,
                                        context: context, builder: (_)=> const FilterBottomSheet());
                                    // FilterBottomSheet
                                  },
                                    child: Padding(padding: const EdgeInsets.all(5),
                                      child: Container(width: 40, height: 50,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                                          child: SizedBox(width : 18,height: 18, child: Padding(
                                            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                            child: Image.asset(Images.filterIcon, color: Colors.white),
                                          ))),
                                    ),
                                  ),
                                ],
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                    support.searchSupportTicket != null ?
                    support.searchSupportTicket!.isNotEmpty? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      itemCount: support.searchSupportTicket?.length,
                      itemBuilder: (context, index) => SupportTicketWidget(supportTicketModel: support.searchSupportTicket![index]))
                        : const NoInternetOrDataScreenWidget(isNoInternet: false, icon: Images.noTicket,
                      message: 'no_ticket_created',) : const SupportTicketShimmer(),
                  ],
                ),
              ),
            ) :const NotLoggedInWidget();
          },
        ),
      );
  }
}



