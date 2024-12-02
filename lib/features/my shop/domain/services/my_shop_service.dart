import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/repositories/My_Shop_repository_interface.dart';

import 'my_shop_service_interface.dart';

class MyShopService implements MyShopServiceInterface{
  MyShopRepositoryInterface myShopServiceInterface;
  MyShopService({required this.myShopServiceInterface});

  @override
  Future getList({int? offset = 1}) async{
    return myShopServiceInterface.getList(offset: offset);
  }

 @override
  Future delete(int id) async{
    return myShopServiceInterface.delete(id);
  }
  @override
  Future deleteLinked(int id) async{
    return myShopServiceInterface.deleteLinked(id);
  }
  @override
  Future addPriceToProduct(int id,String price) async{
    return myShopServiceInterface.addPriceToProduct(id,price);
  } @override
  Future syncProduct(bool sync,) async{
    return myShopServiceInterface.syncProduct(sync,);
  } @override
 Future syncOneProduct(bool sync,int id) async{
    return myShopServiceInterface.syncOneProduct(sync,id);
  } @override


  Future addProduct(int id) async{
    return myShopServiceInterface.addProduct( id);
  }

  @override
  Future resyncProduct(int id) async{
    return myShopServiceInterface.resyncProduct( id);

  }




}