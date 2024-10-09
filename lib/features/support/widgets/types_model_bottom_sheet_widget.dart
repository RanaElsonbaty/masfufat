import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/dimensions.dart';
import '../controllers/support_ticket_controller.dart';

class TypeModelBottomSheetWidget extends StatefulWidget {
  const TypeModelBottomSheetWidget({super.key});

  @override
  State<TypeModelBottomSheetWidget> createState() => _TypeModelBottomSheetWidgetState();
}

class _TypeModelBottomSheetWidgetState extends State<TypeModelBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SupportTicketController>(
        builder: (context, supportTicketProvider, child) {
          return Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius:  const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 40,height: 5,decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20)),),
              const SizedBox(height: 20,),
              ListView.builder(
                  itemCount: supportTicketProvider.type.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index){
                    return InkWell(onTap: (){
                      supportTicketProvider.setSelectedType(index);

                      Navigator.of(context).pop();
                    },
                      child: Container(decoration: BoxDecoration(
                          color: supportTicketProvider.selectedTypeIndex == index? Theme.of(context).primaryColor.withOpacity(.1):
                          Theme.of(context).cardColor),
                        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Row(children: [
                            Padding(padding: EdgeInsets.symmetric(horizontal:supportTicketProvider.selectedTypeIndex == index?
                            Dimensions.paddingSizeSmall:0),
                              child: Text(getTranslated(supportTicketProvider.type[index], context)??'',
                                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,
                                    color: supportTicketProvider.selectedTypeIndex == index? Theme.of(context).primaryColor:
                                    Theme.of(context).textTheme.bodyLarge?.color),),),
                          ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
            ),
          );
        }
    );
  }
}
