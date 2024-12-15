import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

abstract class MyShopRepositoryInterface implements RepositoryInterface{
  Future<dynamic> deleteLinked(int id);
  Future<dynamic> addPriceToProduct(int id,String price);
  Future<dynamic> syncProduct(bool sync,bool update);
  Future<dynamic> syncOneProduct(bool sync,int id,bool update);
  Future<dynamic> addProduct(int id);
  Future<dynamic> resyncProduct(int id);

}