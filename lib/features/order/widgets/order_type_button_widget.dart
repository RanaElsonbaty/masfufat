import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderTypeButton extends StatelessWidget {
  final String? text;
  final int index;

  const OrderTypeButton({super.key, required this.text, required this.index});
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, orderController,_) {
        return TextButton(onPressed: () => orderController.setIndex(index,context,notify: true),
          style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
          child: Container(height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: orderController.orderTypeIndex == index ? Theme.of(context).primaryColor :
              const Color(0xFFEFECF5),
              borderRadius: BorderRadius.circular(8 )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),

              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(text!, style: GoogleFonts.tajawal(color: orderController.orderTypeIndex == index ?
                  Colors.white : Colors.black)),
                  const SizedBox(width: 5),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}