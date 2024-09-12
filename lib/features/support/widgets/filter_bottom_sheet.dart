import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/dimensions.dart';
import '../controllers/support_ticket_controller.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> filter=[
    'all',
    'closed',
    "open",
    'PENDING'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<SupportTicketController>(
        builder: (context, supportTicketProvider, child) {
          return Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius:  const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 40,height: 5,decoration: BoxDecoration(color: Theme.of(context).hintColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(8)),),
              const SizedBox(height: 20,),
              ListView.builder(
                  itemCount: filter.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index){
                    return InkWell(onTap: (){
supportTicketProvider.getFilter(filter[index]);
Navigator.pop(context);
                    },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:
                            Theme.of(context).cardColor),
                          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Row(children: [
                              Text(getTranslated(filter[index], context)??'',
                                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,
                                    color:
                                    Theme.of(context).textTheme.bodyLarge?.color),),
                            ],
                            ),
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
