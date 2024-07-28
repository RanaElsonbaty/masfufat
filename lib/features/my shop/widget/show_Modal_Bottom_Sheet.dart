import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowModalBottomSheetShop extends StatefulWidget {
  const ShowModalBottomSheetShop({super.key, required this.delete});
  final bool delete;

  @override
  State<ShowModalBottomSheetShop> createState() => _ShowModalBottomSheetShopState();
}

class _ShowModalBottomSheetShopState extends State<ShowModalBottomSheetShop> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child:widget.delete?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(getTranslated('Do_you_want_to_delete_all', Get.context!)!,
        style: GoogleFonts.titilliumWeb(
          fontSize: 30,
          fontWeight: FontWeight.w700

        ),
        ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).primaryColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(getTranslated('yes', context)!,
                          style: GoogleFonts.titilliumWeb(
                              fontSize: 18,
                              color: Colors.white,

                              fontWeight: FontWeight.w500

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(getTranslated('no', context)!,
                          style: GoogleFonts.titilliumWeb(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500

                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            )
        ],),
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //   Do_you_want_to_sync_all
            Text(getTranslated('Do_you_want_to_sync_all', Get.context!)!,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 30,
                  fontWeight: FontWeight.w700

              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(getTranslated('yes', context)!,
                          style: GoogleFonts.titilliumWeb(
                              fontSize: 18,
                              color: Colors.white,

                              fontWeight: FontWeight.w500

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(getTranslated('no', context)!,
                          style: GoogleFonts.titilliumWeb(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500

                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
