// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  final int id;
  final int customerId;
  final String paymentStatus;
  final String orderStatus;
  final String paymentMethod;
  final String transactionRef;
  final dynamic paymentBy;
  final dynamic paymentNote;
  final double orderAmount;
  final String isPause;
  final dynamic cause;
  final int shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double discountAmount;
  final dynamic discountType;
  final dynamic couponCode;
  final dynamic shippingResponsibility;
  final int shippingMethodId;
  final double shippingCost;
  final int isShippingFree;
  final String orderGroupId;
  final String verificationCode;
  final int verificationStatus;
  final int sellerId;
  final String sellerIs;
  final ShippingAddressData shippingAddressData;
  final dynamic deliveryManId;
  final int deliverymanCharge;
  final dynamic expectedDeliveryDate;
  final dynamic orderNote;
  final int billingAddress;
  final BillingAddressData billingAddressData;
  final String orderType;
  final double extraDiscount;
  final dynamic extraDiscountType;
  final dynamic freeDeliveryBearer;
  final int checked;
  final String shippingType;
  final dynamic deliveryType;
  final dynamic deliveryServiceName;
  final dynamic thirdPartyDeliveryTrackingId;
  final dynamic extOrderId;
  final String bankDetails;
  final dynamic shippingInfo;
  final String history;
  final int showShippingmethodForCustomer;
  final String shippingTax;
  final String adminNote;
  final String orderAttachments;
  final dynamic packageCount;
  final dynamic customPackagingId;
  final String byAdmin;
  final dynamic shipment;
  final dynamic deliveryMan;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.paymentStatus,
    required this.orderStatus,
    required this.paymentMethod,
    required this.transactionRef,
    required this.paymentBy,
    required this.paymentNote,
    required this.orderAmount,
    required this.isPause,
    required this.cause,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.discountAmount,
    required this.discountType,
    required this.couponCode,
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
    required this.shipment,
    required this.deliveryMan,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    customerId: json["customer_id"],
    paymentStatus:json["payment_status"],
    orderStatus: json["order_status"],
    paymentMethod: json["payment_method"]??'',
    transactionRef: json["transaction_ref"],
    paymentBy: json["payment_by"],
    paymentNote: json["payment_note"],
    orderAmount: json["order_amount"].toDouble(),
    isPause: json["is_pause"],
    cause: json["cause"],
    shippingAddress: json["shipping_address"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    discountAmount: json["discount_amount"]!=null?double.parse(json["discount_amount"].toString()):0.00,
    discountType: json["discount_type"],
    couponCode: json["coupon_code"],
    shippingResponsibility: json["shipping_responsibility"],
    shippingMethodId: json["shipping_method_id"],
    shippingCost:json["shipping_cost"]!=null? double.parse(json["shipping_cost"].toString()):0.00,
    isShippingFree: json["is_shipping_free"],
    orderGroupId: json["order_group_id"],
    verificationCode: json["verification_code"],
    verificationStatus: json["verification_status"],
    sellerId: json["seller_id"],
    sellerIs: json["seller_is"].toString(),
    shippingAddressData: ShippingAddressData.fromJson(json["shipping_address_data"]),
    deliveryManId: json["delivery_man_id"],
    deliverymanCharge: json["deliveryman_charge"],
    expectedDeliveryDate: json["expected_delivery_date"],
    orderNote: json["order_note"],
    billingAddress: json["billing_address"]??0,
    billingAddressData: BillingAddressData.fromJson(json["billing_address_data"]),
    orderType: json["order_type"],
    extraDiscount: json["extra_discount"]!=null?double.parse(json["extra_discount"].toString()):0.00,
    extraDiscountType: json["extra_discount_type"],
    freeDeliveryBearer: json["free_delivery_bearer"],
    checked: json["checked"],
    shippingType:json["shipping_type"].toString(),
    deliveryType: json["delivery_type"],
    deliveryServiceName: json["delivery_service_name"],
    thirdPartyDeliveryTrackingId: json["third_party_delivery_tracking_id"],
    extOrderId: json["ext_order_id"],
    bankDetails: json["bank_details"],
    shippingInfo: json["shipping_info"],
    history: json["history"],
    showShippingmethodForCustomer: json["show_shippingmethod_for_customer"],
    shippingTax: json["shipping_tax"].toString(),
    adminNote: json["admin_note"]??'',
    orderAttachments:json["order_attachments"].toString(),
    packageCount: json["package_count"],
    customPackagingId: json["custom_packaging_id"],
    byAdmin: json["by_admin"]??'',
    shipment: json["shipment"]??'',
    deliveryMan: json["delivery_man"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "order_status": orderStatusValues.reverse[orderStatus],
    "payment_method": paymentMethodValues.reverse[paymentMethod],
    "transaction_ref": transactionRef,
    "payment_by": paymentBy,
    "payment_note": paymentNote,
    "order_amount": orderAmount,
    "is_pause": isPause,
    "cause": cause,
    "shipping_address": shippingAddress,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "discount_amount": discountAmount,
    "discount_type": discountType,
    "coupon_code": couponCode,
    "shipping_responsibility": shippingResponsibility,
    "shipping_method_id": shippingMethodId,
    "shipping_cost": shippingCost,
    "is_shipping_free": isShippingFree,
    "order_group_id": orderGroupId,
    "verification_code": verificationCode,
    "verification_status": verificationStatus,
    "seller_id": sellerId,
    "seller_is": sellerIsValues.reverse[sellerIs],
    "shipping_address_data": shippingAddressData.toJson(),
    "delivery_man_id": deliveryManId,
    "deliveryman_charge": deliverymanCharge,
    "expected_delivery_date": expectedDeliveryDate,
    "order_note": orderNote,
    "billing_address": billingAddress,
    "billing_address_data": billingAddressData.toJson(),
    "order_type": orderTypeValues.reverse[orderType],
    "extra_discount": extraDiscount,
    "extra_discount_type": extraDiscountType,
    "free_delivery_bearer": freeDeliveryBearer,
    "checked": checked,
    "shipping_type": shippingTypeValues.reverse[shippingType],
    "delivery_type": deliveryType,
    "delivery_service_name": deliveryServiceName,
    "third_party_delivery_tracking_id": thirdPartyDeliveryTrackingId,
    "ext_order_id": extOrderId,
    "bank_details": bankDetails,
    "shipping_info": shippingInfo,
    "history": history,
    "show_shippingmethod_for_customer": showShippingmethodForCustomer,
    "shipping_tax": shippingTax,
    "admin_note": adminNote,
    "order_attachments": orderAttachmentsValues.reverse[orderAttachments],
    "package_count": packageCount,
    "custom_packaging_id": customPackagingId,
    "by_admin": byAdmin,
    "shipment": shipment,
    "delivery_man": deliveryMan,
  };
}

