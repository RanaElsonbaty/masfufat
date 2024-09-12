import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key, required this.fromHome});
  final bool fromHome;

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  // String _scanBarcode = 'Unknown';

  Future<String> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      print('barcodeScanRes $barcodeScanRes');

      return barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      print(barcodeScanRes);
      return 'null';
    }
    // return  'null';
    //
    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;
    //
    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    scan();
  }
  void scan()async{
    final barCode = await scanQR().then((value) {


    });

    if (barCode!=null&&barCode != 'null') {
      Provider.of<ProductDetailsController>(Get.context!, listen: false)
          .getProductDetailsBarCode( barCode).then((value) {
            if(value==true){
              Navigator.pop(context);
            }else {
              showCustomSnackBar(getTranslated('no_product_found', context), context);
              scan();
            }
          });
    }else{
      Navigator.pop(Get.context!);

      showCustomSnackBar(getTranslated('no_product_found', Get.context!), Get.context!);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,

        child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),

        );
  }
}
