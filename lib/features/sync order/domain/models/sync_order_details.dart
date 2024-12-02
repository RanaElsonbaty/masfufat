// To parse this JSON data, do
//
//     final syncOrderDetailsModel = syncOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

SyncOrderDetailsModel syncOrderDetailsModelFromJson(String str) =>
    SyncOrderDetailsModel.fromJson(json.decode(str));

String syncOrderDetailsModelToJson(SyncOrderDetailsModel data) =>
    json.encode(data.toJson());

class SyncOrderDetailsModel {
  int? id;
  int? customerId;
  int? isGuest;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  dynamic paymentMethod;
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
  int? shippingCost;
  int? isShippingFree;
  String? orderGroupId;
  String? verificationCode;
  int? verificationStatus;
  int? sellerId;
  String? sellerIs;
  ShippingAddressData? shippingAddressData;
  dynamic deliveryManId;
  int? deliverymanCharge;
  dynamic expectedDeliveryDate;
  dynamic orderNote;
  dynamic billingAddress;
  BillingAddressData? billingAddressData;
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
  ShippingInfo? shippingInfo;
  String? history;
  int? showShippingmethodForCustomer;
  dynamic shippingTax;
  String? adminNote;
  ExternalOrder? externalOrder;

  SyncOrderDetailsModel({
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
    this.verificationCode,
    this.verificationStatus,
    this.sellerId,
    this.sellerIs,
    this.shippingAddressData,
    this.deliveryManId,
    this.deliverymanCharge,
    this.expectedDeliveryDate,
    this.orderNote,
    this.billingAddress,
    this.billingAddressData,
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
    this.externalOrder,
  });

  factory SyncOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      SyncOrderDetailsModel(
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
        discountAmount: json["discount_amount"]!=null?double.tryParse(json["discount_amount"].toString()):0.0,
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
        shippingAddressData: json["shipping_address_data"] == null
            ? null
            : ShippingAddressData.fromJson(json["shipping_address_data"]),
        deliveryManId: json["delivery_man_id"],
        deliverymanCharge: json["deliveryman_charge"],
        expectedDeliveryDate: json["expected_delivery_date"],
        orderNote: json["order_note"],
        billingAddress: json["billing_address"],
        billingAddressData: json["billing_address_data"] == null
            ? null
            : BillingAddressData.fromJson(json["billing_address_data"]),
        orderType: json["order_type"],
        extraDiscount: json["extra_discount"]!=null?double.tryParse(json["extra_discount"].toString()):0.00,
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
        shippingInfo: json["shipping_info"] == null
            ? null
            : ShippingInfo.fromJson(json["shipping_info"]),
        history: json["history"],
        showShippingmethodForCustomer: json["show_shippingmethod_for_customer"],
        shippingTax: json["shipping_tax"],
        adminNote: json["admin_note"],
        externalOrder: json["external_order"] == null
            ? null
            : ExternalOrder.fromJson(json["external_order"]),
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
    "verification_code": verificationCode,
    "verification_status": verificationStatus,
    "seller_id": sellerId,
    "seller_is": sellerIs,
    "shipping_address_data": shippingAddressData?.toJson(),
    "delivery_man_id": deliveryManId,
    "deliveryman_charge": deliverymanCharge,
    "expected_delivery_date": expectedDeliveryDate,
    "order_note": orderNote,
    "billing_address": billingAddress,
    "billing_address_data": billingAddressData?.toJson(),
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
    "shipping_info": shippingInfo?.toJson(),
    "history": history,
    "show_shippingmethod_for_customer": showShippingmethodForCustomer,
    "shipping_tax": shippingTax,
    "admin_note": adminNote,
    "external_order": externalOrder?.toJson(),
  };
}

class BillingAddressData {
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? isBilling;

  BillingAddressData({
    this.contactPersonName,
    this.addressType,
    this.address,
    this.city,
    this.zip,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.isBilling,
  });

  factory BillingAddressData.fromJson(Map<String, dynamic> json) =>
      BillingAddressData(
        contactPersonName: json["contact_person_name"],
        addressType: json["address_type"].toString(),
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        phone: json["phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        state: json["state"],
        country: json["country"],
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        isBilling: json["is_billing"].toString(),
      );

  Map<String, dynamic> toJson() => {
    "contact_person_name": contactPersonName,
    "address_type": addressType,
    "address": address,
    "city": city,
    "zip": zip,
    "phone": phone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "state": state,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "is_billing": isBilling,
  };
}

class ExternalOrder {
  int? id;
  String? externalOrderId;
  String? referenceId;
  DateTime? dateTime;
  String? status;
  String? paymentMethod;
  String? currency;
  Customer? customer;
  List<int>? items;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic localItems;
  String? total;
  List<int>? qtys;
  dynamic extId;
  String? sellerId;
  Details? details;

  ExternalOrder({
    this.id,
    this.externalOrderId,
    this.referenceId,
    this.dateTime,
    this.status,
    this.paymentMethod,
    this.currency,
    this.customer,
    this.items,
    this.createdAt,
    this.updatedAt,
    this.localItems,
    this.total,
    this.qtys,
    this.extId,
    this.sellerId,
    this.details,
  });