enum AdminCommission {
  EMPTY,
  THE_000
}

final adminCommissionValues = EnumValues({
  "": AdminCommission.EMPTY,
  "0.00": AdminCommission.THE_000
});

class BillingAddressData {
  final int id;
  final int customerId;
  final int isGuest;
  final String contactPersonName;
  final dynamic email;
  final String addressType;
  // final Address address;
  final String city;
  final String zip;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String state;
  final String country;
  final String latitude;
  final String longitude;
  final dynamic isBilling;
  final String areaId;
  final String title;
  final String name;
  final String orderId;
  final int manUpdated;

  BillingAddressData({
    required this.id,
    required this.customerId,
    required this.isGuest,
    required this.contactPersonName,
    required this.email,
    required this.addressType,
    // required this.address,
    required this.city,
    required this.zip,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isBilling,
    required this.areaId,
    required this.title,
    required this.name,
    required this.orderId,
    required this.manUpdated,
  });

  factory BillingAddressData.fromJson(Map<String, dynamic> json) => BillingAddressData(
    id: json["id"]??0,
    customerId: json["customer_id"]??0,
    isGuest: json["is_guest"]??0,
    contactPersonName: json["contact_person_name"],
    email: json["email"],
    addressType: json["address_type"],
    // address: addressValues.map[json["address"]],
    city: json["city"].toString(),
    zip: json["zip"],
    phone: json["phone"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    state: json["state"]??'0',
    country: json["country"],
    latitude:json["latitude"].toString(),
    longitude: json["longitude"].toString(),
    isBilling: json["is_billing"],
    areaId: json["area_id"].toString(),
    title:json["title"]??'',
    name:json["name"]??'',
    orderId: json["order_id"]??'',
    manUpdated: json["man_updated"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "is_guest": isGuest,
    "contact_person_name": nameValues.reverse[contactPersonName],
    "email": email,
    "address_type": addressType,
    // "address": addressValues.reverse[address],
    "city": city,
    "zip": zip,
    "phone": phoneValues.reverse[phone],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "state": stateValues.reverse[state],
    "country": countryValues.reverse[country],
    "latitude": latitudeValues.reverse[latitude],
    "longitude": adminCommissionValues.reverse[longitude],
    "is_billing": isBilling,
    "area_id": areaId,
    "title": titleValues.reverse[title],
    "name": nameValues.reverse[name],
    "order_id": orderId,
    "man_updated": manUpdated,
  };
}

enum Address {
  EMPTY,
  RIYADH,
  TESTTEST
}

final addressValues = EnumValues({
  "": Address.EMPTY,
  "RIYADH": Address.RIYADH,
  "testtest": Address.TESTTEST
});

enum Name {
  EMPTY,
  NAME
}

final nameValues = EnumValues({
  "متجر تجريبي (للبلاتفورم)": Name.EMPTY,
  "": Name.NAME
});

enum Country {
  EMPTY,
  SA
}

final countryValues = EnumValues({
  "": Country.EMPTY,
  "SA": Country.SA
});

enum Latitude {
  EMPTY,
  THE_0000
}

final latitudeValues = EnumValues({
  "": Latitude.EMPTY,
  "0.000": Latitude.THE_0000
});

enum Phone {
  EMPTY,
  THE_966500000000,
  THE_96665533112221
}

final phoneValues = EnumValues({
  "": Phone.EMPTY,
  "+966500000000": Phone.THE_966500000000,
  "+96665533112221": Phone.THE_96665533112221
});

enum State {
  NULL
}

final stateValues = EnumValues({
  "null": State.NULL
});

enum Title {
  EMPTY,
  TEST,
  THE_2_BJNX_Y2_S
}

final titleValues = EnumValues({
  "عبدالرحمن": Title.EMPTY,
  "Test": Title.TEST,
  "2BjnxY2S": Title.THE_2_BJNX_Y2_S
});

enum CouponDiscountBearer {
  INHOUSE
}

final couponDiscountBearerValues = EnumValues({
  "inhouse": CouponDiscountBearer.INHOUSE
});

enum CustomerType {
  CUSTOMER
}

final customerTypeValues = EnumValues({
  "customer": CustomerType.CUSTOMER
});

enum OrderAttachments {
  EMPTY
}

final orderAttachmentsValues = EnumValues({
  "[]": OrderAttachments.EMPTY
});

enum OrderStatus {
  DELIVERED,
  NEW,
  PENDING_PAYMENT
}

final orderStatusValues = EnumValues({
  "delivered": OrderStatus.DELIVERED,
  "new": OrderStatus.NEW,
  "pending_payment": OrderStatus.PENDING_PAYMENT
});

enum OrderType {
  DEFAULT_TYPE
}

final orderTypeValues = EnumValues({
  "default_type": OrderType.DEFAULT_TYPE
});

enum OrderedUsing {
  DART,
  WINDOWS
}

final orderedUsingValues = EnumValues({
  "Dart": OrderedUsing.DART,
  "Windows": OrderedUsing.WINDOWS
});

enum PaymentMethod {
  CASH_ON_DELIVERY,
  DELAYED,
  EMPTY,
  PAYMENT_DELAYED,
  PAY_BY_WALLET
}

final paymentMethodValues = EnumValues({
  "cash_on_delivery": PaymentMethod.CASH_ON_DELIVERY,
  "delayed": PaymentMethod.DELAYED,
  "-": PaymentMethod.EMPTY,
  "payment_delayed": PaymentMethod.PAYMENT_DELAYED,
  "pay_by_wallet": PaymentMethod.PAY_BY_WALLET
});

enum PaymentStatus {
  PAID,
  UNPAID
}

final paymentStatusValues = EnumValues({
  "paid": PaymentStatus.PAID,
  "unpaid": PaymentStatus.UNPAID
});

enum SellerIs {
  SELLER
}

final sellerIsValues = EnumValues({
  "seller": SellerIs.SELLER
});

class ShippingAddressData {
  final int id;
  final int customerId;
  final int isGuest;
  final String contactPersonName;
  final dynamic email;
  final String addressType;
  final String address;
  final String city;
  final String zip;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic state;
  final String country;
  final String latitude;
  final String longitude;
  final int isBilling;
  final String areaId;
  final String title;
  final String name;
  final String orderId;
  final int manUpdated;

  ShippingAddressData({
    required this.id,
    required this.customerId,
    required this.isGuest,
    required this.contactPersonName,
    required this.email,
    required this.addressType,
    required this.address,
    required this.city,
    required this.zip,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isBilling,
    required this.areaId,
    required this.title,
    required this.name,
    required this.orderId,
    required this.manUpdated,
  });

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) => ShippingAddressData(
    id: json["id"]??0,
    customerId: json["customer_id"]??0,
    isGuest: json["is_guest"]??0,
    contactPersonName: json["contact_person_name"],
    email: json["email"],
    addressType: json["address_type"],
    address: json["address"],
    city: json["city"],
    zip: json["zip"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    state: json["state"],
    country: json["country"].toString(),
    latitude: json["latitude"] ?? '',
    longitude: json["longitude"] ?? "",
    isBilling: json["is_billing"],
    areaId: json["area_id"]??0,
    orderId: json["order_id"]??'',
    manUpdated: json["man_updated"]??0, name: json['name']??'', title: json['title']??'',
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "state": state,
    "country": countryValues.reverse[country],
    "latitude": latitude,
    "longitude": longitude,
    "is_billing": isBilling,
    "area_id": areaId,
    "title": title,
    "name":name,
    "order_id": orderId,
    "man_updated": manUpdated,
  };
}

enum ContactPersonName {
  ALI_HASSAN,
  EMPTY
}

final contactPersonNameValues = EnumValues({
  "Ali Hassan": ContactPersonName.ALI_HASSAN,
  "متجر تجريبي (للبلاتفورم)": ContactPersonName.EMPTY
});

class ShippingInfoClass {
  final String status;
  final ShipmentData shipmentData;
  final ErInfo senderInfo;
  final ErInfo receiverInfo;
  final List<Dimension> dimension;
  final List<TravelHistory> travelHistory;

  ShippingInfoClass({
    required this.status,
    required this.shipmentData,
    required this.senderInfo,
    required this.receiverInfo,
    required this.dimension,
    required this.travelHistory,
  });

  factory ShippingInfoClass.fromJson(Map<String, dynamic> json) => ShippingInfoClass(
    status: json["status"],
    shipmentData: ShipmentData.fromJson(json["shipment_data"]),
    senderInfo: ErInfo.fromJson(json["sender_info"]),
    receiverInfo: ErInfo.fromJson(json["receiver_info"]),
    dimension: List<Dimension>.from(json["dimension"].map((x) => Dimension.fromJson(x))),
    travelHistory: List<TravelHistory>.from(json["travel_history"].map((x) => TravelHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "shipment_data": shipmentData.toJson(),
    "sender_info": senderInfo.toJson(),
    "receiver_info": receiverInfo.toJson(),
    "dimension": List<dynamic>.from(dimension.map((x) => x.toJson())),
    "travel_history": List<dynamic>.from(travelHistory.map((x) => x.toJson())),
  };
}

class Dimension {
  final String sku;
  final AdminCommission cod;
  final String pieces;
  final String weight;
  final String description;

  Dimension({
    required this.sku,
    required this.cod,
    required this.pieces,
    required this.weight,
    required this.description,
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
    "cod": adminCommissionValues.reverse[cod],
    "pieces": pieces,
    "weight": weight,
    "description": description,
  };
}

class ErInfo {
  final String name;
  final String mobile;
  final String address;

  ErInfo({
    required this.name,
    required this.mobile,
    required this.address,
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
  final String awbNo;
  final DateTime entryDate;
  final String paymentMethod;
  final String weight;
  final String status;
  final String productType;
  final String code;
  final dynamic shippingCompany;
  final String shippingTrackingNo;
  final String shippingTrackingUrl;
  final String origin;
  final dynamic destination;

  ShipmentData({
    required this.awbNo,
    required this.entryDate,
    required this.paymentMethod,
    required this.weight,
    required this.status,
    required this.productType,
    required this.code,
    required this.shippingCompany,
    required this.shippingTrackingNo,
    required this.shippingTrackingUrl,
    required this.origin,
    required this.destination,
  });

  factory ShipmentData.fromJson(Map<String, dynamic> json) => ShipmentData(
    awbNo: json["awb_no"],
    entryDate: DateTime.parse(json["entry_date"]),
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
    "entry_date": entryDate.toIso8601String(),
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
  final String newLocation;
  final String newStatus;
  final String activites;
  final String code;
  final String comment;
  final DateTime entryDate;

  TravelHistory({
    required this.newLocation,
    required this.newStatus,
    required this.activites,
    required this.code,
    required this.comment,
    required this.entryDate,
  });

  factory TravelHistory.fromJson(Map<String, dynamic> json) => TravelHistory(
    newLocation: json["new_location"],
    newStatus: json["new_status"],
    activites: json["Activites"],
    code: json["code"],
    comment: json["comment"],
    entryDate: DateTime.parse(json["entry_date"]),
  );

  Map<String, dynamic> toJson() => {
    "new_location": newLocation,
    "new_status": newStatus,
    "Activites": activites,
    "code": code,
    "comment": comment,
    "entry_date": entryDate.toIso8601String(),
  };
}

enum ShippingType {
  ORDER_WISE
}

final shippingTypeValues = EnumValues({
  "order_wise": ShippingType.ORDER_WISE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
