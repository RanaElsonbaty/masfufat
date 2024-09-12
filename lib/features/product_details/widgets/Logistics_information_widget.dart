import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../localization/language_constrants.dart';

class LogisticsInformationWidget extends StatefulWidget {
  const LogisticsInformationWidget({super.key, required this.productDetailsModel});
  final ProductDetailsModel productDetailsModel;

  @override
  State<LogisticsInformationWidget> createState() => _LogisticsInformationWidgetState();
}

class _LogisticsInformationWidgetState extends State<LogisticsInformationWidget> {
  @override
  Widget build(BuildContext context) {
    // print('asdasdasdasda${widget.productDetailsModel.color!.split('#').last}');
    return Column(
      children: [
       Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    widget.productDetailsModel.itemNumber != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {

                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              " ${getTranslated('item_number', context)} - ${widget.productDetailsModel.itemNumber}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              '- ${getTranslated('item_number', context)}',
                              // style: TextStyle(fontSize: ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 2),
                              child: Text(widget
                                  .productDetailsModel
                                  .itemNumber !=
                                  null
                                  ? widget.productDetailsModel
                                  .itemNumber
                                  .toString()
                                  : '0'),
                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.code != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {

                          showCustomSnackBar(
                            getTranslated(
                                'The_text_has_been_copied',
                                context),
                            context,
                            isError: false,
                          );
                          Clipboard.setData(ClipboardData(
                              text:
                              " ${getTranslated('code', context)} - ${widget.productDetailsModel.code}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('code', context)}",
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 2),
                              child: Text(widget
                                  .productDetailsModel
                                  .code !=
                                  null
                                  ? widget.productDetailsModel.code
                                  .toString()
                                  : '0'),
                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.gtin != '' &&
                        widget.productDetailsModel.gtin != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {

                          showCustomSnackBar(
                            getTranslated(
                                'The_text_has_been_copied',
                                context),
                            context,
                            isError: false,
                          );
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('gtin', context)} - ${widget.productDetailsModel.gtin}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('gtin', context)}",
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 2),
                              child: Text(widget
                                  .productDetailsModel
                                  .gtin !=
                                  null
                                  ? widget.productDetailsModel.gtin
                                  .toString()
                                  : '0'),
                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.mpn != '' &&
                        widget.productDetailsModel.mpn != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('mpn', context)} - ${widget.productDetailsModel.mpn}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('mpn', context)}",
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 2),
                              child: Text(
                                widget.productDetailsModel.mpn !=
                                    null
                                    ? widget
                                    .productDetailsModel.mpn
                                    .toString()
                                    : '0',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.hsCode != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('hs_code', context)} - ${widget.productDetailsModel.hsCode}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('hs_code', context)}",
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 2),
                              child: Text(widget
                                  .productDetailsModel
                                  .hsCode !=
                                  null
                                  ? widget
                                  .productDetailsModel.hsCode
                                  .toString()
                                  : '0'),
                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.length != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {

                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('length', context)} - ${widget.productDetailsModel.length}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('length', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel
                                .length !=
                                null
                                ? widget.productDetailsModel.length
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.width != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {

                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('width', context)} - ${widget.productDetailsModel.width}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('width', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel
                                .width !=
                                null
                                ? widget.productDetailsModel.width
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.height != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {

                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('height', context)} - ${widget.productDetailsModel.height}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('height', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel
                                .height !=
                                null
                                ? widget.productDetailsModel.height
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.size != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('size', context)} - ${widget.productDetailsModel.size.toString()}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('size', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel.size !=
                                null
                                ? widget.productDetailsModel.size
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.space != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              " ${getTranslated('space', context)} - ${widget.productDetailsModel.space}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('space', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel
                                .space !=
                                null
                                ? widget.productDetailsModel.space
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.weight != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('weight', context)} - ${widget.productDetailsModel.weight}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('weight', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel
                                .weight !=
                                null
                                ? widget.productDetailsModel.weight
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.unit != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('unit', context)} - ${widget.productDetailsModel.unit}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('unit', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel.unit !=
                                null
                                ? widget.productDetailsModel.unit
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.madeIn != null &&
                        widget.productDetailsModel.madeIn != '0'
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('made_in', context)} - ${widget.productDetailsModel.madeIn}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('made_in', context)}",
                            ),
                            const Spacer(),
                            Text(widget.productDetailsModel
                                .madeIn !=
                                null
                                ? widget.productDetailsModel.madeIn
                                .toString()
                                : '0')
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productDetailsModel.color != null
                        ? Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(
                          //         content: Text(
                          //           getTranslated(
                          //               'The_text_has_been_copied',
                          //               context),
                          //           style: TextStyle(
                          //               color: Colors.white),
                          //         ),
                          //         backgroundColor: Colors.green));
                          showCustomSnackBar(
                              getTranslated(
                                  'The_text_has_been_copied',
                                  context),
                              context,
                              isError: false);
                          Clipboard.setData(ClipboardData(
                              text:
                              "${getTranslated('color', context)} - ${widget.productDetailsModel.color}"));
                        },
                        child: Row(
                          children: [
                            Text(
                              "- ${getTranslated('color', context)}",
                            ),
                            const Spacer(),
                            // widget.productDetailsModel
                            //                                 .color !=
                            //                                 null
                            //                                 ? widget.productDetailsModel.color
                            //                                 .toString()
                            //                                 : '0'
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 0.5,color: Colors.grey),
                                color:  widget.productDetailsModel
                                                                .color !=
                                                                null
                                                                ?Color( 0xFF+int.parse(widget.productDetailsModel.color!.split('#').last)):null
                              ),

                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              )),
        )
          ,

      ],
    );
  }
}
