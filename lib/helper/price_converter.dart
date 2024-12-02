import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:provider/provider.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double? price, {double? discount, String? discountType}) {

    if(discount != null && discountType != null){
      // print('asdasdasdadsdasdsa----> $discount');
      if(discountType == 'amount' || discountType == 'flat') {
        price = price! - discount;
      }else if(discountType == 'percent' || discountType == 'percentage') {
        price = price! - ((discount / 100) * price);

      }
    }
    bool singleCurrency =Provider.of<SplashController>(context, listen: false).configModel!=null? Provider.of<SplashController>(context, listen: false).configModel!.currencyModel == 'single_currency':true;
    bool inRight = Provider.of<SplashController>(context, listen: false).configModel!=null?Provider.of<SplashController>(context, listen: false).configModel!.currencySymbolPosition == 'right':true;

    return '${inRight ? '' : Provider.of<SplashController>(context, listen: false).myCurrency!.symbol} '
        '${singleCurrency ? price!.toStringAsFixed(2) : (price! * Provider.of<SplashController>(context, listen: false).myCurrency!.exchangeRate).toStringAsFixed(2)} '
        '${inRight ? Provider.of<SplashController>(context, listen: false).myCurrency!.symbol: ''} ';
 }

  static double? convertWithDiscount(BuildContext context, double? price, double? discount, String? discountType) {
    if(discountType == 'amount' || discountType == 'flat') {
      price = price! - discount!;
    }else if(discountType == 'percent' || discountType == 'percentage') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount' || type == 'flat') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent' || type == 'percentage') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, double? price, double? discount, String? discountType) {
    return '-${(discountType == 'percent' || discountType == 'percentage') ? '$discount %'
        : convertPrice(context, discount)}';
  }
  static double calculationTaxDouble(BuildContext context, double? price ,double tax,String ?taxType){
    double taxPrice=0.00;
    if(taxType==null||taxType=='percent'){
    taxPrice=tax/100*price!;
    }else{
      taxPrice =tax;
    }
    return double.parse(taxPrice.toStringAsFixed(2));
  } static String calculationTaxString(BuildContext context, double? price ,double tax,String ?taxType){
    double taxPrice=0.00;
    if(taxType==null||taxType=='percent'){
    taxPrice=tax/100*price!;
    }else{
      taxPrice =tax;
    }
    bool singleCurrency =Provider.of<SplashController>(context, listen: false).configModel!=null? Provider.of<SplashController>(context, listen: false).configModel!.currencyModel == 'single_currency':true;
    bool inRight = Provider.of<SplashController>(context, listen: false).configModel!=null?Provider.of<SplashController>(context, listen: false).configModel!.currencySymbolPosition == 'right':true;

    return '${inRight ? '' : Provider.of<SplashController>(context, listen: false).myCurrency!.symbol} '
        '${singleCurrency ? taxPrice.toStringAsFixed(2) : taxPrice.toStringAsFixed(2)} '
        '${inRight ? Provider.of<SplashController>(context, listen: false).myCurrency!.symbol: ''} ';

  }
}