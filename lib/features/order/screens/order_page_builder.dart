import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/controllers/order_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_app_bar_widget.dart';
import '../../../localization/language_constrants.dart';
import '../../sync order/screens/sync_order_screen.dart';
import 'order_screen.dart';

class OrderPageBuilder extends StatefulWidget {
  const OrderPageBuilder({super.key, required this.isBacButtonExist});
  final bool isBacButtonExist;

  @override
  State<OrderPageBuilder> createState() => _OrderPageBuilderState();
}

class _OrderPageBuilderState extends State<OrderPageBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderController>(context, listen: false).getOrderList(1,'ongoing').then((value) {
      Provider.of<OrderController>(context, listen: false).setIndex(0,context, notify: false);

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, orderProvider, child) {
        return Scaffold(
          appBar: CustomAppBar(title: getTranslated('order', context), isBackButtonExist: widget.isBacButtonExist),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          orderProvider.getOrderType(0);

                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color:orderProvider.selectType==0? Theme.of(context).primaryColor:Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                            child: Text(
                              getTranslated('Sync_order', context)!,
                              style: GoogleFonts.tajawal(
                                  fontSize: 16,
                                  color:orderProvider.selectType==0? Colors.white:Theme.of(context).iconTheme.color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          orderProvider.getOrderType(1);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color:orderProvider.selectType==1? Theme.of(context).primaryColor:Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                            child: Text(
                              getTranslated('my_direct_requests', context)!,
                              style: GoogleFonts.tajawal(
                                  fontSize: 16,
                                  color:orderProvider.selectType==1? Colors.white:Theme.of(context).iconTheme.color
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child:orderProvider.selectType==1? OrderScreen(isBacButtonExist: widget.isBacButtonExist,):const SyncOrderScreen()),
            ],
          ),
        );
      },
    );
  }
}
