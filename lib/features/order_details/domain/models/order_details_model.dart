// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';

List<OrderDetailsModel> orderDetailsModelFromJson(String str) => List<OrderDetailsModel>.from(json.decode(str).map((x) => OrderDetailsModel.fromJson(x)));

String orderDetailsModelToJson(List<OrderDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsModel {
  final int id;
  final int orderId;
  final int productId;
  final int sellerId;
  final dynamic digitalFileAfterSell;
  final Product? productDetails;
  final int qty;
  final double price;
  final double tax;
  final double discount;
  final String taxModel;
  final String deliveryStatus;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic shippingMethodId;
  final String variant;
  final List<dynamic> variation;
  final String discountType;
  final int isStockDecreased;
  final int refundRequest;
  final String pendingDelete;
  final dynamic preparationDetails;
  final double total;
  // final OrderDetailsModelSeller? seller;
  final Order order;

  OrderDetailsModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.sellerId,
    required this.digitalFileAfterSell,
    required this.productDetails,
    required this.qty,
    required this.price,
    required this.tax,
    required this.discount,
    required this.taxModel,
    required this.deliveryStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingMethodId,
    required this.variant,
    required this.variation,
    required this.discountType,
    required this.isStockDecreased,
    required this.refundRequest,
    required this.pendingDelete,
    required this.preparationDetails,
    required this.total,
    // required this.seller,
    required this.order,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    id: json["id"],
    orderId: json["order_id"]??0,
    productId: json["product_id"],
    sellerId: json["seller_id"],
    digitalFileAfterSell: json["digital_file_after_sell"],
    productDetails:json["product_details"]!=null? Product.fromJson(json["product_details"]):null,
    qty: json["qty"],
    price: json["price"].toDouble(),
    tax: json["tax"].toDouble(),
    discount: json["discount"].toDouble(),
    taxModel: json["tax_model"],
    deliveryStatus: json["delivery_status"],
    paymentStatus: json["payment_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    shippingMethodId: json["shipping_method_id"],
    variant: json["variant"],
    variation: List<dynamic>.from(json["variation"].map((x) => x)),
    discountType: json["discount_type"],
    isStockDecreased: json["is_stock_decreased"],
    refundRequest: json["refund_request"],
    pendingDelete: json["pending_delete"],
    preparationDetails: json["preparation_details"],
    total: json["total"].toDouble(),
    // seller:json["seller"]!=null? OrderDetailsModelSeller.fromJson(json["seller"]):null,
    order: Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "seller_id": sellerId,
    "digital_file_after_sell": digitalFileAfterSell,
    "product_details": productDetails,
    "qty": qty,
    "price": price,
    "tax": tax,
    "discount": discount,
    "tax_model": taxModel,
    "delivery_status": deliveryStatus,
    "payment_status": paymentStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "shipping_method_id": shippingMethodId,
    "variant": variant,
    "variation": List<dynamic>.from(variation.map((x) => x)),
    "discount_type": discountType,
    "is_stock_decreased": isStockDecreased,
    "refund_request": refundRequest,
    "pending_delete": pendingDelete,
    "preparation_details": preparationDetails,
    "total": total,
    // "seller": seller!.toJson(),
    "order": order.toJson(),
  };
}

class Order {
  final int id;
  final int customerId;
  final int isGuest;
  final String customerType;
  final String paymentStatus;
  final String orderStatus;
  final String paymentMethod;
  final String transactionRef;
  final dynamic paymentBy;
  final dynamic paymentNote;
  final double orderAmount;
  final String adminCommission;
  final String isPause;
  final dynamic cause;
  final int shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int discountAmount;
  final dynamic discountType;
  final dynamic couponCode;
  final String couponDiscountBearer;
  final dynamic shippingResponsibility;
  final int shippingMethodId;
  final int shippingCost;
  final int isShippingFree;
  final String orderGroupId;
  final String verificationCode;
  final int verificationStatus;
  final int sellerId;
  final String sellerIs;
  final String shippingAddressData;
  final dynamic deliveryManId;
  final int deliverymanCharge;
  final dynamic expectedDeliveryDate;
  final dynamic orderNote;
  final dynamic billingAddress;
  final String billingAddressData;
  final String orderType;
  final int extraDiscount;
  final dynamic extraDiscountType;
  final dynamic freeDeliveryBearer;
  final int checked;
  final String shippingType;
  final dynamic deliveryType;
  final dynamic deliveryServiceName;
  final dynamic thirdPartyDeliveryTrackingId;
  final dynamic extOrderId;
  final String orderedUsing;
  final String bankDetails;
  final dynamic shippingInfo;
  final String history;
  final int showShippingmethodForCustomer;
  final String shippingTax;
  final dynamic adminNote;
  final String orderAttachments;
  final dynamic packageCount;
  final dynamic customPackagingId;
  final dynamic byAdmin;
  final dynamic transferAlert;
  final dynamic shipment;
  final Shipping shipping;

  Order({
    required this.id,
    required this.customerId,
    required this.isGuest,
    required this.customerType,
    required this.paymentStatus,
    required this.orderStatus,
    required this.paymentMethod,
    required this.transactionRef,
    required this.paymentBy,
    required this.paymentNote,
    required this.orderAmount,
    required this.adminCommission,
    required this.isPause,
    required this.cause,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.discountAmount,
    required this.discountType,
    required this.couponCode,
    required this.couponDiscountBearer,
    required this.shippingResponsibility,
    required this.shippingMethodId,
    required this.shippingCost,
    required this.isShippingFree,
    required this.orderGroupId,
    required this.verificationCode,
    required this.verificationStatus,
    required this.sellerId,
    required this.sellerIs,
    required this.shippingAddressData,
    required this.deliveryManId,
    required this.deliverymanCharge,
    required this.expectedDeliveryDate,
    required this.orderNote,
    required this.billingAddress,
    required this.billingAddressData,
    required this.orderType,
    required this.extraDiscount,
    required this.extraDiscountType,
    required this.freeDeliveryBearer,
    required this.checked,
    required this.shippingType,
    required this.deliveryType,
    required this.deliveryServiceName,
    required this.thirdPartyDeliveryTrackingId,
    required this.extOrderId,
    required this.orderedUsing,
    required this.bankDetails,
    required this.shippingInfo,
    required this.history,
    required this.showShippingmethodForCustomer,
    required this.shippingTax,
    required this.adminNote,
    required this.orderAttachments,
    required this.packageCount,
    required this.customPackagingId,
    required this.byAdmin,
    required this.transferAlert,
    required this.shipment,
    required this.shipping,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    customerId: json["customer_id"],
    isGuest: json["is_guest"],
    customerType: json["customer_type"],
    paymentStatus: json["payment_status"],
    orderStatus: json["order_status"],
    paymentMethod: json["payment_method"]??'',
    transactionRef: json["transaction_ref"]??'',
    paymentBy: json["payment_by"],
    paymentNote: json["payment_note"],
    orderAmount: json["order_amount"]?.toDouble(),
    adminCommission: json["admin_commission"]??'',
    isPause: json["is_pause"]??'',
    cause: json["cause"],
    shippingAddress: json["shipping_address"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    discountAmount: json["discount_amount"],
    discountType: json["discount_type"],
    couponCode: json["coupon_code"],
    couponDiscountBearer: json["coupon_discount_bearer"],
    shippingResponsibility: json["shipping_responsibility"],
    shippingMethodId: json["shipping_method_id"],
    shippingCost: json["shipping_cost"],
    isShippingFree: json["is_shipping_free"],
    orderGroupId: json["order_group_id"],
    verificationCode: json["verification_code"],
    verificationStatus: json["verification_status"],
    sellerId: json["seller_id"],
    sellerIs: json["seller_is"],
    shippingAddressData: json["shipping_address_data"],
    deliveryManId: json["delivery_man_id"],
    deliverymanCharge: json["deliveryman_charge"],
    expectedDeliveryDate: json["expected_delivery_date"],
    orderNote: json["order_note"],
    billingAddress: json["billing_address"],
    billingAddressData: json["billing_address_data"],
    orderType: json["order_type"],
    extraDiscount: json["extra_discount"],
    extraDiscountType: json["extra_discount_type"],
    freeDeliveryBearer: json["free_delivery_bearer"],
    checked: json["checked"],
    shippingType: json["shipping_type"],
    deliveryType: json["delivery_type"],
    deliveryServiceName: json["delivery_service_name"],
    thirdPartyDeliveryTrackingId: json["third_party_delivery_tracking_id"],
    extOrderId: json["ext_order_id"],
    orderedUsing: json["ordered_using"],
    bankDetails: json["bank_details"],
    shippingInfo: json["shipping_info"],
    history: json["history"],
    showShippingmethodForCustomer: json["show_shippingmethod_for_customer"],
    shippingTax: json["shipping_tax"]??'',
    adminNote: json["admin_note"],
    orderAttachments: json["order_attachments"],
    packageCount: json["package_count"],
    customPackagingId: json["custom_packaging_id"],
    byAdmin: json["by_admin"],
    transferAlert: json["transfer_alert"],
    shipment: json["shipment"],
    shipping:json["shipping"]!=null? Shipping.fromJson(json["shipping"]):Shipping.fromJson({}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "is_guest": isGuest,
    "customer_type": customerType,
    "payment_status": paymentStatus,
    "order_status": orderStatus,
    "payment_method": paymentMethod,
    "transaction_ref": transactionRef,
    "payment_by": paymentBy,
    "payment_note": paymentNote,
    "order_amount": orderAmount,
    "admin_commission": adminCommission,
    "is_pause": isPause,
    "cause": cause,
    "shipping_address": shippingAddress,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "discount_amount": discountAmount,
    "discount_type": discountType,
    "coupon_code": couponCode,
    "coupon_discount_bearer": couponDiscountBearer,
    "shipping_responsibility": shippingResponsibility,
    "shipping_method_id": shippingMethodId,
    "shipping_cost": shippingCost,
    "is_shipping_free": isShippingFree,
    "order_group_id": orderGroupId,
    "verification_code": verificationCode,
    "verification_status": verificationStatus,
    "seller_id": sellerId,
    "seller_is": sellerIs,
    "shipping_address_data": shippingAddressData,
    "delivery_man_id": deliveryManId,
    "deliveryman_charge": deliverymanCharge,
    "expected_delivery_date": expectedDeliveryDate,
    "order_note": orderNote,
    "billing_address": billingAddress,
    "billing_address_data": billingAddressData,
    "order_type": orderType,
    "extra_discount": extraDiscount,
    "extra_discount_type": extraDiscountType,
    "free_delivery_bearer": freeDeliveryBearer,
    "checked": checked,
    "shipping_type": shippingType,
    "delivery_type": deliveryType,
    "delivery_service_name": deliveryServiceName,
    "third_party_delivery_tracking_id": thirdPartyDeliveryTrackingId,
    "ext_order_id": extOrderId,
    "ordered_using": orderedUsing,
    "bank_details": bankDetails,
    "shipping_info": shippingInfo,
    "history": history,
    "show_shippingmethod_for_customer": showShippingmethodForCustomer,
    "shipping_tax": shippingTax,
    "admin_note": adminNote,
    "order_attachments": orderAttachments,
    "package_count": packageCount,
    "custom_packaging_id": customPackagingId,
    "by_admin": byAdmin,
    "transfer_alert": transferAlert,
    "shipment": shipment,
    "shipping": shipping.toJson(),
  };
}

class Shipping {
  final int id;
  final int creatorId;
  final String creatorType;
  final String title;
  final int cost;
  final String duration;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int tax;

  Shipping({
    required this.id,
    required this.creatorId,
    required this.creatorType,
    required this.title,
    required this.cost,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.tax,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    id: json["id"]??0,
    creatorId: json["creator_id"]??0,
    creatorType: json["creator_type"]??'',
    title: json["title"]??'',
    cost: json["cost"]??0,
    duration: json["duration"]??'',
    status: json["status"]??0,
    createdAt: DateTime.parse(json["created_at"]??DateTime.now().toString()),
    updatedAt: DateTime.parse(json["updated_at"]??DateTime.now().toString()),
    tax: json["tax"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "creator_id": creatorId,
    "creator_type": creatorType,
    "title": title,
    "cost": cost,
    "duration": duration,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "tax": tax,
  };
}

// class ProductDetails {
//   final int id;
//   final int deleted;
//   final String slug;
//   final String name;
//   final String categoryIds;
//   final int brandId;
//   final int hasTax;
//   final int tax;
//   final String taxType;
//   final dynamic unit;
//   final String displayFor;
//   final String productType;
//   final String itemNumber;
//   final dynamic gtin;
//   final String addedBy;
//   final int userId;
//   final Props props;
//   final dynamic mpn;
//   final dynamic hsCode;
//   final dynamic height;
//   final dynamic width;
//   final dynamic weight;
//   final dynamic space;
//   final dynamic size;
//   final dynamic madeIn;
//   final String color;
//   final String images;
//   final String videos;
//   final dynamic linkedProductsIds;
//   final Pricing pricing;
//   final dynamic shippingCost;
//   final int status;
//   final int isShippingCostUpdated;
//   final int requestStatus;
//   final DateTime publishAppAt;
//   final DateTime publishOnAppDate;
//   final int currentStock;
//   final int publishOnMarket;
//   final String code;
//   final String link;
//   final int reviewsCount;
//   final int reviewsOneCount;
//   final dynamic reviewsOneAvgStatus;
//   final int reviewsTwoCount;
//   final dynamic reviewsTwoAvgStatus;
//   final int reviewsThreeCount;
//   final dynamic reviewsThreeAvgStatus;
//   final int reviewsFourCount;
//   final dynamic reviewsFourAvgStatus;
//   final int reviewsFiveCount;
//   final dynamic reviewsFiveAvgStatus;
//   final dynamic myUnitPrice;
//   final dynamic myDiscountPrice;
//   final dynamic myDiscountType;
//   final dynamic myMinQty;
//   final dynamic myDisplayFor;
//   final String brandImage;
//   final Pricings pricings;
//   final bool inWishList;
//   final String synced;
//   final String imageUrl;
//   final dynamic promoTitle;
//   final dynamic shortDesc;
//   final Details details;
//   final int orderCount;
//   final List<Translation> translations;
//   final List<dynamic> reviews;
//   final BrandDetails brandDetails;
//   final List<WishList> wishList;
//
//   ProductDetails({
//     required this.id,
//     required this.deleted,
//     required this.slug,
//     required this.name,
//     required this.categoryIds,
//     required this.brandId,
//     required this.hasTax,
//     required this.tax,
//     required this.taxType,
//     required this.unit,
//     required this.displayFor,
//     required this.productType,
//     required this.itemNumber,
//     required this.gtin,
//     required this.addedBy,
//     required this.userId,
//     required this.props,
//     required this.mpn,
//     required this.hsCode,
//     required this.height,
//     required this.width,
//     required this.weight,
//     required this.space,
//     required this.size,
//     required this.madeIn,
//     required this.color,
//     required this.images,
//     required this.videos,
//     required this.linkedProductsIds,
//     required this.pricing,
//     required this.shippingCost,
//     required this.status,
//     required this.isShippingCostUpdated,
//     required this.requestStatus,
//     required this.publishAppAt,
//     required this.publishOnAppDate,
//     required this.currentStock,
//     required this.publishOnMarket,
//     required this.code,
//     required this.link,
//     required this.reviewsCount,
//     required this.reviewsOneCount,
//     required this.reviewsOneAvgStatus,
//     required this.reviewsTwoCount,
//     required this.reviewsTwoAvgStatus,
//     required this.reviewsThreeCount,
//     required this.reviewsThreeAvgStatus,
//     required this.reviewsFourCount,
//     required this.reviewsFourAvgStatus,
//     required this.reviewsFiveCount,
//     required this.reviewsFiveAvgStatus,
//     required this.myUnitPrice,
//     required this.myDiscountPrice,
//     required this.myDiscountType,
//     required this.myMinQty,
//     required this.myDisplayFor,
//     required this.brandImage,
//     required this.pricings,
//     required this.inWishList,
//     required this.synced,
//     required this.imageUrl,
//     required this.promoTitle,
//     required this.shortDesc,
//     required this.details,
//     required this.orderCount,
//     required this.translations,
//     required this.reviews,
//     required this.brandDetails,
//     required this.wishList,
//   });
//
//   factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
//     id: json["id"],
//     deleted: json["deleted"],
//     slug: json["slug"],
//     name: json["name"],
//     categoryIds: json["category_ids"],
//     brandId: json["brand_id"],
//     hasTax: json["has_tax"],
//     tax: json["tax"],
//     taxType: json["tax_type"],
//     unit: json["unit"],
//     displayFor: json["display_for"],
//     productType: json["product_type"],
//     itemNumber: json["item_number"],
//     gtin: json["gtin"],
//     addedBy: json["added_by"],
//     userId: json["user_id"],
//     props: Props.fromJson(json["props"]),
//     mpn: json["mpn"],
//     hsCode: json["hs_code"],
//     height: json["height"],
//     width: json["width"],
//     weight: json["weight"],
//     space: json["space"],
//     size: json["size"],
//     madeIn: json["made_in"],
//     color: json["color"],
//     images: json["images"],
//     videos: json["videos"],
//     linkedProductsIds: json["linked_products_ids"],
//     pricing: Pricing.fromJson(json["pricing"]),
//     shippingCost: json["shipping_cost"],
//     status: json["status"],
//     isShippingCostUpdated: json["is_shipping_cost_updated"],
//     requestStatus: json["request_status"],
//     publishAppAt: DateTime.parse(json["publish_app_at"]),
//     publishOnAppDate: DateTime.parse(json["publish_on_app_date"]),
//     currentStock: json["current_stock"],
//     publishOnMarket: json["publish_on_market"],
//     code: json["code"],
//     link: json["link"],
//     reviewsCount: json["reviews_count"],
//     reviewsOneCount: json["reviews_one_count"],
//     reviewsOneAvgStatus: json["reviews_one_avg_status"],
//     reviewsTwoCount: json["reviews_two_count"],
//     reviewsTwoAvgStatus: json["reviews_two_avg_status"],
//     reviewsThreeCount: json["reviews_three_count"],
//     reviewsThreeAvgStatus: json["reviews_three_avg_status"],
//     reviewsFourCount: json["reviews_four_count"],
//     reviewsFourAvgStatus: json["reviews_four_avg_status"],
//     reviewsFiveCount: json["reviews_five_count"],
//     reviewsFiveAvgStatus: json["reviews_five_avg_status"],
//     myUnitPrice: json["my_unit_price"],
//     myDiscountPrice: json["my_discount_price"],
//     myDiscountType: json["my_discount_type"],
//     myMinQty: json["my_min_qty"],
//     myDisplayFor: json["my_display_for"],
//     brandImage: json["brand_image"],
//     pricings: Pricings.fromJson(json["pricings"]),
//     inWishList: json["in_wish_list"],
//     synced: json["synced"],
//     imageUrl: json["image_url"],
//     promoTitle: json["promo_title"],
//     shortDesc: json["short_desc"],
//     details: Details.fromJson(json["details"]),
//     orderCount: json["order_count"],
//     translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
//     reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
//     brandDetails: BrandDetails.fromJson(json["brand_details"]),
//     wishList: List<WishList>.from(json["wish_list"].map((x) => WishList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "deleted": deleted,
//     "slug": slug,
//     "name": name,
//     "category_ids": categoryIds,
//     "brand_id": brandId,
//     "has_tax": hasTax,
//     "tax": tax,
//     "tax_type": taxType,
//     "unit": unit,
//     "display_for": displayFor,
//     "product_type": productType,
//     "item_number": itemNumber,
//     "gtin": gtin,
//     "added_by": addedBy,
//     "user_id": userId,
//     "props": props.toJson(),
//     "mpn": mpn,
//     "hs_code": hsCode,
//     "height": height,
//     "width": width,
//     "weight": weight,
//     "space": space,
//     "size": size,
//     "made_in": madeIn,
//     "color": color,
//     "images": images,
//     "videos": videos,
//     "linked_products_ids": linkedProductsIds,
//     "pricing": pricing.toJson(),
//     "shipping_cost": shippingCost,
//     "status": status,
//     "is_shipping_cost_updated": isShippingCostUpdated,
//     "request_status": requestStatus,
//     "publish_app_at": publishAppAt.toIso8601String(),
//     "publish_on_app_date": "${publishOnAppDate.year.toString().padLeft(4, '0')}-${publishOnAppDate.month.toString().padLeft(2, '0')}-${publishOnAppDate.day.toString().padLeft(2, '0')}",
//     "current_stock": currentStock,
//     "publish_on_market": publishOnMarket,
//     "code": code,
//     "link": link,
//     "reviews_count": reviewsCount,
//     "reviews_one_count": reviewsOneCount,
//     "reviews_one_avg_status": reviewsOneAvgStatus,
//     "reviews_two_count": reviewsTwoCount,
//     "reviews_two_avg_status": reviewsTwoAvgStatus,
//     "reviews_three_count": reviewsThreeCount,
//     "reviews_three_avg_status": reviewsThreeAvgStatus,
//     "reviews_four_count": reviewsFourCount,
//     "reviews_four_avg_status": reviewsFourAvgStatus,
//     "reviews_five_count": reviewsFiveCount,
//     "reviews_five_avg_status": reviewsFiveAvgStatus,
//     "my_unit_price": myUnitPrice,
//     "my_discount_price": myDiscountPrice,
//     "my_discount_type": myDiscountType,
//     "my_min_qty": myMinQty,
//     "my_display_for": myDisplayFor,
//     "brand_image": brandImage,
//     "pricings": pricings.toJson(),
//     "in_wish_list": inWishList,
//     "synced": synced,
//     "image_url": imageUrl,
//     "promo_title": promoTitle,
//     "short_desc": shortDesc,
//     "details": details.toJson(),
//     "order_count": orderCount,
//     "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
//     "reviews": List<dynamic>.from(reviews.map((x) => x)),
//     "brand_details": brandDetails.toJson(),
//     "wish_list": List<dynamic>.from(wishList.map((x) => x.toJson())),
//   };
// }

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
  final dynamic shortDesc;
  final dynamic promoTitle;

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

class Pricing {
  final Empty empty;

  Pricing({
    required this.empty,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    empty: Empty.fromJson(json[""]),
  );

  Map<String, dynamic> toJson() => {
    "": empty.toJson(),
  };
}

class Empty {
  final String pricingLevelId;
  final String value;
  final String minQty;
  final String maxQty;
  final String discountType;
  final String discountPrice;
  final String suggestedPrice;
  final String displayFor;

  Empty({
    required this.pricingLevelId,
    required this.value,
    required this.minQty,
    required this.maxQty,
    required this.discountType,
    required this.discountPrice,
    required this.suggestedPrice,
    required this.displayFor,
  });

  factory Empty.fromJson(Map<String, dynamic> json) => Empty(
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

class Pricings {
  final double value;
  final String minQty;
  final int maxQty;
  final int discount;
  final String discountType;
  final int discountPrice;
  final String displayFor;
  final int suggestedPrice;

  Pricings({
    required this.value,
    required this.minQty,
    required this.maxQty,
    required this.discount,
    required this.discountType,
    required this.discountPrice,
    required this.displayFor,
    required this.suggestedPrice,
  });

  factory Pricings.fromJson(Map<String, dynamic> json) => Pricings(
    value: json["value"]?.toDouble(),
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discount: json["discount"],
    discountType: json["discount_type"],
    discountPrice: json["discount_price"],
    displayFor: json["display_for"],
    suggestedPrice: json["suggested_price"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "min_qty": minQty,
    "max_qty": maxQty,
    "discount": discount,
    "discount_type": discountType,
    "discount_price": discountPrice,
    "display_for": displayFor,
    "suggested_price": suggestedPrice,
  };
}

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
  final String translationableType;
  final int translationableId;
  final String locale;
  final String key;
  final String value;
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

class OrderDetailsModelSeller {
  final int id;
  final dynamic fName;
  final dynamic lName;
  final String phone;
  final String image;
  final String email;
  final String password;
  final String status;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String bankName;
  final String branch;
  final String accountNo;
  final String holderName;
  final dynamic authToken;
  final dynamic salesCommissionPercentage;
  final dynamic gst;
  final dynamic cmFirebaseToken;
  final int posStatus;
  final int minimumOrderAmount;
  final int freeDeliveryStatus;
  final int freeDeliveryOverAmount;
  final dynamic companyName;
  final dynamic licenseOwnerName;
  final dynamic licenseOwnerPhone;
  final String delegateName;
  final String delegatePhone;
  final String commercialRegistrationNo;
  final String commercialRegistrationImg;
  final String taxNo;
  final String taxCertificateImg;
  final String country;
  final String area;
  final String governorate;
  final String address;
  final String vendorAccountNumber;
  final String city;
  final String lat;
  final String lon;
  final String name;
  final int deleted;
  final int showSellersSection;
  final dynamic favMenu;
  final dynamic managerId;
  final String iban;
  final dynamic storeAddress;
  final dynamic siteUrl;
  final String zip;
  final dynamic activity;
  // final List<String> moduleAccess;
  // final List<String> inputAccess;
  final String appLanguage;
  final dynamic accountManagerSupervisorId;
  final String identityType;
  final dynamic idNumber;
  final DateTime releaseDateIdNumber;
  final DateTime expiryDateIdNumber;
  final dynamic idPhoto;
  final String nationality;
  final String employer;
  final String occupation;
  final String gender;
  final DateTime releaseDateCommercialRegister;
  final DateTime expiryDateCommercialRegister;
  final DateTime releaseDateTaxNo;
  final DateTime expiryDateTaxNo;
  final dynamic shortTitleCode;
  final dynamic buildingNo;
  final dynamic subNo;
  final dynamic unitNo;
  final dynamic neighborhood;
  final dynamic street;
  final dynamic titleExplanation;
  final dynamic commissionTaxRate;
  final int powerOfAttorney;
  final dynamic commissionType;
  final dynamic ipAddress;
  final dynamic lastLogin;
  final String platformCommissionPercentage;
  final String platformCommissionAmount;
  final String commissionTaxPercentage;
  final String productsCount;
  final Shop shop;

  OrderDetailsModelSeller({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.image,
    required this.email,
    required this.password,
    required this.status,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.bankName,
    required this.branch,
    required this.accountNo,
    required this.holderName,
    required this.authToken,
    required this.salesCommissionPercentage,
    required this.gst,
    required this.cmFirebaseToken,
    required this.posStatus,
    required this.minimumOrderAmount,
    required this.freeDeliveryStatus,
    required this.freeDeliveryOverAmount,
    required this.companyName,
    required this.licenseOwnerName,
    required this.licenseOwnerPhone,
    required this.delegateName,
    required this.delegatePhone,
    required this.commercialRegistrationNo,
    required this.commercialRegistrationImg,
    required this.taxNo,
    required this.taxCertificateImg,
    required this.country,
    required this.area,
    required this.governorate,
    required this.address,
    required this.vendorAccountNumber,
    required this.city,
    required this.lat,
    required this.lon,
    required this.name,
    required this.deleted,
    required this.showSellersSection,
    required this.favMenu,
    required this.managerId,
    required this.iban,
    required this.storeAddress,
    required this.siteUrl,
    required this.zip,
    required this.activity,
    // required this.moduleAccess,
    // required this.inputAccess,
    required this.appLanguage,
    required this.accountManagerSupervisorId,
    required this.identityType,
    required this.idNumber,
    required this.releaseDateIdNumber,
    required this.expiryDateIdNumber,
    required this.idPhoto,
    required this.nationality,
    required this.employer,
    required this.occupation,
    required this.gender,
    required this.releaseDateCommercialRegister,
    required this.expiryDateCommercialRegister,
    required this.releaseDateTaxNo,
    required this.expiryDateTaxNo,
    required this.shortTitleCode,
    required this.buildingNo,
    required this.subNo,
    required this.unitNo,
    required this.neighborhood,
    required this.street,
    required this.titleExplanation,
    required this.commissionTaxRate,
    required this.powerOfAttorney,
    required this.commissionType,
    required this.ipAddress,
    required this.lastLogin,
    required this.platformCommissionPercentage,
    required this.platformCommissionAmount,
    required this.commissionTaxPercentage,
    required this.productsCount,
    required this.shop,
  });

  factory OrderDetailsModelSeller.fromJson(Map<String, dynamic> json) => OrderDetailsModelSeller(
    id: json["id"],
    fName: json["f_name"],
    lName: json["l_name"],
    phone: json["phone"],
    image: json["image"],
    email: json["email"],
    password: json["password"],
    status: json["status"],
    rememberToken: json["remember_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bankName: json["bank_name"],
    branch: json["branch"]??'',
    accountNo: json["account_no"],
    holderName: json["holder_name"],
    authToken: json["auth_token"],
    salesCommissionPercentage: json["sales_commission_percentage"],
    gst: json["gst"],
    cmFirebaseToken: json["cm_firebase_token"],
    posStatus: json["pos_status"],
    minimumOrderAmount: json["minimum_order_amount"],
    freeDeliveryStatus: json["free_delivery_status"],
    freeDeliveryOverAmount: json["free_delivery_over_amount"],
    companyName: json["company_name"],
    licenseOwnerName: json["license_owner_name"],
    licenseOwnerPhone: json["license_owner_phone"],
    delegateName: json["delegate_name"]??'',
    delegatePhone: json["delegate_phone"]??'',
    commercialRegistrationNo: json["commercial_registration_no"],
    commercialRegistrationImg: json["commercial_registration_img"],
    taxNo: json["tax_no"]??'',
    taxCertificateImg: json["tax_certificate_img"],
    country: json["country"],
    area: json["area"],
    governorate: json["governorate"],
    address: json["address"],
    vendorAccountNumber: json["vendor_account_number"],
    city: json["city"],
    lat: json["lat"],
    lon: json["lon"],
    name: json["name"],
    deleted: json["deleted"],
    showSellersSection: json["show_sellers_section"],
    favMenu: json["fav_menu"],
    managerId: json["manager_id"],
    iban: json["iban"],
    storeAddress: json["store_address"],
    siteUrl: json["site_url"],
    zip: json["zip"],
    activity: json["activity"],
    // moduleAccess: List<String>.from(json["module_access"].map((x) => x)),
    // inputAccess: List<String>.from(json["input_access"].map((x) => x)),
    appLanguage: json["app_language"],
    accountManagerSupervisorId: json["account_manager_supervisor_id"],
    identityType: json["identity_type"],
    idNumber: json["id_number"],
    releaseDateIdNumber: DateTime.parse(json["release_date_id_number"]),
    expiryDateIdNumber: DateTime.parse(json["expiry_date_id_number"]),
    idPhoto: json["id_photo"],
    nationality: json["nationality"],
    employer: json["employer"],
    occupation: json["occupation"],
    gender: json["gender"],
    releaseDateCommercialRegister: DateTime.parse(json["release_date_commercial_register"]),
    expiryDateCommercialRegister: DateTime.parse(json["expiry_date_commercial_register"]),
    releaseDateTaxNo: DateTime.parse(json["release_date_tax_no"]),
    expiryDateTaxNo: DateTime.parse(json["expiry_date_tax_no"]),
    shortTitleCode: json["short_title_code"],
    buildingNo: json["building_no"],
    subNo: json["sub_no"],
    unitNo: json["unit_no"],
    neighborhood: json["neighborhood"],
    street: json["street"],
    titleExplanation: json["title_explanation"],
    commissionTaxRate: json["commission_tax_rate"],
    powerOfAttorney: json["power_of_attorney"],
    commissionType: json["commission_type"],
    ipAddress: json["ip_address"],
    lastLogin: json["last_login"],
    platformCommissionPercentage: json["platform_commission_percentage"]??'',
    platformCommissionAmount: json["platform_commission_amount"]??'',
    commissionTaxPercentage: json["commission_tax_percentage"]??'',
    productsCount: json["products_count"]??'',
    shop: Shop.fromJson(json["shop"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "f_name": fName,
    "l_name": lName,
    "phone": phone,
    "image": image,
    "email": email,
    "password": password,
    "status": status,
    "remember_token": rememberToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "bank_name": bankName,
    "branch": branch,
    "account_no": accountNo,
    "holder_name": holderName,
    "auth_token": authToken,
    "sales_commission_percentage": salesCommissionPercentage,
    "gst": gst,
    "cm_firebase_token": cmFirebaseToken,
    "pos_status": posStatus,
    "minimum_order_amount": minimumOrderAmount,
    "free_delivery_status": freeDeliveryStatus,
    "free_delivery_over_amount": freeDeliveryOverAmount,
    "company_name": companyName,
    "license_owner_name": licenseOwnerName,
    "license_owner_phone": licenseOwnerPhone,
    "delegate_name": delegateName,
    "delegate_phone": delegatePhone,
    "commercial_registration_no": commercialRegistrationNo,
    "commercial_registration_img": commercialRegistrationImg,
    "tax_no": taxNo,
    "tax_certificate_img": taxCertificateImg,
    "country": country,
    "area": area,
    "governorate": governorate,
    "address": address,
    "vendor_account_number": vendorAccountNumber,
    "city": city,
    "lat": lat,
    "lon": lon,
    "name": name,
    "deleted": deleted,
    "show_sellers_section": showSellersSection,
    "fav_menu": favMenu,
    "manager_id": managerId,
    "iban": iban,
    "store_address": storeAddress,
    "site_url": siteUrl,
    "zip": zip,
    "activity": activity,
    // "module_access": List<dynamic>.from(moduleAccess.map((x) => x)),
    // "input_access": List<dynamic>.from(inputAccess.map((x) => x)),
    "app_language": appLanguage,
    "account_manager_supervisor_id": accountManagerSupervisorId,
    "identity_type": identityType,
    "id_number": idNumber,
    "release_date_id_number": "${releaseDateIdNumber.year.toString().padLeft(4, '0')}-${releaseDateIdNumber.month.toString().padLeft(2, '0')}-${releaseDateIdNumber.day.toString().padLeft(2, '0')}",
    "expiry_date_id_number": "${expiryDateIdNumber.year.toString().padLeft(4, '0')}-${expiryDateIdNumber.month.toString().padLeft(2, '0')}-${expiryDateIdNumber.day.toString().padLeft(2, '0')}",
    "id_photo": idPhoto,
    "nationality": nationality,
    "employer": employer,
    "occupation": occupation,
    "gender": gender,
    "release_date_commercial_register": "${releaseDateCommercialRegister.year.toString().padLeft(4, '0')}-${releaseDateCommercialRegister.month.toString().padLeft(2, '0')}-${releaseDateCommercialRegister.day.toString().padLeft(2, '0')}",
    "expiry_date_commercial_register": "${expiryDateCommercialRegister.year.toString().padLeft(4, '0')}-${expiryDateCommercialRegister.month.toString().padLeft(2, '0')}-${expiryDateCommercialRegister.day.toString().padLeft(2, '0')}",
    "release_date_tax_no": "${releaseDateTaxNo.year.toString().padLeft(4, '0')}-${releaseDateTaxNo.month.toString().padLeft(2, '0')}-${releaseDateTaxNo.day.toString().padLeft(2, '0')}",
    "expiry_date_tax_no": "${expiryDateTaxNo.year.toString().padLeft(4, '0')}-${expiryDateTaxNo.month.toString().padLeft(2, '0')}-${expiryDateTaxNo.day.toString().padLeft(2, '0')}",
    "short_title_code": shortTitleCode,
    "building_no": buildingNo,
    "sub_no": subNo,
    "unit_no": unitNo,
    "neighborhood": neighborhood,
    "street": street,
    "title_explanation": titleExplanation,
    "commission_tax_rate": commissionTaxRate,
    "power_of_attorney": powerOfAttorney,
    "commission_type": commissionType,
    "ip_address": ipAddress,
    "last_login": lastLogin,
    "platform_commission_percentage": platformCommissionPercentage,
    "platform_commission_amount": platformCommissionAmount,
    "commission_tax_percentage": commissionTaxPercentage,
    "products_count": productsCount,
    "shop": shop.toJson(),
  };
}

class Shop {
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final String banner;
  final ShopSeller seller;

  Shop({
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
    required this.createdAt,
    required this.updatedAt,
    required this.banner,
    required this.seller,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    sellerId: json["seller_id"],
    name: json["name"],
    address: json["address"],
    contact: json["contact"],
    image: json["image"],
    bottomBanner: json["bottom_banner"],
    offerBanner: json["offer_banner"],
    vacationStartDate: json["vacation_start_date"],
    vacationEndDate: json["vacation_end_date"],
    vacationNote: json["vacation_note"],
    vacationStatus: json["vacation_status"],
    temporaryClose: json["temporary_close"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    banner: json["banner"],
    seller: ShopSeller.fromJson(json["seller"]),
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "banner": banner,
    "seller": seller.toJson(),
  };
}

class ShopSeller {
  final int id;
  final int showSellersSection;

  ShopSeller({
    required this.id,
    required this.showSellersSection,
  });

  factory ShopSeller.fromJson(Map<String, dynamic> json) => ShopSeller(
    id: json["id"],
    showSellersSection: json["show_sellers_section"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "show_sellers_section": showSellersSection,
  };
}
