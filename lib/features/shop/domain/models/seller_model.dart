
import 'dart:convert';

List<SellerModel> sellerModelFromJson(String str) => List<SellerModel>.from(json.decode(str).map((x) => SellerModel.fromJson(x)));

String sellerModelToJson(List<SellerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellerModel {
  final int id;
  final int sellerId;
  final String name;
  final String address;
  final String contact;
  final String image;
  final dynamic bottomBanner;
  final dynamic offerBanner;
  final dynamic vacationStartDate;
  final dynamic vacationEndDate;
  final dynamic vacationNote;
  final int vacationStatus;
  final int temporaryClose;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final String banner;
  final int totalProducts;
  final Seller? seller;

  SellerModel({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.image,
    required this.bottomBanner,
    required this.offerBanner,
    required this.vacationStartDate,
    required this.vacationEndDate,
    required this.vacationNote,
    required this.vacationStatus,
    required this.temporaryClose,
    // required this.createdAt,
    // required this.updatedAt,
    required this.banner,
    required this.totalProducts,
    required this.seller,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
    id: json["id"],
    sellerId: json["seller_id"] ?? 0,
    name: json["name"],
    address: json["address"],
    contact:json["contact"] ?? "",
    image: json["image"],
    bottomBanner: json["bottom_banner"],
    offerBanner: json["offer_banner"],
    vacationStartDate: json["vacation_start_date"],
    vacationEndDate: json["vacation_end_date"],
    vacationNote: json["vacation_note"],
    vacationStatus: json["vacation_status"] ?? 0,
    temporaryClose: json["temporary_close"]??0,
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
    banner: json["banner"]??'',
    totalProducts: json["total_products"]??0,
    seller:json["seller"]!=null? Seller.fromJson(json["seller"]):null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "name": name,
    "address": address,
    "contact": contact,
    "image": image,
    "bottom_banner": bottomBanner,
    "offer_banner": offerBanner,
    "vacation_start_date": vacationStartDate,
    "vacation_end_date": vacationEndDate,
    "vacation_note": vacationNote,
    "vacation_status": vacationStatus,
    "temporary_close": temporaryClose,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
    "banner": banner,
    "total_products": totalProducts,
    "seller": seller!.toJson(),
  };
}

class Seller {
  final int id;
  final int showSellersSection;

  Seller({
    required this.id,
    required this.showSellersSection,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    showSellersSection: json["show_sellers_section"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "show_sellers_section": showSellersSection,
  };
}
