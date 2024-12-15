abstract class MyShopServiceInterface{
  Future<dynamic> getList({int? offset = 1});
  Future<dynamic> delete(int id );
  Future<dynamic> deleteLinked(int id );
  Future<dynamic> addProduct(int id );
  Future<dynamic> addPriceToProduct(int id,String price);
  Future<dynamic> syncProduct(bool sync,bool update);
  Future<dynamic> resyncProduct(int id);
  Future<dynamic> syncOneProduct(bool sync,int id,bool update);

}