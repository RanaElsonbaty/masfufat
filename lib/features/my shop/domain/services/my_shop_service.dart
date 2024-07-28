import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/repositories/My_Shop_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/repositories/My_Shop_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/domain/repositories/notification_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/domain/services/notification_service_interface.dart';

import 'my_shop_service_interface.dart';

class MyShopService implements MyShopServiceInterface{
  MyShopRepositoryInterface myShopServiceInterface;
  MyShopService({required this.myShopServiceInterface});

  @override
  Future getList({int? offset = 1}) async{
    return myShopServiceInterface.getList(offset: offset);
  }




}