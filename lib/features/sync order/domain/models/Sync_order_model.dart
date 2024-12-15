// To parse this JSON data, do
//
//     final syncOrderModel = syncOrderModelFromJson(jsonString);

import 'dart:convert';

import '../../../address/domain/models/address_model.dart';
import '../../../product/domain/models/product_model.dart';


SyncOrderModel syncOrderModelFromJson(String str) =>
    SyncOrderModel.fromJson(json.decode(str));

String syncOrderModelToJson(SyncOrderModel data) => json.encode(data.toJson());

class SyncOrderModel {
  int? id;
  int? customerId;
  int? isGuest;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  String? transactionRef;
  dynamic paymentBy;
  dynamic paymentNote;
  double? orderAmount;
  String? adminCommission;
  String? isPause;
  dynamic cause;
  int? shippingAddress;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? discountAmount;
  dynamic discountType;
  dynamic couponCode;
  String? couponDiscountBearer;
  dynamic shippingResponsibility;
  int? shippingMethodId;
  double? shippingCost;
  int? isShippingFree;
  String? orderGroupId;
  int? sellerId;
  String? sellerIs;
  AddressModel? shippingAddressData;
  String? orderType;
  double? extraDiscount;
  dynamic extraDiscountType;
  dynamic freeDeliveryBearer;
  int? checked;
  String? shippingType;
  dynamic deliveryType;
  dynamic deliveryServiceName;
  dynamic thirdPartyDeliveryTrackingId;
  String? extOrderId;
  String? orderedUsing;
  String? bankDetails;
  dynamic shippingInfo;
  String? history;
  int? showShippingmethodForCustomer;
  dynamic shippingTax;
  dynamic adminNote;
  List<Detail>? details;

  SyncOrderModel({
    this.id,
    this.customerId,
    this.isGuest,
    this.customerType,
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.transactionRef,
    this.paymentBy,
    this.paymentNote,
    this.orderAmount,
    this.adminCommission,
    this.isPause,
    this.cause,
    this.shippingAddressData,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
    this.discountAmount,
    this.discountType,
    this.couponCode,
    this.couponDiscountBearer,
    this.shippingResponsibility,
    this.shippingMethodId,
    this.shippingCost,
    this.isShippingFree,
    this.orderGroupId,
    this.sellerId,
    this.sellerIs,
    this.orderType,
    this.extraDiscount,
    this.extraDiscountType,
    this.freeDeliveryBearer,
    this.checked,
    this.shippingType,
    this.deliveryType,
    this.deliveryServiceName,
    this.thirdPartyDeliveryTrackingId,
    this.extOrderId,
    this.orderedUsing,
    this.bankDetails,
    this.shippingInfo,
    this.history,
    this.showShippingmethodForCustomer,
    this.shippingTax,
    this.adminNote,
    this.details,
  });

  factory SyncOrderModel.fromJson(Map<String, dynamic> json) => SyncOrderModel(
    id: json["id"],
    customerId: json["customer_id"],
    isGuest: json["is_guest"],
    customerType: json["customer_type"],
    paymentStatus: json["payment_status"],
    orderStatus: json["order_status"],
    paymentMethod: json["payment_method"],
    transactionRef: json["transaction_ref"],
    paymentBy: json["payment_by"],
    paymentNote: json["payment_note"],
    orderAmount: json["order_amount"]?.toDouble(),
    adminCommission: json["admin_commission"],
    isPause: json["is_pause"],
    cause: json["cause"],
    shippingAddress: json["shipping_address"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    discountAmount: json["discount_amount"]?.toDouble(),
    discountType: json["discount_type"],
    couponCode: json["coupon_code"],
    couponDiscountBearer: json["coupon_discount_bearer"],
    shippingResponsibility: json["shipping_responsibility"],
    shippingMethodId: json["shipping_method_id"],
    shippingCost: json["shipping_cost"]?.toDouble(),
    isShippingFree: json["is_shipping_free"],
    orderGroupId: json["order_group_id"],
    sellerId: json["seller_id"],
    sellerIs: json["seller_is"],
    shippingAddressData:
    AddressModel.fromJson(json["shipping_address_data"]),
    orderType: json["order_type"],
    extraDiscount: json["extra_discount"]!=null?double.tryParse( json["extra_discount"].toString()):0.00,
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
    shippingTax: json["shipping_tax"],
    // shippingCost:json['shipping_cost']?.toDouble(),
    adminNote: json["admin_note"],
    // billingAddress:json['billing_address_data'],
    details: json["details"] == null
        ? []
        : List<Detail>.from(
        json["details"]!.map((x) => Detail.fromJson(x))),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "discount_amount": discountAmount,
    "discount_type": discountType,
    "coupon_code": couponCode,
    "coupon_discount_bearer": couponDiscountBearer,
    "shipping_responsibility": shippingResponsibility,
    "shipping_method_id": shippingMethodId,
    "shipping_cost": shippingCost,
    "is_shipping_free": isShippingFree,
    "order_group_id": orderGroupId,
    "seller_id": sellerId,
    "seller_is": sellerIs,
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
    "details": details == null
        ? []
        : List<Detail>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  final int id;
  final int orderId;
  final int productId;
  final int sellerId;
  final Product productDetails;
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
  final String variation;
  final String discountType;
  final int isStockDecreased;
  final int refundRequest;
  final String pendingDelete;
  final dynamic preparationDetails;
  final dynamic digitalFileAfterSell;

  Detail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.sellerId,
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
    this.digitalFileAfterSell,
  });

