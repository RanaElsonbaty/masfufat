// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String iconUrl;
  final String imageUrl;
  final String icon;
  final int parentId;
  final int position;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final int homeStatus;
  final int priority;
  // final ShowForPricingLevels showForPricingLevels;
  final int deleted;
  // final AddedBy addedBy;
  final dynamic sellerId;
  // final IsStatus isStatus;
  final dynamic reasonForRejection;
  final List<CategoryModel> childes;
  // final List<Translation> translations;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.iconUrl,
    required this.imageUrl,
    required this.icon,
    required this.parentId,
    required this.position,
    // required this.createdAt,
    // required this.updatedAt,
    required this.homeStatus,
    required this.priority,
    // required this.showForPricingLevels,
    required this.deleted,
    // required this.addedBy,
    required this.sellerId,
    // required this.isStatus,
    required this.reasonForRejection,
    required this.childes,
    // required this.translations,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    iconUrl: json["icon_url"],
    imageUrl: json["image_url"],
    icon: json["icon"]??'',
    parentId: json["parent_id"]??0,
    position: json["position"]??0,
    // createdAt: DateTime.parse(json["created_at"]??DateTime.now()),
    // updatedAt: DateTime.parse(json["updated_at"]??DateTime.now()),
    homeStatus: json["home_status"]??1,
    priority: json["priority"]??1,
    deleted: json["deleted"]??0,
    sellerId: json["seller_id"],
    // isStatus: isStatusValues.map[json["is_status"]],
    reasonForRejection: json["reason_for_rejection"],
    childes:json["childes"]!=null? List<CategoryModel>.from(json["childes"].map((x) => CategoryModel.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "icon_url": iconUrl,
    "image_url": imageUrl,
    "icon": icon,
    "parent_id": parentId,
    "position": position,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
    "home_status": homeStatus,
    "priority": priority,
    "deleted": deleted,
    "seller_id": sellerId,
    // "is_status": isStatusValues.reverse[isStatus],
    "reason_for_rejection": reasonForRejection,
    "childes": List<dynamic>.from(childes.map((x) => x.toJson())),
  };
}

