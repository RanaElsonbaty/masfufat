
import '../../../product/domain/models/product_model.dart';

class WishlistModel {
  int? id;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  WishlistModel(
      {this.id,
        this.customerId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.product});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    // print('sadasdasda${json['product']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product'] = product!;
    return data;
  }
}
