abstract class SplashServiceInterface{
  Future<dynamic> getConfig();
  Future<dynamic> getConfigGuest();
  Future<dynamic> getMaintenanceMode();

  void initSharedData();
  String getCurrency();
  void setCurrency(String currencyCode);
  void disableIntro();
  bool? showIntro();
}