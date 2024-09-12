import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';

class SyncOrderTypeButtomWidget extends StatefulWidget {
  const SyncOrderTypeButtomWidget({super.key, required this.text, required this.index, required this.pagingController});
final String text;
final int index;
  final PagingController pagingController;
  @override
  State<SyncOrderTypeButtomWidget> createState() => _SyncOrderTypeButtomWidgetState();
}

class _SyncOrderTypeButtomWidgetState extends State<SyncOrderTypeButtomWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SyncOrderController>(
      builder:(context, syncOrderController, child) =>  TextButton(
        onPressed: () {
          syncOrderController.setIndex(widget.index,widget.text,notify: true);
          widget.pagingController.refresh();

        },
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Container(height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: syncOrderController.orderTypeIndex==widget.index?Theme.of(context).primaryColor
         :                    const Color(0xFFEFECF5),

              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),

            child: Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(getTranslated(widget.text, context)!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(color:   syncOrderController.orderTypeIndex == widget.index ?
              Colors.white : Colors.black)),
                const SizedBox(width: 5),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