  factory Detail.fromJson(Map<String, dynamic> jsons) {
    return Detail(
      id: jsons["id"],
      orderId: jsons["order_id"],
      productId: jsons["product_id"],
      sellerId: jsons["seller_id"],
      productDetails: Product.fromJson( json.decode(jsons["product_details"])),
      qty: jsons["qty"],
      price:double.parse(jsons["price"].toString()) ,
      tax:double.parse(jsons["tax"].toString()),
      discount: double.parse(jsons["discount"].toString()),
      taxModel: jsons["tax_model"],
      deliveryStatus: jsons["delivery_status"],
      paymentStatus: jsons["payment_status"],
      createdAt: DateTime.parse(jsons["created_at"]),
      updatedAt: DateTime.parse(jsons["updated_at"]),
      shippingMethodId: jsons["shipping_method_id"],
      variant: jsons["variant"],
      variation: jsons["variation"],
      discountType: jsons["discount_type"],
      isStockDecreased: jsons["is_stock_decreased"],
      refundRequest: jsons["refund_request"],
      pendingDelete: jsons["pending_delete"],
      preparationDetails: jsons["preparation_details"],
      digitalFileAfterSell: jsons["digital_file_after_sell"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "seller_id": sellerId,
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
    "variation": variation,
    "discount_type": discountType,
    "is_stock_decreased": isStockDecreased,
    "refund_request": refundRequest,
    "pending_delete": pendingDelete,
    "preparation_details": preparationDetails,
    "digital_file_after_sell": digitalFileAfterSell,
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
    translations: json["translations"] == null
        ? []
        : List<dynamic>.from(json["translations"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "translations": translations == null
        ? []
        : List<dynamic>.from(translations!.map((x) => x)),
  };
}

class Details {
  dynamic shortDesc;
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

class Pricing {
  String? pricingLevelId;
  String? value;
  String? minQty;
  String? maxQty;
  String? discountType;
  String? discountPrice;
  String? suggestedPrice;
  String? displayFor;

  Pricing({
    this.pricingLevelId,
    this.value,
    this.minQty,
    this.maxQty,
    this.discountType,
    this.discountPrice,
    this.suggestedPrice,
    this.displayFor,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
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
  String? pricingLevelId;
  double? value;
  int? minQty;
  int? maxQty;
  String? discountType;
  int? discountPrice;
  double? suggestedPrice;
  String? displayFor;
  int? discount;

  Pricings({
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

  factory Pricings.fromJson(Map<String, dynamic> json) => Pricings(
    pricingLevelId: json["pricing_level_id"],
    value: json["value"]?.toDouble(),
    minQty: json["min_qty"],
    maxQty: json["max_qty"],
    discountType: json["discount_type"],
    discountPrice: json["discount_price"],
    suggestedPrice: json["suggested_price"]?.toDouble(),
    displayFor: json["display_for"],
    discount: json["discount"],
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

class Props {
  dynamic countries;
  dynamic areas;
  dynamic cities;
  dynamic provinces;
  dynamic selectedCountriesShowQuantityNumber;

  Props({
    this.countries,
    this.areas,
    this.cities,
    this.provinces,
    this.selectedCountriesShowQuantityNumber,
  });

  factory Props.fromJson(Map<String, dynamic> json) => Props(
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
