import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';

import '../file catch/docx.dart';
import '../file catch/mp4.dart';
import '../file catch/pdf.dart';

class FileDialog extends StatelessWidget {
  final String imageUrl;
  const FileDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: SizedBox(
        height: 400,
        width: 300,
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Stack(children: [
        imageUrl.endsWith('png')?
        CustomImageWidget(height: 400, width: 300, fit: BoxFit.fill,
            image:imageUrl,):
        imageUrl.endsWith('temp')?
              Mp4Widget(
            file:  File(imageUrl),
            min: false,
            isSend: true,
            height: 400,
            width: 300,)
          :  imageUrl.endsWith('pdf')?
            SizedBox(
                height: 400,
                width: 300,
                child: PdfWidget(file: File(imageUrl),isSend: true,)):
        imageUrl.endsWith('docx')

            ? DocxAndXlsxFile(
            file: File(imageUrl),
            fileName: imageUrl,
            isSend: false,
            )
          : const SizedBox.shrink(),
            Align(alignment: Alignment.centerRight,
                child: IconButton(icon: Icon(Icons.cancel, color: Theme.of(context).hintColor,),
                    onPressed: () => Navigator.of(context).pop())),

          ],
          ),

        ],
        ),
      ),
    );
  }
}
