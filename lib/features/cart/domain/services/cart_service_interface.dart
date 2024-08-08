import 'package:flutter_sixvalley_ecommerce/features/cart/domain/models/cart_model.dart';

abstract class CartServiceInterface{

  Future<dynamic> getList();

  Future<dynamic> delete(int id);

  Future<dynamic> addToCartListData(CartModelBody cart,  List<int>? variationIndexes, int buyNow, int? shippingMethodExist, int? shippingMethodId);

  Future<dynamic> updateQuantity(int? key,int quantity);

  Future<dynamic> addRemoveCartSelectedItem(Map<String, dynamic> data);

}