// To parse this JSON data, do
//
//     final syncModel = syncModelFromJson(jsonString);

import 'dart:convert';


SyncModel syncModelFromJson(String str) => SyncModel.fromJson(json.decode(str));

String syncModelToJson(SyncModel data) => json.encode(data.toJson());

class SyncModel {
  final List<Deleted> pending;
  final List<Linked> linked;
  final List<Deleted> deleted;

  SyncModel({
    required this.pending,
    required this.linked,
    required this.deleted,
  });

  factory SyncModel.fromJson(Map<String, dynamic> json) => SyncModel(
    pending: List<Deleted>.from(json["pending"].map((x) => Deleted.fromJson(x))),
    linked: List<Linked>.from(json["linked"].map((x) => Linked.fromJson(x))),
    deleted: List<Deleted>.from(json["deleted"].map((x) => Deleted.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pending": List<dynamic>.from(pending.map((x) => x.toJson())),
    "linked": List<dynamic>.from(linked.map((x) => x.toJson())),
    "deleted": List<dynamic>.from(deleted.map((x) => x.toJson())),
  };
}

class Deleted {
  final int id;
  final int deleted;
  final String slug;
  final String name;
  final int hasTax;
  final double tax;
  final String? taxType;
  final dynamic unit;
  final LinkedProduct linkedProduct;

  final String itemNumber;
  final String code;
  final DeletedPricings pricings;
  final String imageUrl;

  Deleted( {
    required this.id,
    required this.deleted,
    required this.slug,
    required this.name,
    required this.hasTax,
    required this.tax,
    required this.taxType,
    required this.unit,
    required this.linkedProduct,

    required this.itemNumber,
    required this.pricings,
    required this.imageUrl,
    required this.code,
  });

  factory Deleted.fromJson(Map<String, dynamic> json) {
    return Deleted(
    id: json["id"],
    deleted: json["deleted"],
    slug: json["slug"],
    name: json["name"],
    linkedProduct: LinkedProduct.fromJson(json["linked_product_"]),


    hasTax: json["has_tax"],
    tax: double.parse(json["tax"]!=null?json["tax"].toString():'0.00'),
    taxType: json["tax_type"]??'',
    unit: json["unit"],
    itemNumber: json["item_number"],
    pricings: DeletedPricings.fromJson(json["pricings"]),
    imageUrl: json["image_url"].toString(),
    code: json["code"],

  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "deleted": deleted,
    "slug": slug,
    "name": name,
    "has_tax": hasTax,
    "tax": tax,
    "tax_type":taxType,
    "unit": unit,
    "item_number": itemNumber,
    "linked_product_": linkedProduct.toJson(),

    "code": code,

    "pricings": pricings.toJson(),

  };
}













class LinkedProduct {
  final int id;
  final String price;
  final String dateSynced;
  final String deleted;
  final String? deletionReason;

  LinkedProduct({
    required this.id,
    required this.price,
    required this.dateSynced,
    required this.deleted,
    required this.deletionReason,
  });

  factory LinkedProduct.fromJson(Map<String, dynamic> json) => LinkedProduct(
    id: json["id"],
    price: json["price"],
    dateSynced: json["date_synced"],
    deleted: json["deleted"],
    deletionReason: json["deletion_reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "date_synced": dateSynced,
    "deleted": deleted,
    "deletion_reason": deletionReason,
  };
}


class PricingElement {
  final String pricingLevelId;
  final String value;
  final String? minQty;
  final String? maxQty;
  final String discountType;
  final String? discountPrice;
  final String? suggestedPrice;
  final String? displayFor;

  PricingElement({
    required this.pricingLevelId,
    required this.value,
    required this.minQty,
    required this.maxQty,
    required this.discountType,
    required this.discountPrice,
    required this.suggestedPrice,
    this.displayFor,
  });

  factory PricingElement.fromJson(Map<String, dynamic> json) => PricingElement(
    pricingLevelId: json["pricing_level_id"]??"",
    value: json["value"].toString(),
    minQty: json["min_qty"]??'',
    maxQty: json["max_qty"]??'',
    discountType: json["discount_type"]??'',
    discountPrice: json["discount_price"]??'',
    suggestedPrice: json["suggested_price"]??'',
    displayFor: json["display_for"]!??'',
  );

  Map<String, dynamic> toJson() => {
    "pricing_level_id": pricingLevelId,
    "value": value,
    "min_qty": minQty,
    "max_qty": maxQty,
    "discount_type": discountType,
    "discount_price": discountPrice,
    "suggested_price": suggestedPrice,
    "display_for": displayFor,
  };
}

class DeletedPricings {
  final double value;

  final double suggestedPrice;

  DeletedPricings({
    required this.value,

    required this.suggestedPrice,
  });

  factory DeletedPricings.fromJson(Map<String, dynamic> json) => DeletedPricings(
    value: json["value"].toDouble(),

    suggestedPrice: json["suggested_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "suggested_price": suggestedPrice,
  };
}





class Linked {
  final int id;
  final int deleted;
  final String name;
  final int hasTax;
  final double tax;
  final LinkedProduct linkedProduct;

  final String? taxType;
  final String itemNumber;
  final String images;
  final dynamic pricing;
  final String code;
  final int? myUnitPrice;
  final LinkedPricings pricings;
  final String imageUrl;

  Linked( {
    required this.id,
    required this.deleted,
    required this.name,
    required this.hasTax,
    required this.tax,
    required this.linkedProduct,
    required this.taxType,
    required this.itemNumber,
    required this.pricing,
    required this.code,
    required this.myUnitPrice,
    required this.images,
    required this.pricings,
    required this.imageUrl,
  });

  factory Linked.fromJson(Map<String, dynamic> json) => Linked(
    id: json["id"],
    deleted: json["deleted"],
    name: json["name"],
    hasTax: json["has_tax"],
    tax: double.parse(json["tax"]!=null?json["tax"].toString():'0.00'),
    taxType: json["tax_type"]!=null?json["tax_type"]??'':null,
    itemNumber: json["item_number"],
    images: json["images"],
    pricing: json["pricing"],
    linkedProduct: LinkedProduct.fromJson(json["linked_product_"]),

    code: json["code"],
    myUnitPrice: json["my_unit_price"],
    pricings: LinkedPricings.fromJson(json["pricings"]),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deleted": deleted,
    "name": name,
    "has_tax": hasTax,
    "tax": tax,
    "item_number": itemNumber,
    // "props": props.toJson(),
    "images": images,
    "pricing": pricing,
    "code": code,
    "my_unit_price": myUnitPrice,
    "pricings": pricings.toJson(),
    "image_url": imageUrl,
  };
}

class LinkedPricings {
  final double value;
  final double suggestedPrice;

  LinkedPricings({
    required this.value,
    required this.suggestedPrice,
  });

  factory LinkedPricings.fromJson(Map<String, dynamic> json) => LinkedPricings(
    value: json["value"]?.toDouble(),
    suggestedPrice: json["suggested_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "value": value,

    "suggested_price": suggestedPrice,
  };
}