  factory ExternalOrder.fromJson(Map<String, dynamic> json) => ExternalOrder(
    id: json["id"],
    externalOrderId: json["external_order_id"],
    referenceId: json["reference_id"],
    dateTime: json["date_time"] == null
        ? null
        : DateTime.parse(json["date_time"]),
    status: json["status"],
    paymentMethod: json["payment_method"],
    currency: json["currency"],
    customer: json["customer"] == null
        ? null
        : Customer.fromJson(json["customer"]),
    items: json["items"] == null
        ? []
        : List<int>.from(json["items"]!.map((x) => x)),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    localItems: json["local_items"],
    total: json["total"],
    qtys: json["qtys"] == null
        ? []
        : List<int>.from(json["qtys"]!.map((x) => x)),
    extId: json["ext_id"],
    sellerId: json["seller_id"],
    details:
    json["details"] == null ? null : Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "external_order_id": externalOrderId,
    "reference_id": referenceId,
    "date_time": dateTime?.toIso8601String(),
    "status": status,
    "payment_method": paymentMethod,
    "currency": currency,
    "customer": customer?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "local_items": localItems,
    "total": total,
    "qtys": qtys == null ? [] : List<dynamic>.from(qtys!.map((x) => x)),
    "ext_id": extId,
    "seller_id": sellerId,
    "details": details?.toJson(),
  };
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;
  int? mobile;
  String? mobileCode;
  String? email;
  Urls? urls;
  String? avatar;
  String? gender;
  dynamic birthday;
  String? city;
  String? country;
  String? countryCode;
  String? currency;
  String? location;
  UpdatedAt? updatedAt;
  List<dynamic>? groups;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.mobileCode,
    this.email,
    this.urls,
    this.avatar,
    this.gender,
    this.birthday,
    this.city,
    this.country,
    this.countryCode,
    this.currency,
    this.location,
    this.updatedAt,
    this.groups,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: int.tryParse(json["id"].toString()),
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: int.tryParse(json["mobile"].toString()),
    mobileCode: json["mobile_code"],
    email: json["email"],
    urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
    avatar: json["avatar"],
    gender: json["gender"],
    birthday: json["birthday"],
    city: json["city"],
    country: json["country"],
    countryCode: json["country_code"],
    currency: json["currency"],
    location: json["location"],
    updatedAt: json["updated_at"] == null
        ? null
        : UpdatedAt.fromJson(json["updated_at"]),
    groups: json["groups"] == null
        ? []
        : List<dynamic>.from(json["groups"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "mobile_code": mobileCode,
    "email": email,
    "urls": urls?.toJson(),
    "avatar": avatar,
    "gender": gender,
    "birthday": birthday,
    "city": city,
    "country": country,
    "country_code": countryCode,
    "currency": currency,
    "location": location,
    "updated_at": updatedAt?.toJson(),
    "groups":
    groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
  };
}

class UpdatedAt {
  DateTime? date;
  int? timezoneType;
  String? timezone;

