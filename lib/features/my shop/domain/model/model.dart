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
  final String categoryIds;
  final int brandId;
  final int hasTax;
  final int tax;
  final Type? taxType;
  final dynamic unit;
  final DisplayFor displayFor;
  final ProductType productType;
  final String itemNumber;
  final dynamic gtin;
  final AddedBy addedBy;
  final int userId;
  final Props props;
  final dynamic mpn;
  final dynamic hsCode;
  final dynamic height;
  final dynamic width;
  final dynamic weight;
  final dynamic space;
  final dynamic size;
  final String? madeIn;
  final String images;
  final Videos videos;
  final dynamic linkedProductsIds;
  final List<PricingElement> pricing;
  final int? shippingCost;
  final int status;
  final int isShippingCostUpdated;
  final int requestStatus;
  final DateTime publishAppAt;
  final DateTime publishOnAppDate;
  final int currentStock;
  final int publishOnMarket;
  final String code;
  final String link;
  final int reviewsCount;
  final int reviewsOneCount;
  final dynamic reviewsOneAvgStatus;
  final int reviewsTwoCount;
  final dynamic reviewsTwoAvgStatus;
  final int reviewsThreeCount;
  final dynamic reviewsThreeAvgStatus;
  final int reviewsFourCount;
  final dynamic reviewsFourAvgStatus;
  final int reviewsFiveCount;
  final dynamic reviewsFiveAvgStatus;
  final dynamic myUnitPrice;
  final String brandImage;
  final DeletedPricings pricings;
  final bool inWishList;
  final Synced synced;
  final String imageUrl;
  final dynamic promoTitle;
  final String? shortDesc;
  final Details details;
  final int orderCount;
  final LinkedProduct linkedProduct;
  final List<Translation> translations;
  final List<dynamic> reviews;
  final BrandDetails brandDetails;
  final List<dynamic> wishList;

  Deleted({
    required this.id,
    required this.deleted,
    required this.slug,
    required this.name,
    required this.categoryIds,
    required this.brandId,
    required this.hasTax,
    required this.tax,
    required this.taxType,
    required this.unit,
    required this.displayFor,
    required this.productType,
    required this.itemNumber,
    required this.gtin,
    required this.addedBy,
    required this.userId,
    required this.props,
    required this.mpn,
    required this.hsCode,
    required this.height,
    required this.width,
    required this.weight,
    required this.space,
    required this.size,
    required this.madeIn,
    required this.images,
    required this.videos,
    required this.linkedProductsIds,
    required this.pricing,
    required this.shippingCost,
    required this.status,
    required this.isShippingCostUpdated,
    required this.requestStatus,
    required this.publishAppAt,
    required this.publishOnAppDate,
    required this.currentStock,
    required this.publishOnMarket,
    required this.code,
    required this.link,
    required this.reviewsCount,
    required this.reviewsOneCount,
    required this.reviewsOneAvgStatus,
    required this.reviewsTwoCount,
    required this.reviewsTwoAvgStatus,
    required this.reviewsThreeCount,
    required this.reviewsThreeAvgStatus,
    required this.reviewsFourCount,
    required this.reviewsFourAvgStatus,
    required this.reviewsFiveCount,
    required this.reviewsFiveAvgStatus,
    required this.myUnitPrice,
    required this.brandImage,
    required this.pricings,
    required this.inWishList,
    required this.synced,
    required this.imageUrl,
    required this.promoTitle,
    required this.shortDesc,
    required this.details,
    required this.orderCount,
    required this.linkedProduct,
    required this.translations,
    required this.reviews,
    required this.brandDetails,
    required this.wishList,
  });

  factory Deleted.fromJson(Map<String, dynamic> json) => Deleted(
    id: json["id"],
    deleted: json["deleted"],
    slug: json["slug"],
    name: json["name"],
    categoryIds: json["category_ids"],
    brandId: json["brand_id"],
    hasTax: json["has_tax"],
    tax: json["tax"],
    taxType: typeValues.map[json["tax_type"]]!,
    unit: json["unit"],
    displayFor: displayForValues.map[json["display_for"]]!,
    productType: productTypeValues.map[json["product_type"]]!,
    itemNumber: json["item_number"],
    gtin: json["gtin"],
    addedBy: addedByValues.map[json["added_by"]]!,
    userId: json["user_id"],
    props: Props.fromJson(json["props"]),
    mpn: json["mpn"],
    hsCode: json["hs_code"],
    height: json["height"],
    width: json["width"],
    weight: json["weight"],
    space: json["space"],
    size: json["size"],
    madeIn: json["made_in"]!=null?json["made_in"].toString():"",
    images: json["images"],
    videos: videosValues.map[json["videos"]]!,
    linkedProductsIds: json["linked_products_ids"],
    pricing: List<PricingElement>.from(json["pricing"].map((x) => PricingElement.fromJson(x))),
    shippingCost: json["shipping_cost"],
    status: json["status"],
    isShippingCostUpdated: json["is_shipping_cost_updated"],
    requestStatus: json["request_status"],
    publishAppAt: DateTime.parse(json["publish_app_at"]),
    publishOnAppDate:json["publish_on_app_date"]!=null? DateTime.parse(json["publish_on_app_date"].toString()):DateTime.now(),
    currentStock: json["current_stock"],
    publishOnMarket: json["publish_on_market"],
    code: json["code"],
    link: json["link"],
    reviewsCount: json["reviews_count"],
    reviewsOneCount: json["reviews_one_count"],
    reviewsOneAvgStatus: json["reviews_one_avg_status"],
    reviewsTwoCount: json["reviews_two_count"],
    reviewsTwoAvgStatus: json["reviews_two_avg_status"],
    reviewsThreeCount: json["reviews_three_count"],
    reviewsThreeAvgStatus: json["reviews_three_avg_status"],
    reviewsFourCount: json["reviews_four_count"],
    reviewsFourAvgStatus: json["reviews_four_avg_status"],
    reviewsFiveCount: json["reviews_five_count"],
    reviewsFiveAvgStatus: json["reviews_five_avg_status"],
    myUnitPrice: json["my_unit_price"],
    brandImage: json["brand_image"],
    pricings: DeletedPricings.fromJson(json["pricings"]),
    inWishList: json["in_wish_list"],
    synced: syncedValues.map[json["synced"]]!,
    imageUrl: json["image_url"],
    promoTitle: json["promo_title"],
    shortDesc: json["short_desc"],
    details: Details.fromJson(json["details"]),
    orderCount: json["order_count"],
    linkedProduct: LinkedProduct.fromJson(json["linked_product_"]),
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    brandDetails: BrandDetails.fromJson(json["brand_details"]),
    wishList: List<dynamic>.from(json["wish_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deleted": deleted,
    "slug": slug,
    "name": name,
    "category_ids": categoryIds,
    "brand_id": brandId,
    "has_tax": hasTax,
    "tax": tax,
    "tax_type": typeValues.reverse[taxType],
    "unit": unit,
    "display_for": displayForValues.reverse[displayFor],
    "product_type": productTypeValues.reverse[productType],
    "item_number": itemNumber,
    "gtin": gtin,
    "added_by": addedByValues.reverse[addedBy],
    "user_id": userId,
    "props": props.toJson(),
    "mpn": mpn,
    "hs_code": hsCode,
    "height": height,
    "width": width,
    "weight": weight,
    "space": space,
    "size": size,
    "made_in": madeInValues.reverse[madeIn],
    "images": images,
    "videos": videosValues.reverse[videos],
    "linked_products_ids": linkedProductsIds,
    "pricing": List<dynamic>.from(pricing.map((x) => x.toJson())),
    "shipping_cost": shippingCost,
    "status": status,
    "is_shipping_cost_updated": isShippingCostUpdated,
    "request_status": requestStatus,
    "publish_app_at": publishAppAt.toIso8601String(),
    "publish_on_app_date": "${publishOnAppDate.year.toString().padLeft(4, '0')}-${publishOnAppDate.month.toString().padLeft(2, '0')}-${publishOnAppDate.day.toString().padLeft(2, '0')}",
    "current_stock": currentStock,
    "publish_on_market": publishOnMarket,
    "code": code,
    "link": link,
    "reviews_count": reviewsCount,
    "reviews_one_count": reviewsOneCount,
    "reviews_one_avg_status": reviewsOneAvgStatus,
    "reviews_two_count": reviewsTwoCount,
    "reviews_two_avg_status": reviewsTwoAvgStatus,
    "reviews_three_count": reviewsThreeCount,
    "reviews_three_avg_status": reviewsThreeAvgStatus,
    "reviews_four_count": reviewsFourCount,
    "reviews_four_avg_status": reviewsFourAvgStatus,
    "reviews_five_count": reviewsFiveCount,
    "reviews_five_avg_status": reviewsFiveAvgStatus,
    "my_unit_price": myUnitPrice,
    "brand_image": brandImage,
    "pricings": pricings.toJson(),
    "in_wish_list": inWishList,
    "synced": syncedValues.reverse[synced],
    "image_url": imageUrl,
    "promo_title": promoTitle,
    "short_desc": shortDesc,
    "details": details.toJson(),
    "order_count": orderCount,
    "linked_product_": linkedProduct.toJson(),
    "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
    "brand_details": brandDetails.toJson(),
    "wish_list": List<dynamic>.from(wishList.map((x) => x)),
  };
}

enum AddedBy {
  SELLER
}

final addedByValues = EnumValues({
  "seller": AddedBy.SELLER
});

class BrandDetails {
  final int id;
  final String name;
  final int status;
  final String brandImage;
  final List<dynamic> translations;

  BrandDetails({
    required this.id,
    required this.name,
    required this.status,
    required this.brandImage,
    required this.translations,
  });

  factory BrandDetails.fromJson(Map<String, dynamic> json) => BrandDetails(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    brandImage: json["brand_image"],
    translations: List<dynamic>.from(json["translations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "brand_image": brandImage,
    "translations": List<dynamic>.from(translations.map((x) => x)),
  };
}



class Details {
  final String? shortDesc;
  final String? promoTitle;

  Details({
    required this.shortDesc,
    required this.promoTitle,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    shortDesc: json["short_desc"],
    promoTitle: json["promo_title"],
  );

  Map<String, dynamic> toJson() => {
    "short_desc": shortDesc,
    "promo_title": promoTitle,
  };
}

enum DisplayFor {
  BOTH,
  PURCHASE
}

final displayForValues = EnumValues({
  "both": DisplayFor.BOTH,
  "purchase": DisplayFor.PURCHASE
});

class LinkedProduct {
  final int id;
  final String userId;
  final String linkedId;
  final String localId;
  final String price;
  final String dateSynced;
  final Synced status;
  final String deleted;
  final String? deletionReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Site site;

  LinkedProduct({
    required this.id,
    required this.userId,
    required this.linkedId,
    required this.localId,
    required this.price,
    required this.dateSynced,
    required this.status,
    required this.deleted,
    required this.deletionReason,
    required this.createdAt,
    required this.updatedAt,
    required this.site,
  });

  factory LinkedProduct.fromJson(Map<String, dynamic> json) => LinkedProduct(
    id: json["id"],
    userId: json["user_id"],
    linkedId: json["linked_id"],
    localId: json["local_id"],
    price: json["price"],
    dateSynced: json["date_synced"],
    status: syncedValues.map[json["status"]]!,
    deleted: json["deleted"],
    deletionReason: json["deletion_reason"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    site: siteValues.map[json["site"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "linked_id": linkedId,
    "local_id": localId,
    "price": price,
    "date_synced": dateSynced,
    "status": syncedValues.reverse[status],
    "deleted": deleted,
    "deletion_reason": deletionReason,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "site": siteValues.reverse[site],
  };
}

enum Site {
  SALLA
}

final siteValues = EnumValues({
  "salla": Site.SALLA
});

enum Synced {
  DELETED,
  LINKED,
  PENDING
}

final syncedValues = EnumValues({
  "deleted": Synced.DELETED,
  "linked": Synced.LINKED,
  "pending": Synced.PENDING
});

enum MadeIn {
  EMPTY
}

final madeInValues = EnumValues({
  "الصين": MadeIn.EMPTY
});

class PricingElement {
  final String pricingLevelId;
  final String value;
  final String? minQty;
  final String? maxQty;
  final Type discountType;
  final String? discountPrice;
  final String? suggestedPrice;
  final DisplayFor? displayFor;

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
    pricingLevelId: json["pricing_level_id"],
    value: json["value"],
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discountType: typeValues.map[json["discount_type"]]!,
    discountPrice: json["discount_price"],
    suggestedPrice: json["suggested_price"],
    displayFor: displayForValues.map[json["display_for"]]!,
  );

  Map<String, dynamic> toJson() => {
    "pricing_level_id": pricingLevelId,
    "value": value,
    "min_qty": minQty,
    "max_qty": maxQty,
    "discount_type": typeValues.reverse[discountType],
    "discount_price": discountPrice,
    "suggested_price": suggestedPrice,
    "display_for": displayForValues.reverse[displayFor],
  };
}

enum Type {
  PERCENT
}

final typeValues = EnumValues({
  "percent": Type.PERCENT
});

class DeletedPricings {
  final String pricingLevelId;
  final double value;
  final int minQty;
  final int maxQty;
  final Type discountType;
  final double discountPrice;
  final double suggestedPrice;
  final DisplayFor displayFor;
  final double discount;

  DeletedPricings({
    required this.pricingLevelId,
    required this.value,
    required this.minQty,
    required this.maxQty,
    required this.discountType,
    required this.discountPrice,
    required this.suggestedPrice,
    required this.displayFor,
    required this.discount,
  });

  factory DeletedPricings.fromJson(Map<String, dynamic> json) => DeletedPricings(
    pricingLevelId: json["pricing_level_id"],
    value: json["value"].toDouble(),
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discountType: typeValues.map[json["discount_type"]]!,
    discountPrice: json["discount_price"].toDouble(),
    suggestedPrice: json["suggested_price"]?.toDouble(),
    displayFor: displayForValues.map[json["display_for"]]!,
    discount: json["discount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "pricing_level_id": pricingLevelId,
    "value": value,
    "min_qty": minQty,
    "max_qty": maxQty,
    "discount_type": typeValues.reverse[discountType],
    "discount_price": discountPrice,
    "suggested_price": suggestedPrice,
    "display_for": displayForValues.reverse[displayFor],
    "discount": discount,
  };
}

enum ProductType {
  PHYSICAL
}

final productTypeValues = EnumValues({
  "physical": ProductType.PHYSICAL
});

class Props {
  final dynamic countries;
  final dynamic areas;
  final dynamic cities;
  final dynamic provinces;
  final dynamic selectedCountriesShowQuantityNumber;

  Props({
    required this.countries,
    required this.areas,
    required this.cities,
    required this.provinces,
    required this.selectedCountriesShowQuantityNumber,
  });

  factory Props.fromJson(Map<String, dynamic> json) => Props(
    countries: json["countries"],
    areas: json["areas"],
    cities: json["cities"],
    provinces: json["provinces"],
    selectedCountriesShowQuantityNumber: json["selected_countries_show_quantity_number"],
  );

  Map<String, dynamic> toJson() => {
    "countries": countries,
    "areas": areas,
    "cities": cities,
    "provinces": provinces,
    "selected_countries_show_quantity_number": selectedCountriesShowQuantityNumber,
  };
}

class Translation {
  final TranslationableType translationableType;
  final int translationableId;
  final Locale locale;
  final Key key;
  final String? value;
  final int id;
  final int deleted;

  Translation({
    required this.translationableType,
    required this.translationableId,
    required this.locale,
    required this.key,
    required this.value,
    required this.id,
    required this.deleted,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    translationableType: translationableTypeValues.map[json["translationable_type"]]!,
    translationableId: json["translationable_id"],
    locale: localeValues.map[json["locale"]]!,
    key: keyValues.map[json["key"]]!,
    value: json["value"],
    id: json["id"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "translationable_type": translationableTypeValues.reverse[translationableType],
    "translationable_id": translationableId,
    "locale": localeValues.reverse[locale],
    "key": keyValues.reverse[key],
    "value": value,
    "id": id,
    "deleted": deleted,
  };
}

enum Key {
  NAME
}

final keyValues = EnumValues({
  "name": Key.NAME
});

enum Locale {
  AF,
  AK,
  EN,
  FR,
  RU,
  SA
}

final localeValues = EnumValues({
  "af": Locale.AF,
  "ak": Locale.AK,
  "en": Locale.EN,
  "fr": Locale.FR,
  "ru": Locale.RU,
  "sa": Locale.SA
});

enum TranslationableType {
  APP_MODEL_PRODUCT
}

final translationableTypeValues = EnumValues({
  "App\\Model\\Product": TranslationableType.APP_MODEL_PRODUCT
});

enum Videos {
  EMPTY
}

final videosValues = EnumValues({
  "[]": Videos.EMPTY
});

class Linked {
  final int id;
  final int deleted;
  final String slug;
  final String name;
  final String categoryIds;
  final int brandId;
  final int hasTax;
  final int tax;
  final Type? taxType;
  final dynamic unit;
  final DisplayFor displayFor;
  final ProductType productType;
  final String itemNumber;
  final dynamic gtin;
  final AddedBy addedBy;
  final int userId;
  final Props props;
  final dynamic mpn;
  final dynamic hsCode;
  final dynamic height;
  final dynamic width;
  final dynamic weight;
  final dynamic space;
  final dynamic size;
  final MadeIn? madeIn;
  final String images;
  final Videos? videos;
  final dynamic linkedProductsIds;
  final dynamic pricing;
  final int? shippingCost;
  final int status;
  final int isShippingCostUpdated;
  final int requestStatus;
  final DateTime publishAppAt;
  final DateTime? publishOnAppDate;
  final int currentStock;
  final int publishOnMarket;
  final String code;
  final String link;
  final int reviewsCount;
  final int reviewsOneCount;
  final dynamic reviewsOneAvgStatus;
  final int reviewsTwoCount;
  final dynamic reviewsTwoAvgStatus;
  final int reviewsThreeCount;
  final dynamic reviewsThreeAvgStatus;
  final int reviewsFourCount;
  final dynamic reviewsFourAvgStatus;
  final int reviewsFiveCount;
  final dynamic reviewsFiveAvgStatus;
  final int? myUnitPrice;
  final String brandImage;
  final LinkedPricings pricings;
  final bool inWishList;
  final String synced;
  final String imageUrl;
  final String? promoTitle;
  final String? shortDesc;
  final Details details;
  final int orderCount;
  final LinkedProduct linkedProduct;
  final List<Translation> translations;
  final List<dynamic> reviews;
  final BrandDetails brandDetails;
  final List<WishList> wishList;

  Linked({
    required this.id,
    required this.deleted,
    required this.slug,
    required this.name,
    required this.categoryIds,
    required this.brandId,
    required this.hasTax,
    required this.tax,
    required this.taxType,
    required this.unit,
    required this.displayFor,
    required this.productType,
    required this.itemNumber,
    required this.gtin,
    required this.addedBy,
    required this.userId,
    required this.props,
    required this.mpn,
    required this.hsCode,
    required this.height,
    required this.width,
    required this.weight,
    required this.space,
    required this.size,
    required this.madeIn,
    required this.images,
    required this.videos,
    required this.linkedProductsIds,
    required this.pricing,
    required this.shippingCost,
    required this.status,
    required this.isShippingCostUpdated,
    required this.requestStatus,
    required this.publishAppAt,
    required this.publishOnAppDate,
    required this.currentStock,
    required this.publishOnMarket,
    required this.code,
    required this.link,
    required this.reviewsCount,
    required this.reviewsOneCount,
    required this.reviewsOneAvgStatus,
    required this.reviewsTwoCount,
    required this.reviewsTwoAvgStatus,
    required this.reviewsThreeCount,
    required this.reviewsThreeAvgStatus,
    required this.reviewsFourCount,
    required this.reviewsFourAvgStatus,
    required this.reviewsFiveCount,
    required this.reviewsFiveAvgStatus,
    required this.myUnitPrice,
    required this.brandImage,
    required this.pricings,
    required this.inWishList,
    required this.synced,
    required this.imageUrl,
    required this.promoTitle,
    required this.shortDesc,
    required this.details,
    required this.orderCount,
    required this.linkedProduct,
    required this.translations,
    required this.reviews,
    required this.brandDetails,
    required this.wishList,
  });

  factory Linked.fromJson(Map<String, dynamic> json) => Linked(
    id: json["id"],
    deleted: json["deleted"],
    slug: json["slug"],
    name: json["name"],
    categoryIds: json["category_ids"],
    brandId: json["brand_id"],
    hasTax: json["has_tax"],
    tax: json["tax"],
    taxType: json["tax_type"]!=null?typeValues.map[json["tax_type"]??'']!:null,
    unit: json["unit"],
    displayFor: displayForValues.map[json["display_for"]]!,
    productType: productTypeValues.map[json["product_type"]]!,
    itemNumber: json["item_number"],
    gtin: json["gtin"],
    addedBy: addedByValues.map[json["added_by"]]!,
    userId: json["user_id"],
    props: Props.fromJson(json["props"]),
    mpn: json["mpn"],
    hsCode: json["hs_code"],
    height: json["height"],
    width: json["width"],
    weight: json["weight"],
    space: json["space"],
    size: json["size"],
    madeIn: json["made_in"]!=null?madeInValues.map[json["made_in"]]!:null,
    images: json["images"],
    videos:json["videos"]!=null? videosValues.map[json["videos"]]!:null,
    linkedProductsIds: json["linked_products_ids"],
    pricing: json["pricing"],
    shippingCost: json["shipping_cost"],
    status: json["status"],
    isShippingCostUpdated: json["is_shipping_cost_updated"],
    requestStatus: json["request_status"],
    publishAppAt: DateTime.parse(json["publish_app_at"]),
    publishOnAppDate: json["publish_on_app_date"] == null ? null : DateTime.parse(json["publish_on_app_date"]),
    currentStock: json["current_stock"],
    publishOnMarket: json["publish_on_market"],
    code: json["code"],
    link: json["link"],
    reviewsCount: json["reviews_count"],
    reviewsOneCount: json["reviews_one_count"],
    reviewsOneAvgStatus: json["reviews_one_avg_status"],
    reviewsTwoCount: json["reviews_two_count"],
    reviewsTwoAvgStatus: json["reviews_two_avg_status"],
    reviewsThreeCount: json["reviews_three_count"],
    reviewsThreeAvgStatus: json["reviews_three_avg_status"],
    reviewsFourCount: json["reviews_four_count"],
    reviewsFourAvgStatus: json["reviews_four_avg_status"],
    reviewsFiveCount: json["reviews_five_count"],
    reviewsFiveAvgStatus: json["reviews_five_avg_status"],
    myUnitPrice: json["my_unit_price"],
    brandImage: json["brand_image"],
    pricings: LinkedPricings.fromJson(json["pricings"]),
    inWishList: json["in_wish_list"],
    synced:json["synced"].toString()??'',
    imageUrl: json["image_url"],
    promoTitle: json["promo_title"],
    shortDesc: json["short_desc"],
    details: Details.fromJson(json["details"]),
    orderCount: json["order_count"],
    linkedProduct: LinkedProduct.fromJson(json["linked_product_"]),
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    brandDetails: BrandDetails.fromJson(json["brand_details"]),
    wishList: List<WishList>.from(json["wish_list"].map((x) => WishList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deleted": deleted,
    "slug": slug,
    "name": name,
    "category_ids": categoryIds,
    "brand_id": brandId,
    "has_tax": hasTax,
    "tax": tax,
    "tax_type": typeValues.reverse[taxType],
    "unit": unit,
    "display_for": displayForValues.reverse[displayFor],
    "product_type": productTypeValues.reverse[productType],
    "item_number": itemNumber,
    "gtin": gtin,
    "added_by": addedByValues.reverse[addedBy],
    "user_id": userId,
    "props": props.toJson(),
    "mpn": mpn,
    "hs_code": hsCode,
    "height": height,
    "width": width,
    "weight": weight,
    "space": space,
    "size": size,
    "made_in": madeInValues.reverse[madeIn],
    "images": images,
    "videos": videosValues.reverse[videos],
    "linked_products_ids": linkedProductsIds,
    "pricing": pricing,
    "shipping_cost": shippingCost,
    "status": status,
    "is_shipping_cost_updated": isShippingCostUpdated,
    "request_status": requestStatus,
    "publish_app_at": publishAppAt.toIso8601String(),
    "publish_on_app_date": "${publishOnAppDate!.year.toString().padLeft(4, '0')}-${publishOnAppDate!.month.toString().padLeft(2, '0')}-${publishOnAppDate!.day.toString().padLeft(2, '0')}",
    "current_stock": currentStock,
    "publish_on_market": publishOnMarket,
    "code": code,
    "link": link,
    "reviews_count": reviewsCount,
    "reviews_one_count": reviewsOneCount,
    "reviews_one_avg_status": reviewsOneAvgStatus,
    "reviews_two_count": reviewsTwoCount,
    "reviews_two_avg_status": reviewsTwoAvgStatus,
    "reviews_three_count": reviewsThreeCount,
    "reviews_three_avg_status": reviewsThreeAvgStatus,
    "reviews_four_count": reviewsFourCount,
    "reviews_four_avg_status": reviewsFourAvgStatus,
    "reviews_five_count": reviewsFiveCount,
    "reviews_five_avg_status": reviewsFiveAvgStatus,
    "my_unit_price": myUnitPrice,
    "brand_image": brandImage,
    "pricings": pricings.toJson(),
    "in_wish_list": inWishList,
    "synced": syncedValues.reverse[synced],
    "image_url": imageUrl,
    "promo_title": promoTitle,
    "short_desc": shortDesc,
    "details": details.toJson(),
    "order_count": orderCount,
    "linked_product_": linkedProduct.toJson(),
    "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
    "brand_details": brandDetails.toJson(),
    "wish_list": List<dynamic>.from(wishList.map((x) => x.toJson())),
  };
}

class LinkedPricings {
  final double value;
  final dynamic minQty;
  final int maxQty;
  final int discount;
  final Type discountType;
  final int discountPrice;
  final DisplayFor displayFor;
  final double suggestedPrice;
  final String? pricingLevelId;

  LinkedPricings({
    required this.value,
    required this.minQty,
    required this.maxQty,
    required this.discount,
    required this.discountType,
    required this.discountPrice,
    required this.displayFor,
    required this.suggestedPrice,
    this.pricingLevelId,
  });

  factory LinkedPricings.fromJson(Map<String, dynamic> json) => LinkedPricings(
    value: json["value"]?.toDouble(),
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discount: json["discount"],
    discountType: typeValues.map[json["discount_type"]]!,
    discountPrice: json["discount_price"],
    displayFor: displayForValues.map[json["display_for"]]!,
    suggestedPrice: json["suggested_price"]?.toDouble(),
    pricingLevelId: json["pricing_level_id"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "min_qty": minQty,
    "max_qty": maxQty,
    "discount": discount,
    "discount_type": typeValues.reverse[discountType],
    "discount_price": discountPrice,
    "display_for": displayForValues.reverse[displayFor],
    "suggested_price": suggestedPrice,
    "pricing_level_id": pricingLevelId,
  };
}

class WishList {
  final int id;
  final int customerId;
  final int productId;
  final DateTime createdAt;
  final DateTime updatedAt;

  WishList({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishList.fromJson(Map<String, dynamic> json) => WishList(
    id: json["id"],
    customerId: json["customer_id"],
    productId: json["product_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "product_id": productId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
