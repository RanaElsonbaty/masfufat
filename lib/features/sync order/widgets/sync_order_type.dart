import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class SyncOrderType extends StatelessWidget {
  final String? text;
  final int? index;
  const SyncOrderType({super.key, @required this.text, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          Provider.of<SyncOrderController>(context, listen: false)
              .setUserTypeIndex(context, index!);
        },
        child: Consumer<SyncOrderController>(
          builder: (context, sync, _) {
            return Card(
              color:  sync.userTypeIndex == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                padding:  const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(text!,
                    style: sync.userTypeIndex == index
                        ? TextStyle(
                        color: sync.userTypeIndex == index
                            ? Colors.white
                            : Theme.of(context).iconTheme.color)
                        : TextStyle(
                        color: sync.userTypeIndex == index
                            ? Theme.of(context).cardColor
                            : Theme.of(context).iconTheme.color)),
              ),
            );
          },
        ),
      ),
    );
  }
}