  UpdatedAt({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  factory UpdatedAt.fromJson(Map<String, dynamic> json) => UpdatedAt(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    timezoneType: json["timezone_type"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "timezone_type": timezoneType,
    "timezone": timezone,
  };
}

class Urls {
  String? customer;
  String? admin;

  Urls({
    this.customer,
    this.admin,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    customer: json["customer"],
    admin: json["admin"],
  );

  Map<String, dynamic> toJson() => {
    "customer": customer,
    "admin": admin,
  };
}

class Details {
  int? status;
  bool? success;
  Data? data;

  Details({
    this.status,
    this.success,
    this.data,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  dynamic cartReferenceId;
  int? referenceId;
  Urls? urls;
  UpdatedAt? date;
  UpdatedAt? updatedAt;
  String? source;
  String? sourceDevice;
  SourceDetails? sourceDetails;
  dynamic firstCompleteAt;
  Status? status;
  bool? isPriceQuote;
  String? paymentMethod;
  String? currency;
  DataAmounts? amounts;
  Shipping? shipping;
  List<ShipmentElement>? shipments;
  bool? canCancel;
  bool? showWeight;
  bool? canReorder;
  bool? isPendingPayment;
  int? pendingPaymentEndsAt;
  String? totalWeight;
  dynamic ratingLink;
  List<ShipmentBranch>? shipmentBranch;
  Customer? customer;
  List<Item>? items;
  Bank? bank;
  List<dynamic>? tags;
  Store? store;

  Data({
    this.id,
    this.cartReferenceId,
    this.referenceId,
    this.urls,
    this.date,
    this.updatedAt,
    this.source,
    this.sourceDevice,
    this.sourceDetails,
    this.firstCompleteAt,
    this.status,
    this.isPriceQuote,
    this.paymentMethod,
    this.currency,
    this.amounts,
    this.shipping,
    this.shipments,
    this.canCancel,
    this.showWeight,
    this.canReorder,
    this.isPendingPayment,
    this.pendingPaymentEndsAt,
    this.totalWeight,
    this.ratingLink,
    this.shipmentBranch,
    this.customer,
    this.items,
    this.bank,
    this.tags,
    this.store,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: int.tryParse(json["id"].toString()),
    cartReferenceId: json["cart_reference_id"],
    referenceId: int.tryParse(json["reference_id"].toString()),
    urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
    date: json["date"] == null ? null : UpdatedAt.fromJson(json["date"]),
    updatedAt: json["updated_at"] == null
        ? null
        : UpdatedAt.fromJson(json["updated_at"]),
    source: json["source"],
    sourceDevice: json["source_device"],
    sourceDetails: json["source_details"] == null
        ? null
        : SourceDetails.fromJson(json["source_details"]),
    firstCompleteAt: json["first_complete_at"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    isPriceQuote: json["is_price_quote"],
    paymentMethod: json["payment_method"],
    currency: json["currency"],
    amounts: json["amounts"] == null
        ? null
        : DataAmounts.fromJson(json["amounts"]),
    shipping: json["shipping"] == null
        ? null
        : Shipping.fromJson(json["shipping"]),
    shipments: json["shipments"] == null
        ? []
        : List<ShipmentElement>.from(
        json["shipments"]!.map((x) => ShipmentElement.fromJson(x))),
    canCancel: json["can_cancel"],
    showWeight: json["show_weight"],
    canReorder: json["can_reorder"],
    isPendingPayment: json["is_pending_payment"]=='1'?true:false,
    pendingPaymentEndsAt: json["pending_payment_ends_at"],
    totalWeight: json["total_weight"],
    ratingLink: json["rating_link"],
    shipmentBranch: json["shipment_branch"] == null
        ? []
        : List<ShipmentBranch>.from(json["shipment_branch"]!
        .map((x) => ShipmentBranch.fromJson(x))),
    customer: json["customer"] == null
        ? null
        : Customer.fromJson(json["customer"]),
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
    tags: json["tags"] == null
        ? []
        : List<dynamic>.from(json["tags"]!.map((x) => x)),
    store: json["store"] == null ? null : Store.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart_reference_id": cartReferenceId,
    "reference_id": referenceId,
    "urls": urls?.toJson(),
    "date": date?.toJson(),
    "updated_at": updatedAt?.toJson(),
    "source": source,
    "source_device": sourceDevice,
    "source_details": sourceDetails?.toJson(),
    "first_complete_at": firstCompleteAt,
    "status": status?.toJson(),
    "is_price_quote": isPriceQuote,
    "payment_method": paymentMethod,
    "currency": currency,
    "amounts": amounts?.toJson(),
    "shipping": shipping?.toJson(),
    "shipments": shipments == null
        ? []
        : List<dynamic>.from(shipments!.map((x) => x.toJson())),
    "can_cancel": canCancel,
    "show_weight": showWeight,
    "can_reorder": canReorder,
    "is_pending_payment": isPendingPayment,
    "pending_payment_ends_at": pendingPaymentEndsAt,
    "total_weight": totalWeight,
    "rating_link": ratingLink,
    "shipment_branch": shipmentBranch == null
        ? []
        : List<dynamic>.from(shipmentBranch!.map((x) => x.toJson())),
    "customer": customer?.toJson(),
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "bank": bank?.toJson(),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "store": store?.toJson(),
  };
}

class DataAmounts {
  CashOnDelivery? subTotal;
  CashOnDelivery? shippingCost;
  CashOnDelivery? cashOnDelivery;
  Tax? tax;
  List<dynamic>? discounts;
  CashOnDelivery? total;

  DataAmounts({
    this.subTotal,
    this.shippingCost,
    this.cashOnDelivery,
    this.tax,
    this.discounts,
    this.total,
  });

  factory DataAmounts.fromJson(Map<String, dynamic> json) => DataAmounts(
    subTotal: json["sub_total"] == null
        ? null
        : CashOnDelivery.fromJson(json["sub_total"]),
    shippingCost: json["shipping_cost"] == null
        ? null
        : CashOnDelivery.fromJson(json["shipping_cost"]),
    cashOnDelivery: json["cash_on_delivery"] == null
        ? null
        : CashOnDelivery.fromJson(json["cash_on_delivery"]),
    tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
    discounts: json["discounts"] == null
        ? []
        : List<dynamic>.from(json["discounts"]!.map((x) => x)),
    total: json["total"] == null
        ? null
        : CashOnDelivery.fromJson(json["total"]),
  );

  Map<String, dynamic> toJson() => {
    "sub_total": subTotal?.toJson(),
    "shipping_cost": shippingCost?.toJson(),
    "cash_on_delivery": cashOnDelivery?.toJson(),
    "tax": tax?.toJson(),
    "discounts": discounts == null
        ? []
        : List<dynamic>.from(discounts!.map((x) => x)),
    "total": total?.toJson(),
  };
}

class CashOnDelivery {
  double? amount;
  String? currency;

  CashOnDelivery({
    this.amount,
    this.currency,
  });

  factory CashOnDelivery.fromJson(Map<String, dynamic> json) => CashOnDelivery(
    amount: json["amount"]?.toDouble(),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
  };
}

class Tax {
  String? percent;
  CashOnDelivery? amount;

  Tax({
    this.percent,
    this.amount,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    percent: json["percent"],
    amount: json["amount"] == null
        ? null
        : CashOnDelivery.fromJson(json["amount"]),
  );

  Map<String, dynamic> toJson() => {
    "percent": percent,
    "amount": amount?.toJson(),
  };
}

class Bank {
  int? id;
  String? bankName;
  int? bankId;
  String? accountName;
  String? accountNumber;
  String? ibanNumber;
  dynamic ibanCertificate;
  dynamic sbcCertificate;
  String? certificateType;
  String? status;

  Bank({
    this.id,
    this.bankName,
    this.bankId,
    this.accountName,
    this.accountNumber,
    this.ibanNumber,
    this.ibanCertificate,
    this.sbcCertificate,
    this.certificateType,
    this.status,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["id"],
    bankName: json["bank_name"],
    bankId: json["bank_id"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
    ibanNumber: json["iban_number"],
    ibanCertificate: json["iban_certificate"],
    sbcCertificate: json["sbc_certificate"],
    certificateType: json["certificate_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_name": bankName,
    "bank_id": bankId,
    "account_name": accountName,
    "account_number": accountNumber,
    "iban_number": ibanNumber,
    "iban_certificate": ibanCertificate,
    "sbc_certificate": sbcCertificate,
    "certificate_type": certificateType,
    "status": status,
  };
}

class Item {
  int? id;
  String? name;
  String? sku;
  int? quantity;
  String? currency;
  double? weight;
  String? weightLabel;
  ItemAmounts? amounts;
  String? notes;
  Product? product;
  List<dynamic>? options;
  List<dynamic>? images;
  List<dynamic>? codes;
  List<dynamic>? files;
  List<dynamic>? productReservations;

  Item({
    this.id,
    this.name,
    this.sku,
    this.quantity,
    this.currency,
    this.weight,
    this.weightLabel,
    this.amounts,
    this.notes,
    this.product,
    this.options,
    this.images,
    this.codes,
    this.files,
    this.productReservations,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: int.tryParse(json["id"].toString()),
    name: json["name"],
    sku: json["sku"],
    quantity: json["quantity"],
    currency: json["currency"],
    weight: json["weight"]?.toDouble(),
    weightLabel: json["weight_label"],
    amounts: json["amounts"] == null
        ? null
        : ItemAmounts.fromJson(json["amounts"]),
    notes: json["notes"],
    product:
    json["product"] == null ? null : Product.fromJson(json["product"]),
    options: json["options"] == null
        ? []
        : List<dynamic>.from(json["options"]!.map((x) => x)),
    images: json["images"] == null
        ? []
        : List<dynamic>.from(json["images"]!.map((x) => x)),
    codes: json["codes"] == null
        ? []
        : List<dynamic>.from(json["codes"]!.map((x) => x)),
    files: json["files"] == null
        ? []
        : List<dynamic>.from(json["files"]!.map((x) => x)),
    productReservations: json["product_reservations"] == null
        ? []
        : List<dynamic>.from(json["product_reservations"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sku": sku,
    "quantity": quantity,
    "currency": currency,
    "weight": weight,
    "weight_label": weightLabel,
    "amounts": amounts?.toJson(),
    "notes": notes,
    "product": product?.toJson(),
    "options":
    options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "images":
    images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "codes": codes == null ? [] : List<dynamic>.from(codes!.map((x) => x)),
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
    "product_reservations": productReservations == null
        ? []
        : List<dynamic>.from(productReservations!.map((x) => x)),
  };
}

class ItemAmounts {
  CashOnDelivery? priceWithoutTax;
  CashOnDelivery? totalDiscount;
  Tax? tax;
  CashOnDelivery? total;

  ItemAmounts({
    this.priceWithoutTax,
    this.totalDiscount,
    this.tax,
    this.total,
  });

  factory ItemAmounts.fromJson(Map<String, dynamic> json) => ItemAmounts(
    priceWithoutTax: json["price_without_tax"] == null
        ? null
        : CashOnDelivery.fromJson(json["price_without_tax"]),
    totalDiscount: json["total_discount"] == null
        ? null
        : CashOnDelivery.fromJson(json["total_discount"]),
    tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
    total: json["total"] == null
        ? null
        : CashOnDelivery.fromJson(json["total"]),
  );

  Map<String, dynamic> toJson() => {
    "price_without_tax": priceWithoutTax?.toJson(),
    "total_discount": totalDiscount?.toJson(),
    "tax": tax?.toJson(),
    "total": total?.toJson(),
  };
}

class Product {
  int? id;
  String? type;
  Promotion? promotion;
  int? quantity;
  String? status;
  bool? isAvailable;
  String? sku;
  String? name;
  CashOnDelivery? price;
  CashOnDelivery? salePrice;
  String? currency;
  String? url;
  String? thumbnail;
  bool? hasSpecialPrice;
  CashOnDelivery? regularPrice;
  dynamic calories;
  dynamic mpn;
  dynamic gtin;
  String? description;
  dynamic favorite;
  Features? features;

  Product({
    this.id,
    this.type,
    this.promotion,
    this.quantity,
    this.status,
    this.isAvailable,
    this.sku,
    this.name,
    this.price,
    this.salePrice,
    this.currency,
    this.url,
    this.thumbnail,
    this.hasSpecialPrice,
    this.regularPrice,
    this.calories,
    this.mpn,
    this.gtin,
    this.description,
    this.favorite,
    this.features,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: int.tryParse(json["id"].toString()),
    type: json["type"],
    promotion: json["promotion"] == null
        ? null
        : Promotion.fromJson(json["promotion"]),
    quantity: json["quantity"],
    status: json["status"],
    isAvailable: json["is_available"],
    sku: json["sku"],
    name: json["name"],
    price: json["price"] == null
        ? null
        : CashOnDelivery.fromJson(json["price"]),
    salePrice: json["sale_price"] == null
        ? null
        : CashOnDelivery.fromJson(json["sale_price"]),
    currency: json["currency"],
    url: json["url"],
    thumbnail: json["thumbnail"],
    hasSpecialPrice: json["has_special_price"],
    regularPrice: json["regular_price"] == null
        ? null
        : CashOnDelivery.fromJson(json["regular_price"]),
    calories: json["calories"],
    mpn: json["mpn"],
    gtin: json["gtin"],
    description: json["description"],
    favorite: json["favorite"],
    features: json["features"] == null
        ? null
        : Features.fromJson(json["features"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "promotion": promotion?.toJson(),
    "quantity": quantity,
    "status": status,
    "is_available": isAvailable,
    "sku": sku,
    "name": name,
    "price": price?.toJson(),
    "sale_price": salePrice?.toJson(),
    "currency": currency,
    "url": url,
    "thumbnail": thumbnail,
    "has_special_price": hasSpecialPrice,
    "regular_price": regularPrice?.toJson(),
    "calories": calories,
    "mpn": mpn,
    "gtin": gtin,
    "description": description,
    "favorite": favorite,
    "features": features?.toJson(),
  };
}

class Features {
  dynamic availabilityNotify;
  bool? showRating;

  Features({
    this.availabilityNotify,
    this.showRating,
  });

  factory Features.fromJson(Map<String, dynamic> json) => Features(
    availabilityNotify: json["availability_notify"],
    showRating: json["show_rating"],
  );

  Map<String, dynamic> toJson() => {
    "availability_notify": availabilityNotify,
    "show_rating": showRating,
  };
}

class Promotion {
  dynamic title;
  String? subTitle;

  Promotion({
    this.title,
    this.subTitle,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
    title: json["title"],
    subTitle: json["sub_title"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "sub_title": subTitle,
  };
}

class ShipmentBranch {
  int? id;
  String? name;
  String? status;
  bool? isDefault;
  List<dynamic>? type;

  ShipmentBranch({
    this.id,
    this.name,
    this.status,
    this.isDefault,
    this.type,
  });

  factory ShipmentBranch.fromJson(Map<String, dynamic> json) => ShipmentBranch(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    isDefault: json["is_default"],
    type: json["type"] == null
        ? []
        : List<dynamic>.from(json["type"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "is_default": isDefault,
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
  };
}

class ShipmentElement {
  int? id;
  dynamic createdAt;
  String? type;
  int? courierId;
  String? courierName;
  String? courierLogo;
  dynamic shippingNumber;
  dynamic trackingNumber;
  dynamic pickupId;
  bool? trackable;
  dynamic trackingLink;
  dynamic label;
  String? paymentMethod;
  String? source;
  String? status;
  CashOnDelivery? total;
  CashOnDelivery? cashOnDelivery;
  bool? isInternational;
  Weight? totalWeight;
  List<Package>? packages;
  Ship? shipFrom;
  Ship? shipTo;
  Meta? meta;

  ShipmentElement({
    this.id,
    this.createdAt,
    this.type,
    this.courierId,
    this.courierName,
    this.courierLogo,
    this.shippingNumber,
    this.trackingNumber,
    this.pickupId,
    this.trackable,
    this.trackingLink,
    this.label,
    this.paymentMethod,
    this.source,
    this.status,
    this.total,
    this.cashOnDelivery,
    this.isInternational,
    this.totalWeight,
    this.packages,
    this.shipFrom,
    this.shipTo,
    this.meta,
  });

  factory ShipmentElement.fromJson(Map<String, dynamic> json) =>
      ShipmentElement(
        id: json["id"],
        createdAt: json["created_at"],
        type: json["type"],
        courierId: json["courier_id"],
        courierName: json["courier_name"],
        courierLogo: json["courier_logo"],
        shippingNumber: json["shipping_number"],
        trackingNumber: json["tracking_number"],
        pickupId: json["pickup_id"],
        trackable: json["trackable"],
        trackingLink: json["tracking_link"],
        label: json["label"],
        paymentMethod: json["payment_method"],
        source: json["source"],
        status: json["status"],
        total: json["total"] == null
            ? null
            : CashOnDelivery.fromJson(json["total"]),
        cashOnDelivery: json["cash_on_delivery"] == null
            ? null
            : CashOnDelivery.fromJson(json["cash_on_delivery"]),
        isInternational: json["is_international"],
        totalWeight: json["total_weight"] == null
            ? null
            : Weight.fromJson(json["total_weight"]),
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
            json["packages"]!.map((x) => Package.fromJson(x))),
        shipFrom:
        json["ship_from"] == null ? null : Ship.fromJson(json["ship_from"]),
        shipTo: json["ship_to"] == null ? null : Ship.fromJson(json["ship_to"]),
        // meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "type": type,
    "courier_id": courierId,
    "courier_name": courierName,
    "courier_logo": courierLogo,
    "shipping_number": shippingNumber,
    "tracking_number": trackingNumber,
    "pickup_id": pickupId,
    "trackable": trackable,
    "tracking_link": trackingLink,
    "label": label,
    "payment_method": paymentMethod,
    "source": source,
    "status": status,
    "total": total?.toJson(),
    "cash_on_delivery": cashOnDelivery?.toJson(),
    "is_international": isInternational,
    "total_weight": totalWeight?.toJson(),
    "packages": packages == null
        ? []
        : List<dynamic>.from(packages!.map((x) => x.toJson())),
    "ship_from": shipFrom?.toJson(),
    "ship_to": shipTo?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Meta {
  int? appId;
  List<dynamic>? policyOptions;

  Meta({
    this.appId,
    this.policyOptions,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    appId: json["app_id"],
    policyOptions: json["policy_options"] == null
        ? []
        : List<dynamic>.from(json["policy_options"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "app_id": appId,
    "policy_options": policyOptions == null
        ? []
        : List<dynamic>.from(policyOptions!.map((x) => x)),
  };
}

class Package {
  int? itemId;
  dynamic externalId;
  String? name;
  String? sku;
  CashOnDelivery? price;
  int? quantity;
  Weight? weight;

  Package({
    this.itemId,
    this.externalId,
    this.name,
    this.sku,
    this.price,
    this.quantity,
    this.weight,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    itemId: json["item_id"],
    externalId: json["external_id"],
    name: json["name"],
    sku: json["sku"],
    price: json["price"] == null
        ? null
        : CashOnDelivery.fromJson(json["price"]),
    quantity: json["quantity"],
    weight: json["weight"] == null ? null : Weight.fromJson(json["weight"]),
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "external_id": externalId,
    "name": name,
    "sku": sku,
    "price": price?.toJson(),
    "quantity": quantity,
    "weight": weight?.toJson(),
  };
}

class Weight {
  double? value;
  String? units;

  Weight({
    this.value,
    this.units,
  });

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
    value: json["value"]?.toDouble(),
    units: json["units"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "units": units,
  };
}

class Ship {
  String? type;
  String? name;
  String? email;
  String? phone;
  String? country;
  int? countryId;
  String? countryCode;
  String? city;
  int? cityId;
  String? addressLine;
  String? streetNumber;
  String? block;
  String? postalCode;
  double? latitude;
  double? longitude;
  int? branchId;

  Ship({
    this.type,
    this.name,
    this.email,
    this.phone,
    this.country,
    this.countryId,
    this.countryCode,
    this.city,
    this.cityId,
    this.addressLine,
    this.streetNumber,
    this.block,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.branchId,
  });

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
    type: json["type"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    country: json["country"],
    countryId: json["country_id"],
    countryCode: json["country_code"],
    city: json["city"],
    cityId: json["city_id"],
    addressLine: json["address_line"],
    streetNumber: json["street_number"],
    block: json["block"],
    postalCode: json["postal_code"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    branchId: json["branch_id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "email": email,
    "phone": phone,
    "country": country,
    "country_id": countryId,
    "country_code": countryCode,
    "city": city,
    "city_id": cityId,
    "address_line": addressLine,
    "street_number": streetNumber,
    "block": block,
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
    "branch_id": branchId,
  };
}

class Shipping {
  int? id;
  dynamic appId;
  String? company;
  String? logo;
  Receiver? receiver;
  Receiver? shipper;
  Address? pickupAddress;
  Address? address;
  ShippingShipment? shipment;
  List<dynamic>? policyOptions;
  int? shipmentReference;
  int? branchId;

  Shipping({
    this.id,
    this.appId,
    this.company,
    this.logo,
    this.receiver,
    this.shipper,
    this.pickupAddress,
    this.address,
    this.shipment,
    this.policyOptions,
    this.shipmentReference,
    this.branchId,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    id: json["id"],
    appId: json["app_id"],
    company: json["company"],
    logo: json["logo"],
    receiver: json["receiver"] == null
        ? null
        : Receiver.fromJson(json["receiver"]),
    shipper:
    json["shipper"] == null ? null : Receiver.fromJson(json["shipper"]),
    pickupAddress: json["pickup_address"] == null
        ? null
        : Address.fromJson(json["pickup_address"]),
    address:
    json["address"] == null ? null : Address.fromJson(json["address"]),
    shipment: json["shipment"] == null
        ? null
        : ShippingShipment.fromJson(json["shipment"]),
    // policyOptions: json["policy_options"] == null
    //     ? []
    //     : List<dynamic>.from(json["policy_options"]!.map((x) => x)),
    shipmentReference: json["shipment_reference"],
    branchId: json["branch_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "app_id": appId,
    "company": company,
    "logo": logo,
    "receiver": receiver?.toJson(),
    "shipper": shipper?.toJson(),
    "pickup_address": pickupAddress?.toJson(),
    "address": address?.toJson(),
    "shipment": shipment?.toJson(),
    "policy_options": policyOptions == null
        ? []
        : List<dynamic>.from(policyOptions!.map((x) => x)),
    "shipment_reference": shipmentReference,
    "branch_id": branchId,
  };
}

class Address {
  String? country;
  String? countryCode;
  String? city;
  String? shippingAddress;
  String? streetNumber;
  String? block;
  String? postalCode;
  GeoCoordinates? geoCoordinates;

  Address({
    this.country,
    this.countryCode,
    this.city,
    this.shippingAddress,
    this.streetNumber,
    this.block,
    this.postalCode,
    this.geoCoordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"],
    countryCode: json["country_code"],
    city: json["city"],
    shippingAddress: json["shipping_address"],
    streetNumber: json["street_number"],
    block: json["block"],
    postalCode: json["postal_code"],
    geoCoordinates: json["geo_coordinates"] == null
        ? null
        : GeoCoordinates.fromJson(json["geo_coordinates"]),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "country_code": countryCode,
    "city": city,
    "shipping_address": shippingAddress,
    "street_number": streetNumber,
    "block": block,
    "postal_code": postalCode,
    "geo_coordinates": geoCoordinates?.toJson(),
  };
}

class GeoCoordinates {
  double? lat;
  double? lng;

  GeoCoordinates({
    this.lat,
    this.lng,
  });

  factory GeoCoordinates.fromJson(Map<String, dynamic> json) => GeoCoordinates(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Receiver {
  String? name;
  String? email;
  String? phone;
  String? companyName;

  Receiver({
    this.name,
    this.email,
    this.phone,
    this.companyName,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    companyName: json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "company_name": companyName,
  };
}

class ShippingShipment {
  String? id;
  dynamic pickupId;
  String? trackingLink;
  List<dynamic>? label;

  ShippingShipment({
    this.id,
    this.pickupId,
    this.trackingLink,
    this.label,
  });

  factory ShippingShipment.fromJson(Map<String, dynamic> json) =>
      ShippingShipment(
        id: json["id"],
        pickupId: json["pickup_id"],
        trackingLink: json["tracking_link"],
        // label: json["label"] == null
        //     ? []
        //     : List<dynamic>.from(json["label"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pickup_id": pickupId,
    "tracking_link": trackingLink,
    "label": label == null ? [] : List<dynamic>.from(label!.map((x) => x)),
  };
}

class SourceDetails {
  String? type;
  dynamic value;
  String? device;
  String? userAgent;
  dynamic ip;

  SourceDetails({
    this.type,
    this.value,
    this.device,
    this.userAgent,
    this.ip,
  });

  factory SourceDetails.fromJson(Map<String, dynamic> json) => SourceDetails(
    type: json["type"],
    value: json["value"],
    device: json["device"],
    userAgent: json["user-agent"],
    ip: json["ip"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
    "device": device,
    "user-agent": userAgent,
    "ip": ip,
  };
}

class Status {
  int? id;
  String? name;
  String? slug;
  Customized? customized;

  Status({
    this.id,
    this.name,
    this.slug,
    this.customized,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    customized: json["customized"] == null
        ? null
        : Customized.fromJson(json["customized"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "customized": customized?.toJson(),
  };
}

class Customized {
  int? id;
  String? name;

  Customized({
    this.id,
    this.name,
  });

  factory Customized.fromJson(Map<String, dynamic> json) => Customized(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Store {
  int? id;
  int? storeId;
  int? userId;
  String? userEmail;
  String? username;
  Name? name;
  String? avatar;

  Store({
    this.id,
    this.storeId,
    this.userId,
    this.userEmail,
    this.username,
    this.name,
    this.avatar,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    storeId: json["store_id"],
    userId: json["user_id"],
    userEmail: json["user_email"],
    username: json["username"],
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "user_id": userId,
    "user_email": userEmail,
    "username": username,
    "name": name?.toJson(),
    "avatar": avatar,
  };
}

class Name {
  String? ar;
  dynamic en;

  Name({
    this.ar,
    this.en,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    ar: json["ar"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "ar": ar,
    "en": en,
  };
}

class ShippingAddressData {
  int? id;
  dynamic customerId;
  int? isGuest;
  String? contactPersonName;
  dynamic email;
  String? addressType;
  String? address;
  String? city;
  dynamic zip;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic state;
  String? country;
  String? latitude;
  String? longitude;
  int? isBilling;
  String? areaId;
  String? title;

  ShippingAddressData({
    this.id,
    this.customerId,
    this.isGuest,
    this.contactPersonName,
    this.email,
    this.addressType,
    this.address,
    this.city,
    this.zip,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.isBilling,
    this.areaId,
    this.title,
  });

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) =>
      ShippingAddressData(
        id: json["id"],
        customerId: json["customer_id"],
        isGuest: json["is_guest"],
        contactPersonName: json["contact_person_name"],
        email: json["email"],
        addressType: json["address_type"].toString(),
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        phone: json["phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        state: json["state"],
        country: json["country"],
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        isBilling: json["is_billing"].toString()=='1'?1:0,
        areaId: json["area_id"].toString(),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "is_guest": isGuest,
    "contact_person_name": contactPersonName,
    "email": email,
    "address_type": addressType,
    "address": address,
    "city": city,
    "zip": zip,
    "phone": phone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "state": state,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "is_billing": isBilling,
    "area_id": areaId,
    "title": title,
  };
}

class ShippingInfo {
  String? status;
  ShipmentData? shipmentData;
  ErInfo? senderInfo;
  ErInfo? receiverInfo;
  List<Dimension>? dimension;
  List<TravelHistory>? travelHistory;

  ShippingInfo({
    this.status,
    this.shipmentData,
    this.senderInfo,
    this.receiverInfo,
    this.dimension,
    this.travelHistory,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) => ShippingInfo(
    status: json["status"],
    shipmentData: json["shipment_data"] == null
        ? null
        : ShipmentData.fromJson(json["shipment_data"]),
    senderInfo: json["sender_info"] == null
        ? null
        : ErInfo.fromJson(json["sender_info"]),
    receiverInfo: json["receiver_info"] == null
        ? null
        : ErInfo.fromJson(json["receiver_info"]),
    dimension: json["dimension"] == null
        ? []
        : List<Dimension>.from(
        json["dimension"]!.map((x) => Dimension.fromJson(x))),
    travelHistory: json["travel_history"] == null
        ? []
        : List<TravelHistory>.from(
        json["travel_history"]!.map((x) => TravelHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "shipment_data": shipmentData?.toJson(),
    "sender_info": senderInfo?.toJson(),
    "receiver_info": receiverInfo?.toJson(),
    "dimension": dimension == null
        ? []
        : List<dynamic>.from(dimension!.map((x) => x.toJson())),
    "travel_history": travelHistory == null
        ? []
        : List<dynamic>.from(travelHistory!.map((x) => x.toJson())),
  };
}

class Dimension {
  String? sku;
  String? cod;
  String? pieces;
  String? weight;
  String? description;

  Dimension({
    this.sku,
    this.cod,
    this.pieces,
    this.weight,
    this.description,
  });

  factory Dimension.fromJson(Map<String, dynamic> json) => Dimension(
    sku: json["sku"],
    cod: json["cod"],
    pieces: json["pieces"],
    weight: json["weight"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "sku": sku,
    "cod": cod,
    "pieces": pieces,
    "weight": weight,
    "description": description,
  };
}

class ErInfo {
  String? name;
  String? mobile;
  String? address;

  ErInfo({
    this.name,
    this.mobile,
    this.address,
  });

  factory ErInfo.fromJson(Map<String, dynamic> json) => ErInfo(
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "address": address,
  };
}

class ShipmentData {
  String? awbNo;
  DateTime? entryDate;
  String? paymentMethod;
  String? weight;
  String? status;
  String? productType;
  String? code;
  dynamic shippingCompany;
  String? shippingTrackingNo;
  String? shippingTrackingUrl;
  String? origin;
  String? destination;

  ShipmentData({
    this.awbNo,
    this.entryDate,
    this.paymentMethod,
    this.weight,
    this.status,
    this.productType,
    this.code,
    this.shippingCompany,
    this.shippingTrackingNo,
    this.shippingTrackingUrl,
    this.origin,
    this.destination,
  });

  factory ShipmentData.fromJson(Map<String, dynamic> json) => ShipmentData(
    awbNo: json["awb_no"],
    entryDate: json["entry_date"] == null
        ? null
        : DateTime.parse(json["entry_date"]),
    paymentMethod: json["payment_method"],
    weight: json["weight"],
    status: json["status"],
    productType: json["product_type"],
    code: json["code"],
    shippingCompany: json["shipping_company"],
    shippingTrackingNo: json["shipping_tracking_no"],
    shippingTrackingUrl: json["shipping_tracking_url"],
    origin: json["origin"],
    destination: json["destination"],
  );

  Map<String, dynamic> toJson() => {
    "awb_no": awbNo,
    "entry_date": entryDate?.toIso8601String(),
    "payment_method": paymentMethod,
    "weight": weight,
    "status": status,
    "product_type": productType,
    "code": code,
    "shipping_company": shippingCompany,
    "shipping_tracking_no": shippingTrackingNo,
    "shipping_tracking_url": shippingTrackingUrl,
    "origin": origin,
    "destination": destination,
  };
}

class TravelHistory {
  String? newLocation;
  String? newStatus;
  String? activites;
  String? code;
  String? comment;
  DateTime? entryDate;

  TravelHistory({
    this.newLocation,
    this.newStatus,
    this.activites,
    this.code,
    this.comment,
    this.entryDate,
  });

  factory TravelHistory.fromJson(Map<String, dynamic> json) => TravelHistory(
    newLocation: json["new_location"],
    newStatus: json["new_status"],
    activites: json["Activites"],
    code: json["code"],
    comment: json["comment"],
    entryDate: json["entry_date"] == null
        ? null
        : DateTime.parse(json["entry_date"]),
  );

  Map<String, dynamic> toJson() => {
    "new_location": newLocation,
    "new_status": newStatus,
    "Activites": activites,
    "code": code,
    "comment": comment,
    "entry_date": entryDate?.toIso8601String(),
  };
}
