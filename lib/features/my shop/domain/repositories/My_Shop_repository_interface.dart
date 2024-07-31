import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

abstract class MyShopRepositoryInterface implements RepositoryInterface{
  Future<dynamic> deleteLinked(int id);
  Future<dynamic> addPriceToProduct(int id,String price);
  Future<dynamic> syncProduct();
  Future<dynamic> addProduct(int id);

}