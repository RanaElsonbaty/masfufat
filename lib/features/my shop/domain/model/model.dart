
import 'dart:convert';

SyncModel syncOrderModelFromJson(String str) =>
    SyncModel.fromJson(json.decode(str));

String syncOrderModelToJson(SyncModel data) => json.encode(data.toJson());

class SyncModel {
  List<Pending>? pending;
  List<Linked>? linked;
  List<dynamic>? deleted;

  SyncModel({
    this.pending,
    this.linked,
    this.deleted,
  });

  factory SyncModel.fromJson(Map<String, dynamic> json) => SyncModel(
    pending:
    List<Pending>.from(json["pending"].map((x) => Pending.fromJson(x))),
    linked:
    List<Linked>.from(json["linked"].map((x) => Linked.fromJson(x))),
    deleted: List<dynamic>.from(json["deleted"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "pending": List<dynamic>.from(pending!.map((x) => x.toJson())),
    "linked": List<dynamic>.from(linked!.map((x) => x.toJson())),
    "deleted": List<dynamic>.from(deleted!.map((x) => x)),
  };
}

class Linked {
  int? id;
  String? name;
  int? deleted;
  String? slug;
  String? categoryIds;
  int? brandId;
  int? hasTax;
  dynamic unit;
  String? displayFor;
  String? productType;
  String? itemNumber;
  dynamic gtin;
  String? addedBy;
  int? userId;
  PropsClass? props;
  dynamic mpn;
  dynamic hsCode;
  dynamic height;
  dynamic width;
  dynamic weight;
  dynamic space;
  dynamic size;
  String? madeIn;
  String? color;
  String? images;
  String? videos;
  dynamic linkedProductsIds;
  Map<String, LinkedPricing>? pricing;
  int? shippingCost;
  int? status;
  int? isShippingCostUpdated;
  int? requestStatus;
  DateTime? publishAppAt;
  DateTime? publishOnAppDate;
  int? currentStock;
  int? publishOnMarket;
  String? code;
  String? link;
  int? reviewsCount;
  int? reviewsOneCount;
  dynamic reviewsOneAvgStatus;
  int? reviewsTwoCount;
  dynamic reviewsTwoAvgStatus;
  int? reviewsThreeCount;
  dynamic reviewsThreeAvgStatus;
  int? reviewsFourCount;
  dynamic reviewsFourAvgStatus;
  int? reviewsFiveCount;
  dynamic reviewsFiveAvgStatus;
  double? ownPrice;
  String? brandImage;
  LinkedPricings? pricings;
  bool? inWishList;
  bool? synced;
  String? imageUrl;
  dynamic promoTitle;
  String? shortDesc;
  Details? details;
  int? orderCount;
  List<Translation>? translations;
  List<dynamic>? reviews;
  BrandDetails? brandDetails;
  List<dynamic>? wishList;
   LinkedProduct? linkedProduct;
  Linked({
    this.id,
    this.name,
    this.deleted,
    this.slug,
    this.categoryIds,
    this.brandId,
    this.hasTax,
    this.unit,
    this.displayFor,
    this.productType,
    this.itemNumber,
    this.gtin,
    this.addedBy,
    this.userId,
    this.props,
    this.mpn,
    this.hsCode,
    this.height,
    this.width,
    this.weight,
    this.space,
    this.size,
    this.madeIn,
    this.color,
    this.images,
    this.videos,
    this.linkedProductsIds,
    this.pricing,
    this.shippingCost,
    this.status,
    this.isShippingCostUpdated,
    this.requestStatus,
    this.publishAppAt,
    this.publishOnAppDate,
    this.currentStock,
    this.publishOnMarket,
    this.code,
    this.link,
    this.reviewsCount,
    this.reviewsOneCount,
    this.reviewsOneAvgStatus,
    this.reviewsTwoCount,
    this.reviewsTwoAvgStatus,
    this.reviewsThreeCount,
    this.reviewsThreeAvgStatus,
    this.reviewsFourCount,
    this.reviewsFourAvgStatus,
    this.reviewsFiveCount,
    this.reviewsFiveAvgStatus,
    this.ownPrice,
    this.brandImage,
    this.pricings,
    this.inWishList,
    this.synced,
    this.imageUrl,
    this.promoTitle,
    this.shortDesc,
    this.details,
    this.orderCount,
    this.translations,
    this.reviews,
    this.brandDetails,
    this.wishList,
    this.linkedProduct,
  });

  factory Linked.fromJson(Map<String, dynamic> json) => Linked(
    id: json["id"],
    name: json["name"],
    deleted: json["deleted"],
    slug: json["slug"],
    categoryIds: json["category_ids"],
    brandId: json["brand_id"],
    hasTax: json["has_tax"],
    unit: json["unit"],
    displayFor: json["display_for"],
    productType: json["product_type"],
    itemNumber: json["item_number"],
    gtin: json["gtin"],
    addedBy: json["added_by"],
    userId: json["user_id"],
    // props: PropsClass.fromJson(json["props"]),
    mpn: json["mpn"],
    hsCode: json["hs_code"],
    height: json["height"],
    width: json["width"],
    weight: json["weight"],
    space: json["space"],
    size: json["size"],
    madeIn: json["made_in"],
    color: json["color"],
    images: json["images"],
    videos: json["videos"],
    linkedProductsIds: json["linked_products_ids"],
    pricing: Map.from(json["pricing"]).map((k, v) =>
        MapEntry<String, LinkedPricing>(k, LinkedPricing.fromJson(v))),
    shippingCost: json["shipping_cost"],
    status: json["status"],
    isShippingCostUpdated: json["is_shipping_cost_updated"],
    requestStatus: json["request_status"],
    publishAppAt: DateTime.parse(json["publish_app_at"]),
    // publishOnAppDate: DateTime.parse(json["publish_on_app_date"]),
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
    ownPrice: double.tryParse(json["own_price"].toString()),
    brandImage: json["brand_image"],
    pricings: LinkedPricings.fromJson(json["pricings"]),
    inWishList: json["in_wish_list"],
    // synced: json["synced"]==1?,
    imageUrl: json["image_url"],
    promoTitle: json["promo_title"],
    shortDesc: json["short_desc"],
    details: Details.fromJson(json["details"]),
    orderCount: json["order_count"],
    translations: List<Translation>.from(
        json["translations"].map((x) => Translation.fromJson(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    brandDetails: BrandDetails.fromJson(json["brand_details"]),
    linkedProduct:json["linked_product_"]!=null? LinkedProduct.fromJson(json["linked_product_"]):null,

    wishList: List<dynamic>.from(json["wish_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deleted": deleted,
    "slug": slug,
    "category_ids": categoryIds,
    "brand_id": brandId,
    "has_tax": hasTax,
    "unit": unit,
    "display_for": displayFor,
    "product_type": productType,
    "item_number": itemNumber,
    "gtin": gtin,
    "added_by": addedBy,
    "user_id": userId,
    "props": props!.toJson(),
    "mpn": mpn,
    "hs_code": hsCode,
    "height": height,
    "width": width,
    "weight": weight,
    "space": space,
    "size": size,
    "made_in": madeIn,
    "color": color,
    "images": images,
    "videos": videos,
    "linked_products_ids": linkedProductsIds,
    "pricing": Map.from(pricing!)
        .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "shipping_cost": shippingCost,
    "status": status,
    "is_shipping_cost_updated": isShippingCostUpdated,
    "request_status": requestStatus,
    "publish_app_at": publishAppAt!.toIso8601String(),
    "publish_on_app_date":
    "${publishOnAppDate!.year.toString().padLeft(4, '0')}-${publishOnAppDate!.month.toString().padLeft(2, '0')}-${publishOnAppDate!.day.toString().padLeft(2, '0')}",
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
    "own_price": ownPrice,
    "brand_image": brandImage,
    "pricings": pricings!.toJson(),
    "in_wish_list": inWishList,
    "synced": synced,
    "image_url": imageUrl,
    "promo_title": promoTitle,
    "short_desc": shortDesc,
    "details": details!.toJson(),
    "order_count": orderCount,
    "translations":
    List<dynamic>.from(translations!.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews!.map((x) => x)),
    "brand_details": brandDetails!.toJson(),
    "wish_list": List<dynamic>.from(wishList!.map((x) => x)),
  };
}

class BrandDetails {
  int? id;
  String? name;
  int? status;
  List<dynamic>? translations;

  BrandDetails({
    this.id,
    this.name,
    this.status,
    this.translations,
  });

  factory BrandDetails.fromJson(Map<String, dynamic> json) => BrandDetails(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    translations: List<dynamic>.from(json["translations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "translations": List<dynamic>.from(translations!.map((x) => x)),
  };
}

class Details {
  String? shortDesc;
  dynamic promoTitle;

  Details({
    this.shortDesc,
    this.promoTitle,
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

class LinkedPricing {
  String? pricingLevelId;
  String? value;
  String? minQty;
  String? maxQty;
  String? discountType;
  String? discountPrice;
  String? suggestedPrice;
  String? displayFor;

  LinkedPricing({
    this.pricingLevelId,
    this.value,
    this.minQty,
    this.maxQty,
    this.discountType,
    this.discountPrice,
    this.suggestedPrice,
    this.displayFor,
  });

  factory LinkedPricing.fromJson(Map<String, dynamic> json) => LinkedPricing(
    pricingLevelId: json["pricing_level_id"].toString(),
    value: json["value"].toString(),
    minQty: json["min_qty"].toString(),
    maxQty: json["max_qty"].toString(),
    discountType: json["discount_type"].toString(),
    discountPrice: json["discount_price"].toString(),
    suggestedPrice: json["suggested_price"].toString(),
    displayFor: json["display_for"].toString(),
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

class LinkedPricings {
  String? pricingLevelId;
  double? value;
  int? minQty;
  int? maxQty;
  String? discountType;
  double? discountPrice;
  double? suggestedPrice;
  String? displayFor;
  double? discount;

  LinkedPricings({
    this.pricingLevelId,
    this.value,
    this.minQty,
    this.maxQty,
    this.discountType,
    this.discountPrice,
    this.suggestedPrice,
    this.displayFor,
    this.discount,
  });

  factory LinkedPricings.fromJson(Map<String, dynamic> json) => LinkedPricings(
    pricingLevelId: json["pricing_level_id"].toString(),
    value: json["value"].toDouble(),
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discountType: json["discount_type"],
    discountPrice: json["discount_price"].toDouble(),
    suggestedPrice: json["suggested_price"].toDouble(),
    displayFor: json["display_for"],
    discount: json["discount"].toDouble(),
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
    "discount": discount,
  };
}

class PropsClass {
  dynamic countries;
  dynamic areas;
  dynamic cities;
  dynamic provinces;
  dynamic selectedCountriesShowQuantityNumber;

  PropsClass({
    this.countries,
    this.areas,
    this.cities,
    this.provinces,
    this.selectedCountriesShowQuantityNumber,
  });

  factory PropsClass.fromJson(Map<String, dynamic> json) => PropsClass(
    countries: json["countries"],
    areas: json["areas"],
    cities: json["cities"],
    provinces: json["provinces"],
    selectedCountriesShowQuantityNumber:
    json["selected_countries_show_quantity_number"],
  );

  Map<String, dynamic> toJson() => {
    "countries": countries,
    "areas": areas,
    "cities": cities,
    "provinces": provinces,
    "selected_countries_show_quantity_number":
    selectedCountriesShowQuantityNumber,
  };
}

class Translation {
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;
  int? id;
  int? deleted;

  Translation({
    this.translationableType,
    this.translationableId,
    this.locale,
    this.key,
    this.value,
    this.id,
    this.deleted,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    translationableType: json["translationable_type"],
    translationableId: json["translationable_id"],
    locale: json["locale"],
    key: json["key"],
    value: json["value"],
    id: json["id"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "translationable_type": translationableType,
    "translationable_id": translationableId,
    "locale": locale,
    "key": key,
    "value": value,
    "id": id,
    "deleted": deleted,
  };
}

class Pending {
  int? id;
  String? name;
  int? deleted;
  String? slug;
  String? categoryIds;
  int? brandId;
  int? hasTax;
  dynamic unit;
  String? displayFor;
  String? productType;
  String? itemNumber;
  dynamic gtin;
  String? addedBy;
  int? userId;
  dynamic props;
  dynamic mpn;
  dynamic hsCode;
  dynamic height;
  dynamic width;
  dynamic weight;
  dynamic space;
  dynamic size;
  String? madeIn;
  String? color;
  String? images;
  String? videos;
  dynamic linkedProductsIds;
  Map<String, PendingPricing>? pricing;
  int? shippingCost;
  int? status;
  int? isShippingCostUpdated;
  int? requestStatus;
  DateTime? publishAppAt;
  DateTime? publishOnAppDate;
  int? currentStock;
  int? publishOnMarket;
  String? code;
  String? link;
  int? reviewsCount;
  int? reviewsOneCount;
  dynamic reviewsOneAvgStatus;
  int? reviewsTwoCount;
  dynamic reviewsTwoAvgStatus;
  int? reviewsThreeCount;
  dynamic reviewsThreeAvgStatus;
  int? reviewsFourCount;
  dynamic reviewsFourAvgStatus;
  int? reviewsFiveCount;
  dynamic reviewsFiveAvgStatus;
  double? priceInMyStore;
  String? brandImage;
  PendingPricings? pricings;
  bool? inWishList;
  bool? synced;
  String? imageUrl;
  dynamic promoTitle;
  String? shortDesc;
  Details? details;
  int? orderCount;
  List<Translation>? translations;
  List<dynamic>? reviews;
  BrandDetails? brandDetails;
  List<dynamic>? wishList;

  Pending({
    this.id,
    this.name,
    this.deleted,
    this.slug,
    this.categoryIds,
    this.brandId,
    this.hasTax,
    this.unit,
    this.displayFor,
    this.productType,
    this.itemNumber,
    this.gtin,
    this.addedBy,
    this.userId,
    this.props,
    this.mpn,
    this.hsCode,
    this.height,
    this.width,
    this.weight,
    this.space,
    this.size,
    this.madeIn,
    this.color,
    this.images,
    this.videos,
    this.linkedProductsIds,
    this.pricing,
    this.shippingCost,
    this.status,
    this.isShippingCostUpdated,
    this.requestStatus,
    this.publishAppAt,
    this.publishOnAppDate,
    this.currentStock,
    this.publishOnMarket,
    this.code,
    this.link,
    this.reviewsCount,
    this.reviewsOneCount,
    this.reviewsOneAvgStatus,
    this.reviewsTwoCount,
    this.reviewsTwoAvgStatus,
    this.reviewsThreeCount,
    this.reviewsThreeAvgStatus,
    this.reviewsFourCount,
    this.reviewsFourAvgStatus,
    this.reviewsFiveCount,
    this.reviewsFiveAvgStatus,
    this.priceInMyStore,
    this.brandImage,
    this.pricings,
    this.inWishList,
    this.synced,
    this.imageUrl,
    this.promoTitle,
    this.shortDesc,
    this.details,
    this.orderCount,
    this.translations,
    this.reviews,
    this.brandDetails,
    this.wishList,
  });

  factory Pending.fromJson(Map<String, dynamic> json) => Pending(
    id: json["id"],
    name: json["name"],
    deleted: json["deleted"],
    slug: json["slug"],
    categoryIds: json["category_ids"],
    brandId: json["brand_id"],
    hasTax: json["has_tax"],
    unit: json["unit"],
    displayFor: json["display_for"],
    productType: json["product_type"],
    itemNumber: json["item_number"],
    gtin: json["gtin"],
    addedBy: json["added_by"],
    userId: json["user_id"],
    props: json["props"],
    mpn: json["mpn"],
    hsCode: json["hs_code"],
    height: json["height"],
    width: json["width"],
    weight: json["weight"],
    space: json["space"],
    size: json["size"],
    madeIn: json["made_in"],
    color: json["color"],
    // images: json["images"],
    videos: json["videos"],
    linkedProductsIds: json["linked_products_ids"],
    pricing: Map.from(json["pricing"]).map((k, v) =>
        MapEntry<String, PendingPricing>(k, PendingPricing.fromJson(v))),
    shippingCost: json["shipping_cost"],
    status: json["status"],
    // isShippingCostUpdated: json["is_shipping_cost_updated"],
    // requestStatus: json["request_status"],
    // publishAppAt: DateTime.parse(json["publish_app_at"]),
    // publishOnAppDate: DateTime.parse(json["publish_on_app_date"]),
    currentStock: json["current_stock"],
    // publishOnMarket: json["publish_on_market"],
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
    priceInMyStore: double.tryParse(json["price_in_my_store"].toString()),
    brandImage: json["brand_image"],
    pricings: PendingPricings.fromJson(json["pricings"]),
    inWishList: json["in_wish_list"],
    synced: json["synced"] == 1 ? true : false,
    imageUrl: json["image_url"],
    promoTitle: json["promo_title"],
    shortDesc: json["short_desc"],
    details: Details.fromJson(json["details"]),
    orderCount: json["order_count"],
    translations: List<Translation>.from(
        json["translations"].map((x) => Translation.fromJson(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    brandDetails: BrandDetails.fromJson(json["brand_details"]),
    wishList: List<dynamic>.from(json["wish_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deleted": deleted,
    "slug": slug,
    "category_ids": categoryIds,
    "brand_id": brandId,
    "has_tax": hasTax,
    "unit": unit,
    "display_for": displayFor,
    "product_type": productType,
    "item_number": itemNumber,
    "gtin": gtin,
    "added_by": addedBy,
    "user_id": userId,
    "props": props,
    "mpn": mpn,
    "hs_code": hsCode,
    "height": height,
    "width": width,
    "weight": weight,
    "space": space,
    "size": size,
    "made_in": madeIn,
    "color": color,
    "images": images,
    "videos": videos,
    "linked_products_ids": linkedProductsIds,
    "pricing": Map.from(pricing!)
        .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "shipping_cost": shippingCost,
    "status": status,
    "is_shipping_cost_updated": isShippingCostUpdated,
    "request_status": requestStatus,
    "publish_app_at": publishAppAt!.toIso8601String(),
    "publish_on_app_date":
    "${publishOnAppDate!.year.toString().padLeft(4, '0')}-${publishOnAppDate!.month.toString().padLeft(2, '0')}-${publishOnAppDate!.day.toString().padLeft(2, '0')}",
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
    "price_in_my_store": priceInMyStore,
    "brand_image": brandImage,
    "pricings": pricings!.toJson(),
    "in_wish_list": inWishList,
    "synced": synced,
    "image_url": imageUrl,
    "promo_title": promoTitle,
    "short_desc": shortDesc,
    "details": details!.toJson(),
    "order_count": orderCount,
    "translations":
    List<dynamic>.from(translations!.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews!.map((x) => x)),
    "brand_details": brandDetails!.toJson(),
    "wish_list": List<dynamic>.from(wishList!.map((x) => x)),
  };
}

class PendingPricing {
  dynamic pricingLevelId;
  String? value;
  String? minQty;
  String? maxQty;
  String? discountType;
  String? discountPrice;
  String? suggestedPrice;
  String? displayFor;

  PendingPricing({
    this.pricingLevelId,
    this.value,
    this.minQty,
    this.maxQty,
    this.discountType,
    this.discountPrice,
    this.suggestedPrice,
    this.displayFor,
  });

  factory PendingPricing.fromJson(Map<String, dynamic> json) => PendingPricing(
    pricingLevelId: json["pricing_level_id"],
    value: json["value"].toString(),
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discountType: json["discount_type"].toString(),
    discountPrice: json["discount_price"].toString(),
    suggestedPrice: json["suggested_price"].toString(),
    displayFor: json["display_for"],
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

class PendingPricings {
  dynamic pricingLevelId;
  double? value;
  int? minQty;
  int? maxQty;
  String? discountType;
  double? discountPrice;
  double? suggestedPrice;
  String? displayFor;
  double? discount;

  PendingPricings({
    this.pricingLevelId,
    this.value,
    this.minQty,
    this.maxQty,
    this.discountType,
    this.discountPrice,
    this.suggestedPrice,
    this.displayFor,
    this.discount,
  });

  factory PendingPricings.fromJson(Map<String, dynamic> json) =>
      PendingPricings(
        pricingLevelId: json["pricing_level_id"],
        value: double.tryParse(json["value"].toString()),
        minQty: json["min_qty"],
        maxQty: json["max_qty"],
        discountType: json["discount_type"],
        discountPrice: json["discount_price"].toDouble(),
        suggestedPrice: json["suggested_price"].toDouble(),
        displayFor: json["display_for"],
        discount: json["discount"].toDouble(),
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
    "discount": discount,
  };
}

class LinkedProduct {
  final int id;
  final String userId;
  final String linkedId;
  final String localId;
  final String price;
  final String dateSynced;
  final String status;
  final String deleted;
  final String deletionReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String site;
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
status: json["status"],
deleted: json["deleted"],
deletionReason: json["deletion_reason"],
createdAt: DateTime.parse(json["created_at"]),
updatedAt: DateTime.parse(json["updated_at"]),
site: json["site"],
);

Map<String, dynamic> toJson() => {
"id": id,
"user_id": userId,
"linked_id": linkedId,
"local_id": localId,
"price": price,
"date_synced": dateSynced,
"status": status,
"deleted": deleted,
"deletion_reason": deletionReason,
"created_at": createdAt.toIso8601String(),
"updated_at": updatedAt.toIso8601String(),
"site": site,
};
}

class DeletedPricing {
final String pricingLevelId;
final String value;
final String minQty;
final String maxQty;
final String discountType;
final String discountPrice;
final String suggestedPrice;
final String displayFor;

DeletedPricing({
required this.pricingLevelId,
required this.value,
required this.minQty,
required this.maxQty,
required this.discountType,
required this.discountPrice,
required this.suggestedPrice,
required this.displayFor,
});

factory DeletedPricing.fromJson(Map<String, dynamic> json) => DeletedPricing(
pricingLevelId: json["pricing_level_id"],
value: json["value"],
minQty: json["min_qty"],
maxQty: json["max_qty"],
discountType: json["discount_type"],
discountPrice: json["discount_price"],
suggestedPrice: json["suggested_price"],
displayFor: json["display_for"],
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

