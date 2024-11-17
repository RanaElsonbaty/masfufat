// To parse this JSON data, do
//
//     final homeCategoryProduct = homeCategoryProductFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';

import '../../../../data/model/image_full_url.dart';

// HomeCategoryProduct homeCategoryProductFromJson(String str) => HomeCategoryProduct.fromJson(json.decode(str));

// String homeCategoryProductToJson(HomeCategoryProduct data) => json.encode(data.toJson());

class HomeCategoryProduct {
   int? _currentPage;
   List<Datum>? _data;
   int? _total;

  HomeCategoryProduct({
    int? currentPage,
    List<Datum>?  data,
    int? total,
  }){
    _currentPage=currentPage;
    _data=data;
    _total=total;
  }
   int? get currentPage=>_currentPage;
   List<Datum>?get  data=>_data;
   int? get total=>_total;
   HomeCategoryProduct.fromJson(Map<String, dynamic> json){
    _currentPage=json["current_page"];
    _total= json["total"];
    _data=[];
    print(json["data"].runtimeType);
    json["data"].forEach((elm){
      _data!.add(Datum.fromJson(elm));
    });

   }
  // factory HomeCategoryProduct.fromJson(Map<String, dynamic> json) {
  //   return HomeCategoryProduct(
  //   currentPage: json["current_page"],
  //   data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  //   total: json["total"],
  // );
  // }
  //
  // Map<String, dynamic> toJson() => {
  //   "current_page": currentPage,
  //   "data": data,
  //   "total": total,
  // };
}

class Datum {
   int? _id;
   String? _name;
   String? _slug;
   String? _icon;
   int? _parentId;
   int? _position;
   DateTime? _createdAt;
   DateTime? _updatedAt;
   int? _homeStatus;
   int? _priority;
   String? _showForPricingLevels;
   int? _deleted;
   String? _addedBy;
   dynamic _sellerId;
   String? _isStatus;
   dynamic _reasonForRejection;
   List<Product> ?_products;
   String ?_iconUrl;
   String ?_imageUrl;

  Datum(
      {
    int? id,
    String? name,
    String? slug,
    String? icon,
    int? parentId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? homeStatus,
    int? priority,
    String? showForPricingLevels,
    int? deleted,
    String? addedBy,
    dynamic sellerId,
    String? isStatus,
    dynamic reasonForRejection,
    List<Product> ?products,
    String ?iconUrl,
    String ?imageUrl,
  }
  ) {
    _id=id;
    _name=name;
    _slug=slug;
    _icon=icon;
    _parentId=parentId;
    _position=position;
    _createdAt=createdAt;
    _updatedAt=updatedAt;
    _homeStatus=homeStatus;
    _priority=priority;
    _showForPricingLevels=showForPricingLevels;
    _deleted=deleted;
    _addedBy=addedBy;
    _sellerId=sellerId;
    _isStatus=isStatus;
    _reasonForRejection=reasonForRejection;
    _products=products;
    _iconUrl=iconUrl;
    _imageUrl=imageUrl;
  }
   int? get id=>_id;
   String? get name=>_name;
   String? get slug=>_slug;
   String? get icon=>_icon;
   int? get parentId=>_parentId;
   int? get position=>_position;
   DateTime? get createdAt=>_createdAt;
   DateTime?get updatedAt=>_updatedAt;
   int? get homeStatus=>_homeStatus;
   int? get priority=>_priority;
   String? get showForPricingLevels=>_showForPricingLevels;
   int? get deleted=>_deleted;
   String? get addedBy=>_addedBy;
   dynamic get sellerId=>_sellerId;
   String? get isStatus=>_isStatus;
   dynamic get reasonForRejection=>_reasonForRejection;
   List<Product> ?get products=>_products;
   String ?get iconUrl=>_iconUrl;
   String ?get imageUrl=>_imageUrl;
   Datum.fromJson(Map<String, dynamic> json){
     _id=json["id"];
       _name= json["name"];
      // _slug= json["slug"];
     // _icon= json["icon"];
     // _parentId= json["parent_id"];
     // _position= json["position"];
     // _createdAt= DateTime.parse(json["created_at"]);
     // _updatedAt= DateTime.parse(json["updated_at"]);
     _homeStatus= json["home_status"];
     // _priority= json["priority"];
     // _showForPricingLevels= json["show_for_pricing_levels"];
     // _deleted=json["deleted"];
     // _addedBy= json["added_by"];
     // _sellerId= json["seller_id"];
     _isStatus= json["is_status"];
     // _reasonForRejection= json["reason_for_rejection"];
     _iconUrl= json["icon_url"];
     _imageUrl= json["image_url"];
     _products=[];
     if(json['products']!=null){
   json['products'].forEach((elm){
     if(elm.runtimeType == List<dynamic>){}else{
       _products!.add(Product.fromJson(elm));

     }
     });
     }
     // _products= [];/

   }
// factory Datum.fromJson(Map<String, dynamic> json) {
  //   json['products'].forEach((elm){
  //     products!.add(Product.fromJson(elm));
  //   });
  //
  //   return Datum(
  //   id: json["id"],
  //   name: json["name"],
  //   slug: json["slug"],
  //   icon: json["icon"],
  //   parentId: json["parent_id"],
  //   position: json["position"],
  //   createdAt: DateTime.parse(json["created_at"]),
  //   updatedAt: DateTime.parse(json["updated_at"]),
  //   homeStatus: json["home_status"],
  //   priority: json["priority"],
  //   showForPricingLevels: json["show_for_pricing_levels"],
  //   deleted: json["deleted"],
  //   addedBy: json["added_by"],
  //   sellerId: json["seller_id"],
  //   isStatus: json["is_status"],
  //   reasonForRejection: json["reason_for_rejection"],
  //   iconUrl: json["icon_url"],
  //   imageUrl: json["image_url"], products: [],
  // );
  //
  //   // products: List<Product>.from(json["products"].map((x) => x)),
  //
  // }
  //
  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "name": name,
  //   "slug": slug,
  //   "icon": icon,
  //   "parent_id": parentId,
  //   "position": position,
  //   "created_at": createdAt.toIso8601String(),
  //   "updated_at": updatedAt.toIso8601String(),
  //   "home_status": homeStatus,
  //   "priority": priority,
  //   "show_for_pricing_levels": showForPricingLevels,
  //   "deleted": deleted,
  //   "added_by": addedBy,
  //   "seller_id": sellerId,
  //   "is_status": isStatus,
  //   "reason_for_rejection": reasonForRejection,
  //   "products": List<dynamic>.from(products!.map((x) => x)),
  //   "icon_url": iconUrl,
  //   "image_url": imageUrl,
  // };
}










