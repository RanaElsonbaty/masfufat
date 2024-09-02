import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

abstract class SplashRepositoryInterface implements RepositoryInterface{

  Future<dynamic> getConfig();
  Future<dynamic> getMaintenanceMode();
  void initSharedData();
  String getCurrency();
  void setCurrency(String currencyCode);
  void disableIntro();
  bool? showIntro();
}