
import 'dart:convert';

BrandModel brandModelFromJson(String str) => BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
  final int id;
  final String name;
  final String image;
  final int status;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final String showForPricingLevels;
  // final int deleted;
  // final dynamic priority;
  // final String addedBy;
  // final int sellerId;
  // final String isStatus;
  // final String reasonForRejection;
  // final String brandImage;
  // final List<dynamic> translations;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.showForPricingLevels,
    // required this.deleted,
    // required this.priority,
    // required this.addedBy,
    // required this.sellerId,
    // required this.isStatus,
    // required this.reasonForRejection,
    // required this.brandImage,
    // required this.translations,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
    // showForPricingLevels: json["show_for_pricing_levels"],
    // deleted: json["deleted"],
    // priority: json["priority"],
    // addedBy: json["added_by"],
    // sellerId: json["seller_id"],
    // isStatus: json["is_status"],
    // reasonForRejection: json["reason_for_rejection"],
    // brandImage: json["brand_image"],
    // translations: List<dynamic>.from(json["translations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": status,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
    // "show_for_pricing_levels": showForPricingLevels,
    // "deleted": deleted,
    // "priority": priority,
    // "added_by": addedBy,
    // "seller_id": sellerId,
    // "is_status": isStatus,
    // "reason_for_rejection": reasonForRejection,
    // "brand_image": brandImage,
    // "translations": List<dynamic>.from(translations.map((x) => x)),
  };
}
