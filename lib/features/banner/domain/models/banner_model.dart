// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_sixvalley_ecommerce/features/brand/domain/models/brand_model.dart';

import '../../../product/domain/models/product_model.dart';


List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
  final int id;
  final String photo;
  final String bannerType;
  final String theme;
  final int published;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String url;
  final String resourceType;
  final int? resourceId;
  final int deleted;
  final Product? product;
  final BrandModel? brand;

  BannerModel({
    required this.id,
    required this.photo,
    required this.bannerType,
    required this.theme,
    required this.published,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.resourceType,
    required this.resourceId,
    required this.deleted,
     this.product,
     this.brand,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
    id: json["id"],
    photo: json["photo"].toString(),
    bannerType: json["banner_type"],
    theme: json["theme"],
    published: json["published"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    url: json["url"],
    resourceType: json["resource_type"],
    resourceId: json["resource_id"],
    deleted: json["deleted"]??0,
    product:json["product"]!=null? Product.fromJson(json["product"]):null,
    brand:json["brand"]!=null?BrandModel.fromJson(json["brand"]):null,
  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "photo": photo,
    "banner_type": bannerType,
    "theme": theme,
    "published": published,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "url": url,
    "resource_type": resourceType,
    "resource_id": resourceId,
    "deleted": deleted,
    "product": product,
    "brand": brand,
  };
}
