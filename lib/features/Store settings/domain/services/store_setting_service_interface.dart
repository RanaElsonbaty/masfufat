abstract class StoreSettingServiceInterface{
  Future<dynamic> getLinkedAccount() ;
  Future<dynamic> unlinkLinkedAccount(bool salla);
  Future<dynamic> packages();
}