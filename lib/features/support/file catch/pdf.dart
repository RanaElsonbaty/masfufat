import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfWidget extends StatefulWidget {
  final bool isSend;
  final File file;
  const PdfWidget({super.key,  this.isSend = false, required this.file});

  @override
  State<PdfWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<PdfWidget> {
  PdfController? pdfController;

  void getPdfView() {
    if (widget.isSend) {
      if (mounted) {
        pdfController = PdfController(
          document: PdfDocument.openData(InternetFile.get(widget.file.path)),
        );
      }
    } else {
      if (mounted) {
        pdfController = PdfController(
          document: PdfDocument.openFile(widget.file.path),
        );
      }
    }
  }

  @override
  void initState() {
    getPdfView();
    super.initState();
  }

  @override
  void dispose() {
    pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfView(

      controller: pdfController!,
      onDocumentError: (error) {
        print('pdfController error => $error');
      },
      physics: const AlwaysScrollableScrollPhysics(),
      backgroundDecoration: const BoxDecoration(color: Colors.white),
    );
  }
}
