// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import '../../../support/domain/models/support_reply_model.dart';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  final int totalSize;
  final String limit;
  final String offset;
  final List<Message> message;

  MessageModel({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.message,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    totalSize: json["total_size"],
    limit: json["limit"],
    offset: json["offset"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_size": totalSize,
    "limit": limit,
    "offset": offset,
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
  };
}

class Message {
  final int id;
  final int userId;
  final int sellerId;
  final dynamic adminId;
  final dynamic deliveryManId;
  final String message;
  final List<Attachment> attachment;
  final int sentByCustomer;
  final int sentBySeller;
  final dynamic sentByAdmin;
  final dynamic sentByDeliveryMan;
  final int seenByCustomer;
  final int seenBySeller;
  final dynamic seenByAdmin;
  final dynamic seenByDeliveryMan;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int shopId;
  final SellerInfo ? sellerInfo;
  final bool? ofline;

  Message( {
    required this.id,
    required this.userId,
    required this.sellerId,
    required this.adminId,
    required this.deliveryManId,
    required this.message,
    required this.attachment,
    required this.sentByCustomer,
    required this.sentBySeller,
    required this.sentByAdmin,
    required this.sentByDeliveryMan,
    required this.seenByCustomer,
    required this.seenBySeller,
    required this.seenByAdmin,
    required this.seenByDeliveryMan,
    required this.status,
    required this.createdAt,
    this.ofline,
    required this.updatedAt,
    required this.shopId,
    required this.sellerInfo,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    userId: json["user_id"],
    sellerId: json["seller_id"],
    adminId: json["admin_id"],
    deliveryManId: json["delivery_man_id"],
    message: json["message"],
    attachment:json["attachment"]!=null? List<Attachment>.from(json["attachment"].map((x) => Attachment.fromJson(x))):[],
    sentByCustomer: json["sent_by_customer"],
    sentBySeller: json["sent_by_seller"],
    sentByAdmin: json["sent_by_admin"],
    sentByDeliveryMan: json["sent_by_delivery_man"],
    seenByCustomer: json["seen_by_customer"],
    seenBySeller: json["seen_by_seller"],
    seenByAdmin: json["seen_by_admin"],
    seenByDeliveryMan: json["seen_by_delivery_man"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    shopId: json["shop_id"],
    sellerInfo: SellerInfo.fromJson(json["seller_info"]),
    ofline: false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "seller_id": sellerId,
    "admin_id": adminId,
    "delivery_man_id": deliveryManId,
    "message": message,
    "attachment": List<dynamic>.from(attachment.map((x) => x)),
    "sent_by_customer": sentByCustomer,
    "sent_by_seller": sentBySeller,
    "sent_by_admin": sentByAdmin,
    "sent_by_delivery_man": sentByDeliveryMan,
    "seen_by_customer": seenByCustomer,
    "seen_by_seller": seenBySeller,
    "seen_by_admin": seenByAdmin,
    "seen_by_delivery_man": seenByDeliveryMan,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "shop_id": shopId,
    "seller_info": sellerInfo!.toJson(),
  };
}

class SellerInfo {
  final int id;
  final dynamic fName;
  final dynamic lName;
  final String phone;
  final String image;
  final String email;
  final String password;
  final String status;
  final String rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String bankName;
  final String branch;
  final String accountNo;
  final String holderName;
  final String authToken;
  final int salesCommissionPercentage;
  final String gst;
  final String cmFirebaseToken;
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
  // final List<FavMenu> favMenu;
  final int managerId;
  final String iban;
  final dynamic storeAddress;
  final String siteUrl;
  final String zip;
  final String activity;
  final List<String> moduleAccess;
  final List<String> inputAccess;
  final String appLanguage;
  final int accountManagerSupervisorId;
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
  final String buildingNo;
  final dynamic subNo;
  final dynamic unitNo;
  final String neighborhood;
  final String street;
  final String titleExplanation;
  final int commissionTaxRate;
  final int powerOfAttorney;
  final dynamic commissionType;
  final List<Shop> shops;

  SellerInfo({
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
    // required this.favMenu,
    required this.managerId,
    required this.iban,
    required this.storeAddress,
    required this.siteUrl,
    required this.zip,
    required this.activity,
    required this.moduleAccess,
    required this.inputAccess,
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
    required this.shops,
  });

  factory SellerInfo.fromJson(Map<String, dynamic> json) => SellerInfo(
    id: json["id"],
    fName: json["f_name"],
    lName: json["l_name"],
    phone: json["phone"],
    image: json["image"],
    email: json["email"],
    password: json["password"],
    status: json["status"],
    rememberToken: json["remember_token"]??'',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bankName: json["bank_name"],
    branch: json["branch"],
    accountNo: json["account_no"],
    holderName: json["holder_name"],
    authToken: json["auth_token"]??'',
    salesCommissionPercentage: json["sales_commission_percentage"]??0,
    gst: json["gst"],
    cmFirebaseToken: json["cm_firebase_token"]??'',
    posStatus: json["pos_status"]??0,
    minimumOrderAmount: json["minimum_order_amount"],
    freeDeliveryStatus: json["free_delivery_status"],
    freeDeliveryOverAmount: json["free_delivery_over_amount"],
    companyName: json["company_name"],
    licenseOwnerName: json["license_owner_name"],
    licenseOwnerPhone: json["license_owner_phone"],
    delegateName: json["delegate_name"],
    delegatePhone: json["delegate_phone"],
    commercialRegistrationNo: json["commercial_registration_no"],
    commercialRegistrationImg: json["commercial_registration_img"],
    taxNo: json["tax_no"],
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
    // favMenu: List<FavMenu>.from(json["fav_menu"].map((x) => FavMenu.fromJson(x))),
    managerId: json["manager_id"],
    iban: json["iban"],
    storeAddress: json["store_address"],
    siteUrl: json["site_url"]??'',
    zip: json["zip"],
    activity: json["activity"]??'',
    moduleAccess: List<String>.from(json["module_access"].map((x) => x)),
    inputAccess: List<String>.from(json["input_access"].map((x) => x)),
    appLanguage: json["app_language"]??'',
    accountManagerSupervisorId: json["account_manager_supervisor_id"],
    identityType: json["identity_type"]??'',
    idNumber: json["id_number"]??'',
    releaseDateIdNumber: DateTime.parse(json["release_date_id_number"]),
    expiryDateIdNumber: DateTime.parse(json["expiry_date_id_number"]),
    idPhoto: json["id_photo"]??'',
    nationality: json["nationality"]??'',
    employer: json["employer"]??'',
    occupation: json["occupation"]??'',
    gender: json["gender"]??'',
    releaseDateCommercialRegister: DateTime.parse(json["release_date_commercial_register"]),
    expiryDateCommercialRegister: DateTime.parse(json["expiry_date_commercial_register"]),
    releaseDateTaxNo: DateTime.parse(json["release_date_tax_no"]),
    expiryDateTaxNo: DateTime.parse(json["expiry_date_tax_no"]),
    shortTitleCode: json["short_title_code"],
    buildingNo: json["building_no"]??'',
    subNo: json["sub_no"],
    unitNo: json["unit_no"],
    neighborhood: json["neighborhood"]??'',
    street: json["street"]??'',
    titleExplanation: json["title_explanation"]??'',
    commissionTaxRate: json["commission_tax_rate"]??0,
    powerOfAttorney: json["power_of_attorney"]??0,
    commissionType: json["commission_type"]??'',
    shops: List<Shop>.from(json["shops"].map((x) => Shop.fromJson(x))),
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
    // "fav_menu": List<dynamic>.from(favMenu.map((x) => x.toJson())),
    "manager_id": managerId,
    "iban": iban,
    "store_address": storeAddress,
    "site_url": siteUrl,
    "zip": zip,
    "activity": activity,
    "module_access": List<dynamic>.from(moduleAccess.map((x) => x)),
    "input_access": List<dynamic>.from(inputAccess.map((x) => x)),
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
    "shops": List<dynamic>.from(shops.map((x) => x.toJson())),
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
  final Seller seller;

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
    seller: Seller.fromJson(json["seller"]),
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
