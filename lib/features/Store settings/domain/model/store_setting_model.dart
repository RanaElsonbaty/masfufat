// To parse this JSON data, do
//
//     final storeSettingModel = storeSettingModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/models/sync_order_details.dart';

List<StoreSettingModel> storeSettingModelFromJson(String str) => List<StoreSettingModel>.from(json.decode(str).map((x) => StoreSettingModel.fromJson(x)));

String storeSettingModelToJson(List<StoreSettingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreSettingModel {
  final String? token;
  final String appName;
  final String logo;
  final StoreDetails ?storeDetails;

  StoreSettingModel({
    required this.token,
    required this.appName,
    required this.logo,
    required this.storeDetails,
  });

  factory StoreSettingModel.fromJson(Map<String, dynamic> json) => StoreSettingModel(
    token: json["api_key"],
    appName: json["app_name"],
    logo: json["logo"],
    storeDetails:json["store_details"]!=null&&json["store_details"]!= []&&json["store_details"].toString()!='[]'
                ? StoreDetails.fromJson(json["store_details"]):null,
  );

  Map<String, dynamic> toJson() => {
    "api_key": token,
    "app_name": appName,
    "logo": logo,
    "store_details": storeDetails!.toJson(),
  };
}

class StoreDetails {
  final int? id;
  final String? name;
  final String? entity;
  final String? type;
  final String? email;
  final String? avatar;
  final String? plan;
  final String status;
  final bool? verified;
  final String? currency;
  final String? domain;
  final String? description;
  final Licenses? licenses;
  final Social? social;
  final User? user;
  final Message? message;

  StoreDetails({
    this.id,
    this.name,
    this.entity,
    this.type,
    this.email,
    this.avatar,
    this.plan,
    required this.status,
    this.verified,
    this.currency,
    this.domain,
    this.description,
    this.licenses,
    this.social,
    this.user,
    this.message,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
    id: json["id"],
    name: json["name"],
    entity: json["entity"],
    type: json["type"],
    email: json["email"],
    avatar: json["avatar"],
    plan: json["plan"],
    status: json["status"],
    verified: json["verified"],
    currency: json["currency"],
    domain: json["domain"],
    description: json["description"],
    licenses: json["licenses"] == null ? null : Licenses.fromJson(json["licenses"]),
    social: json["social"] == null ? null : Social.fromJson(json["social"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "entity": entity,
    "type": type,
    "email": email,
    "avatar": avatar,
    "plan": plan,
    "status": status,
    "verified": verified,
    "currency": currency,
    "domain": domain,
    "description": description,
    "licenses": licenses?.toJson(),
    "social": social?.toJson(),
    "user": user?.toJson(),
    "message": message?.toJson(),
  };
}

class Licenses {
  final dynamic taxNumber;
  final dynamic commercialNumber;
  final dynamic freelanceNumber;

  Licenses({
    required this.taxNumber,
    required this.commercialNumber,
    required this.freelanceNumber,
  });

  factory Licenses.fromJson(Map<String, dynamic> json) => Licenses(
    taxNumber: json["tax_number"],
    commercialNumber: json["commercial_number"],
    freelanceNumber: json["freelance_number"],
  );

  Map<String, dynamic> toJson() => {
    "tax_number": taxNumber,
    "commercial_number": commercialNumber,
    "freelance_number": freelanceNumber,
  };
}

class Message {
  final String type;
  final dynamic code;
  final dynamic name;
  final dynamic description;

  Message({
    required this.type,
    required this.code,
    required this.name,
    required this.description,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    type: json["type"],
    code: json["code"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "code": code,
    "name": name,
    "description": description,
  };
}

class Social {
  final String telegram;
  final String instagram;
  final dynamic tiktok;
  final String twitter;
  final String facebook;
  final dynamic maroof;
  final String youtube;
  final String snapchat;
  final String whatsapp;
  final String appstoreLink;
  final String googleplayLink;

  Social({
    required this.telegram,
    required this.instagram,
    required this.tiktok,
    required this.twitter,
    required this.facebook,
    required this.maroof,
    required this.youtube,
    required this.snapchat,
    required this.whatsapp,
    required this.appstoreLink,
    required this.googleplayLink,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    telegram: json["telegram"],
    instagram: json["instagram"],
    tiktok: json["tiktok"],
    twitter: json["twitter"],
    facebook: json["facebook"],
    maroof: json["maroof"],
    youtube: json["youtube"],
    snapchat: json["snapchat"],
    whatsapp: json["whatsapp"],
    appstoreLink: json["appstore_link"],
    googleplayLink: json["googleplay_link"],
  );

  Map<String, dynamic> toJson() => {
    "telegram": telegram,
    "instagram": instagram,
    "tiktok": tiktok,
    "twitter": twitter,
    "facebook": facebook,
    "maroof": maroof,
    "youtube": youtube,
    "snapchat": snapchat,
    "whatsapp": whatsapp,
    "appstore_link": appstoreLink,
    "googleplay_link": googleplayLink,
  };
}

class User {
  final int id;
  final int oldId;
  final String uuid;
  final String name;
  final String username;
  final String email;
  final dynamic emailPendingConfirmation;
  final bool isEmailVerified;
  final String mobile;
  final dynamic mobilePendingConfirmation;
  final MobileObject mobileObject;
  final String gender;
  final String intercomUserHash;
  final dynamic vloopsRefCode;
  final List<Role> roles;
  final List<Permission> permissions;
  final Store store;
  final bool hasEmailInStoreDomain;
  final DateTime createdAt;
  final String tapPublicKey;
  final bool isSetupCompleted;
  final DateTime requirePasswordChangeAfter;

  User({
    required this.id,
    required this.oldId,
    required this.uuid,
    required this.name,
    required this.username,
    required this.email,
    required this.emailPendingConfirmation,
    required this.isEmailVerified,
    required this.mobile,
    required this.mobilePendingConfirmation,
    required this.mobileObject,
    required this.gender,
    required this.intercomUserHash,
    required this.vloopsRefCode,
    required this.roles,
    required this.permissions,
    required this.store,
    required this.hasEmailInStoreDomain,
    required this.createdAt,
    required this.tapPublicKey,
    required this.isSetupCompleted,
    required this.requirePasswordChangeAfter,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    oldId: json["old_id"],
    uuid: json["uuid"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    emailPendingConfirmation: json["email_pending_confirmation"],
    isEmailVerified: json["is_email_verified"],
    mobile: json["mobile"],
    mobilePendingConfirmation: json["mobile_pending_confirmation"],
    mobileObject: MobileObject.fromJson(json["mobile_object"]),
    gender: json["gender"]??'',
    intercomUserHash: json["intercom_user_hash"],
    vloopsRefCode: json["vloops_ref_code"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    permissions: List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
    store: Store.fromJson(json["store"]),
    hasEmailInStoreDomain: json["has_email_in_store_domain"],
    createdAt: DateTime.parse(json["created_at"]),
    tapPublicKey: json["tap_public_key"],
    isSetupCompleted: json["is_setup_completed"],
    requirePasswordChangeAfter: DateTime.parse(json["require_password_change_after"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "old_id": oldId,
    "uuid": uuid,
    "name": name,
    "username": username,
    "email": email,
    "email_pending_confirmation": emailPendingConfirmation,
    "is_email_verified": isEmailVerified,
    "mobile": mobile,
    "mobile_pending_confirmation": mobilePendingConfirmation,
    "mobile_object": mobileObject.toJson(),
    "gender": gender,
    "intercom_user_hash": intercomUserHash,
    "vloops_ref_code": vloopsRefCode,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
    "store": store.toJson(),
    "has_email_in_store_domain": hasEmailInStoreDomain,
    "created_at": createdAt.toIso8601String(),
    "tap_public_key": tapPublicKey,
    "is_setup_completed": isSetupCompleted,
    "require_password_change_after": requirePasswordChangeAfter.toIso8601String(),
  };
}

class BusinessLocation {
  final Country country;
  final City city;
  final dynamic district;
  final String street;
  final String buildingNo;
  final String postalCode;
  final dynamic additionalPostalCode;
  final String lat;
  final String lng;
  final bool showLocation;
  final String nationalAddressCertificate;
  final bool isAddressConfirmed;

  BusinessLocation({
    required this.country,
    required this.city,
    required this.district,
    required this.street,
    required this.buildingNo,
    required this.postalCode,
    required this.additionalPostalCode,
    required this.lat,
    required this.lng,
    required this.showLocation,
    required this.nationalAddressCertificate,
    required this.isAddressConfirmed,
  });

  factory BusinessLocation.fromJson(Map<String, dynamic> json) => BusinessLocation(
    country: Country.fromJson(json["country"]),
    city: City.fromJson(json["city"]),
    district: json["district"],
    street: json["street"],
    buildingNo: json["building_no"],
    postalCode: json["postal_code"],
    additionalPostalCode: json["additional_postal_code"],
    lat: json["lat"],
    lng: json["lng"],
    showLocation: json["show_location"],
    nationalAddressCertificate: json["national_address_certificate"],
    isAddressConfirmed: json["is_address_confirmed"],
  );

  Map<String, dynamic> toJson() => {
    "country": country.toJson(),
    "city": city.toJson(),
    "district": district,
    "street": street,
    "building_no": buildingNo,
    "postal_code": postalCode,
    "additional_postal_code": additionalPostalCode,
    "lat": lat,
    "lng": lng,
    "show_location": showLocation,
    "national_address_certificate": nationalAddressCertificate,
    "is_address_confirmed": isAddressConfirmed,
  };
}

class City {
  final int id;
  final int nationalId;
  final String name;
  final int priority;
  final int countryId;
  final String countryName;
  final String countryCode;
  final String arName;
  final String enName;

  City({
    required this.id,
    required this.nationalId,
    required this.name,
    required this.priority,
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    required this.arName,
    required this.enName,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    nationalId: json["national_id"],
    name: json["name"],
    priority: json["priority"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    countryCode: json["country_code"],
    arName: json["ar_name"],
    enName: json["en_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "national_id": nationalId,
    "name": name,
    "priority": priority,
    "country_id": countryId,
    "country_name": countryName,
    "country_code": countryCode,
    "ar_name": arName,
    "en_name": enName,
  };
}

class Country {
  final int id;
  final String name;
  final String code;
  final String countryCode;
  final String flag;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.countryCode,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    countryCode: json["country_code"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "country_code": countryCode,
    "flag": flag,
  };
}

class MobileObject {
  final String countryCode;
  final String mobile;

  MobileObject({
    required this.countryCode,
    required this.mobile,
  });

  factory MobileObject.fromJson(Map<String, dynamic> json) => MobileObject(
    countryCode: json["country_code"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "mobile": mobile,
  };
}

class Permission {
  final String id;
  final String slug;
  final String name;
  final String description;
  final int order;

  Permission({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.order,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    description: json["description"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "description": description,
    "order": order,
  };
}

class Role {
  final String id;
  final String slug;
  final String name;

  Role({
    required this.id,
    required this.slug,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
  };
}

class Store {
  final int id;
  final String uuid;
  final String username;
  final String title;
  final String phone;
  final dynamic commercialRegistrationNumber;
  final dynamic commercialRegistrationNumberActivation;
  final String email;
  final String url;
  final String ssl;
  final String sitemapUrl;
  final Currency currency;
  final List<Currency> currencies;
  final Language language;
  final List<Language> languages;
  // final Theme theme;
  final dynamic logo;
  final List<dynamic> logos;
  final dynamic cover;
  final dynamic icon;
  final bool maintenanceMode;
  final bool hasNewProductsService;
  final dynamic facebook;
  final dynamic twitter;
  final dynamic instagram;
  final dynamic snapchat;
  final dynamic tiktok;
  final dynamic businessCenter;
  final dynamic maroof;
  final dynamic website;
  final List<dynamic> oneSignalKeys;
  final int smsCampaignsBalance;
  final dynamic acquisitionProgram;
  final dynamic registrationDiscountCode;
  final dynamic categoryOther;
  final bool showStoreSelectedCategoryNotification;
  final List<dynamic> malls;
  final bool isCustomersEmailMandatory;
  final bool customersLoginByEmailStatus;
  final bool customersLoginByWhatsappStatus;
  final bool isGmapsAndSplInAddressEnabled;
  final bool isGmapsInAddressEnabled;
  final bool isGmapsInAddressMandatory;
  final bool isSplInAddressEnabled;
  final bool isRestockCancelledOrdersEnabled;
  final bool isLowStockLabelEnabled;
  final bool isProductReviewsEnabled;
  final bool isMetafieldsEnabled;
  final int lowStockQuantityLimit;
  final bool isDifferentConsigneeAllowed;
  final bool is2FaEnabled;
  final dynamic metaDescription;
  final dynamic metaTitle;
  final dynamic metaDescriptionEn;
  final dynamic metaTitleEn;
  final List<dynamic> privacyPolicy;
  final List<dynamic> termsConditions;
  final List<dynamic> complaintsAndSuggestions;
  final List<dynamic> license;
  final List<dynamic> refundExchangePolicy;
  final bool isVatRequiredInSubscription;
  final bool isSellingBlocked;
  final bool isMobileVerified;
  final bool isUserVerified;
  final bool isReadinessCompleted;
  final bool allowEmailVerification;
  final bool isUserEmailComplianceCheckEnabled;
  final String analyticsDashboardToken;
  final bool isZidpayActivated;
  final bool isZidshipActivated;
  final bool isApplePayEnabledInAllBrowsers;
  final bool isBuyAsAGuestEnabled;
  final bool isGuestBankTransferSupported;
  final bool isGuestCodSupported;
  final List<String> systemTags;
  final bool hasNewShippingModule;
  final bool hasMultiProductInventory;
  final bool hasPos;
  final bool isPosReady;
  final bool hasB2BSubscription;
  final dynamic hasNewThemesOnly;
  final bool isSinglePageCheckoutEnabled;
  final bool showPickupOptionStockAvailabilityForCheckout;
  final bool isMerchantGrowthEnabled;
  final bool isQitafEnabled;
  final List<dynamic> pinnedApps;
  final bool hasActiveFulfillmentApp;
  final List<dynamic> subscriptionPaymentMethods;
  final bool hasWalletPayments;
  final dynamic registrationSource;
  final dynamic merchantRelations;
  final Aspects aspects;
  final bool isExportRestrictedForUsersOutsideStoreDomain;

  Store({
    required this.id,
    required this.uuid,
    required this.username,
    required this.title,
    required this.phone,
    required this.commercialRegistrationNumber,
    required this.commercialRegistrationNumberActivation,
    required this.email,
    required this.url,
    required this.ssl,
    required this.sitemapUrl,
    required this.currency,
    required this.currencies,
    required this.language,
    required this.languages,
    // required this.theme,
    required this.logo,
    required this.logos,
    required this.cover,
    required this.icon,
    required this.maintenanceMode,
    required this.hasNewProductsService,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.snapchat,
    required this.tiktok,
    required this.businessCenter,
    required this.maroof,
    required this.website,
    required this.oneSignalKeys,
    required this.smsCampaignsBalance,
    required this.acquisitionProgram,
    required this.registrationDiscountCode,
    required this.categoryOther,
    required this.showStoreSelectedCategoryNotification,
    required this.malls,
    required this.isCustomersEmailMandatory,
    required this.customersLoginByEmailStatus,
    required this.customersLoginByWhatsappStatus,
    required this.isGmapsAndSplInAddressEnabled,
    required this.isGmapsInAddressEnabled,
    required this.isGmapsInAddressMandatory,
    required this.isSplInAddressEnabled,
    required this.isRestockCancelledOrdersEnabled,
    required this.isLowStockLabelEnabled,
    required this.isProductReviewsEnabled,
    required this.isMetafieldsEnabled,
    required this.lowStockQuantityLimit,
    required this.isDifferentConsigneeAllowed,
    required this.is2FaEnabled,
    required this.metaDescription,
    required this.metaTitle,
    required this.metaDescriptionEn,
    required this.metaTitleEn,
    required this.privacyPolicy,
    required this.termsConditions,
    required this.complaintsAndSuggestions,
    required this.license,
    required this.refundExchangePolicy,
    required this.isVatRequiredInSubscription,
    required this.isSellingBlocked,
    required this.isMobileVerified,
    required this.isUserVerified,
    required this.isReadinessCompleted,
    required this.allowEmailVerification,
    required this.isUserEmailComplianceCheckEnabled,
    required this.analyticsDashboardToken,
    required this.isZidpayActivated,
    required this.isZidshipActivated,
    required this.isApplePayEnabledInAllBrowsers,
    required this.isBuyAsAGuestEnabled,
    required this.isGuestBankTransferSupported,
    required this.isGuestCodSupported,
    required this.systemTags,
    required this.hasNewShippingModule,
    required this.hasMultiProductInventory,
    required this.hasPos,
    required this.isPosReady,
    required this.hasB2BSubscription,
    required this.hasNewThemesOnly,
    required this.isSinglePageCheckoutEnabled,
    required this.showPickupOptionStockAvailabilityForCheckout,
    required this.isMerchantGrowthEnabled,
    required this.isQitafEnabled,
    required this.pinnedApps,
    required this.hasActiveFulfillmentApp,
    required this.subscriptionPaymentMethods,
    required this.hasWalletPayments,
    required this.registrationSource,
    required this.merchantRelations,
    required this.aspects,
    required this.isExportRestrictedForUsersOutsideStoreDomain,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    uuid: json["uuid"],
    username: json["username"],
    title: json["title"],
    phone: json["phone"],
    commercialRegistrationNumber: json["commercial_registration_number"],
    commercialRegistrationNumberActivation: json["commercial_registration_number_activation"],
    email: json["email"],
    url: json["url"],
    ssl: json["ssl"],
    sitemapUrl: json["sitemap_url"],
    currency: Currency.fromJson(json["currency"]),
    currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    language: Language.fromJson(json["language"]),
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    // theme: Theme.fromJson(json["theme"]),
    logo: json["logo"],
    logos: List<dynamic>.from(json["logos"].map((x) => x)),
    cover: json["cover"],
    icon: json["icon"],
    maintenanceMode: json["maintenance_mode"],
    hasNewProductsService: json["has_new_products_service"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    snapchat: json["snapchat"],
    tiktok: json["tiktok"],
    businessCenter: json["business_center"],
    maroof: json["maroof"],
    website: json["website"],
    oneSignalKeys: List<dynamic>.from(json["one_signal_keys"].map((x) => x)),
    smsCampaignsBalance: json["sms_campaigns_balance"],
    acquisitionProgram: json["acquisition_program"],
    registrationDiscountCode: json["registration_discount_code"],
    categoryOther: json["category_other"],
    showStoreSelectedCategoryNotification: json["show_store_selected_category_notification"],
    malls: List<dynamic>.from(json["malls"].map((x) => x)),
    isCustomersEmailMandatory: json["is_customers_email_mandatory"],
    customersLoginByEmailStatus: json["customers_login_by_email_status"],
    customersLoginByWhatsappStatus: json["customers_login_by_whatsapp_status"],
    isGmapsAndSplInAddressEnabled: json["is_gmaps_and_spl_in_address_enabled"],
    isGmapsInAddressEnabled: json["is_gmaps_in_address_enabled"],
    isGmapsInAddressMandatory: json["is_gmaps_in_address_mandatory"],
    isSplInAddressEnabled: json["is_spl_in_address_enabled"],
    isRestockCancelledOrdersEnabled: json["is_restock_cancelled_orders_enabled"],
    isLowStockLabelEnabled: json["is_low_stock_label_enabled"],
    isProductReviewsEnabled: json["is_product_reviews_enabled"],
    isMetafieldsEnabled: json["is_metafields_enabled"],
    lowStockQuantityLimit: json["low_stock_quantity_limit"],
    isDifferentConsigneeAllowed: json["is_different_consignee_allowed"],
    is2FaEnabled: json["is_2fa_enabled"],
    metaDescription: json["meta_description"],
    metaTitle: json["meta_title"],
    metaDescriptionEn: json["meta_description_en"],
    metaTitleEn: json["meta_title_en"],
    privacyPolicy: List<dynamic>.from(json["privacy_policy"].map((x) => x)),
    termsConditions: List<dynamic>.from(json["terms_conditions"].map((x) => x)),
    complaintsAndSuggestions: List<dynamic>.from(json["complaints_and_suggestions"].map((x) => x)),
    license: List<dynamic>.from(json["license"].map((x) => x)),
    refundExchangePolicy: List<dynamic>.from(json["refund_exchange_policy"].map((x) => x)),
    isVatRequiredInSubscription: json["is_vat_required_in_subscription"],
    isSellingBlocked: json["is_selling_blocked"],
    isMobileVerified: json["is_mobile_verified"],
    isUserVerified: json["is_user_verified"],
    isReadinessCompleted: json["is_readiness_completed"],
    allowEmailVerification: json["allow_email_verification"],
    isUserEmailComplianceCheckEnabled: json["is_user_email_compliance_check_enabled"],
    analyticsDashboardToken: json["analytics_dashboard_token"],
    isZidpayActivated: json["is_zidpay_activated"],
    isZidshipActivated: json["is_zidship_activated"],
    isApplePayEnabledInAllBrowsers: json["is_apple_pay_enabled_in_all_browsers"],
    isBuyAsAGuestEnabled: json["is_buy_as_a_guest_enabled"],
    isGuestBankTransferSupported: json["is_guest_bank_transfer_supported"],
    isGuestCodSupported: json["is_guest_cod_supported"],
    systemTags: List<String>.from(json["system_tags"].map((x) => x)),
    hasNewShippingModule: json["has_new_shipping_module"],
    hasMultiProductInventory: json["has_multi_product_inventory"],
    hasPos: json["has_pos"],
    isPosReady: json["is_pos_ready"],
    hasB2BSubscription: json["has_b2b_subscription"],
    hasNewThemesOnly: json["has_new_themes_only"],
    isSinglePageCheckoutEnabled: json["is_single_page_checkout_enabled"],
    showPickupOptionStockAvailabilityForCheckout: json["show_pickup_option_stock_availability_for_checkout"],
    isMerchantGrowthEnabled: json["is_merchant_growth_enabled"],
    isQitafEnabled: json["is_qitaf_enabled"],
    pinnedApps: List<dynamic>.from(json["pinned_apps"].map((x) => x)),
    hasActiveFulfillmentApp: json["has_active_fulfillment_app"],
    subscriptionPaymentMethods: List<dynamic>.from(json["subscription_payment_methods"].map((x) => x)),
    hasWalletPayments: json["has_wallet_payments"],
    registrationSource: json["registration_source"],
    merchantRelations: json["merchant_relations"],
    aspects: Aspects.fromJson(json["aspects"]),
    isExportRestrictedForUsersOutsideStoreDomain: json["is_export_restricted_for_users_outside_store_domain"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "username": username,
    "title": title,
    "phone": phone,
    "commercial_registration_number": commercialRegistrationNumber,
    "commercial_registration_number_activation": commercialRegistrationNumberActivation,
    "email": email,
    "url": url,
    "ssl": ssl,
    "sitemap_url": sitemapUrl,
    "currency": currency.toJson(),
    "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
    "language": language.toJson(),
    "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
    // "theme": theme.toJson(),
    "logo": logo,
    "logos": List<dynamic>.from(logos.map((x) => x)),
    "cover": cover,
    "icon": icon,
    "maintenance_mode": maintenanceMode,
    "has_new_products_service": hasNewProductsService,
    "facebook": facebook,
    "twitter": twitter,
    "instagram": instagram,
    "snapchat": snapchat,
    "tiktok": tiktok,
    "business_center": businessCenter,
    "maroof": maroof,
    "website": website,
    "one_signal_keys": List<dynamic>.from(oneSignalKeys.map((x) => x)),
    "sms_campaigns_balance": smsCampaignsBalance,
    "acquisition_program": acquisitionProgram,
    "registration_discount_code": registrationDiscountCode,
    "category_other": categoryOther,
    "show_store_selected_category_notification": showStoreSelectedCategoryNotification,
    "malls": List<dynamic>.from(malls.map((x) => x)),
    "is_customers_email_mandatory": isCustomersEmailMandatory,
    "customers_login_by_email_status": customersLoginByEmailStatus,
    "customers_login_by_whatsapp_status": customersLoginByWhatsappStatus,
    "is_gmaps_and_spl_in_address_enabled": isGmapsAndSplInAddressEnabled,
    "is_gmaps_in_address_enabled": isGmapsInAddressEnabled,
    "is_gmaps_in_address_mandatory": isGmapsInAddressMandatory,
    "is_spl_in_address_enabled": isSplInAddressEnabled,
    "is_restock_cancelled_orders_enabled": isRestockCancelledOrdersEnabled,
    "is_low_stock_label_enabled": isLowStockLabelEnabled,
    "is_product_reviews_enabled": isProductReviewsEnabled,
    "is_metafields_enabled": isMetafieldsEnabled,
    "low_stock_quantity_limit": lowStockQuantityLimit,
    "is_different_consignee_allowed": isDifferentConsigneeAllowed,
    "is_2fa_enabled": is2FaEnabled,
    "meta_description": metaDescription,
    "meta_title": metaTitle,
    "meta_description_en": metaDescriptionEn,
    "meta_title_en": metaTitleEn,
    "privacy_policy": List<dynamic>.from(privacyPolicy.map((x) => x)),
    "terms_conditions": List<dynamic>.from(termsConditions.map((x) => x)),
    "complaints_and_suggestions": List<dynamic>.from(complaintsAndSuggestions.map((x) => x)),
    "license": List<dynamic>.from(license.map((x) => x)),
    "refund_exchange_policy": List<dynamic>.from(refundExchangePolicy.map((x) => x)),
    "is_vat_required_in_subscription": isVatRequiredInSubscription,
    "is_selling_blocked": isSellingBlocked,
    "is_mobile_verified": isMobileVerified,
    "is_user_verified": isUserVerified,
    "is_readiness_completed": isReadinessCompleted,
    "allow_email_verification": allowEmailVerification,
    "is_user_email_compliance_check_enabled": isUserEmailComplianceCheckEnabled,
    "analytics_dashboard_token": analyticsDashboardToken,
    "is_zidpay_activated": isZidpayActivated,
    "is_zidship_activated": isZidshipActivated,
    "is_apple_pay_enabled_in_all_browsers": isApplePayEnabledInAllBrowsers,
    "is_buy_as_a_guest_enabled": isBuyAsAGuestEnabled,
    "is_guest_bank_transfer_supported": isGuestBankTransferSupported,
    "is_guest_cod_supported": isGuestCodSupported,
    "system_tags": List<dynamic>.from(systemTags.map((x) => x)),
    "has_new_shipping_module": hasNewShippingModule,
    "has_multi_product_inventory": hasMultiProductInventory,
    "has_pos": hasPos,
    "is_pos_ready": isPosReady,
    "has_b2b_subscription": hasB2BSubscription,
    "has_new_themes_only": hasNewThemesOnly,
    "is_single_page_checkout_enabled": isSinglePageCheckoutEnabled,
    "show_pickup_option_stock_availability_for_checkout": showPickupOptionStockAvailabilityForCheckout,
    "is_merchant_growth_enabled": isMerchantGrowthEnabled,
    "is_qitaf_enabled": isQitafEnabled,
    "pinned_apps": List<dynamic>.from(pinnedApps.map((x) => x)),
    "has_active_fulfillment_app": hasActiveFulfillmentApp,
    "subscription_payment_methods": List<dynamic>.from(subscriptionPaymentMethods.map((x) => x)),
    "has_wallet_payments": hasWalletPayments,
    "registration_source": registrationSource,
    "merchant_relations": merchantRelations,
    "aspects": aspects.toJson(),
    "is_export_restricted_for_users_outside_store_domain": isExportRestrictedForUsersOutsideStoreDomain,
  };
}

class Aspects {
  final bool isNewSubscriber;
  final bool isReactivated;

  Aspects({
    required this.isNewSubscriber,
    required this.isReactivated,
  });

  factory Aspects.fromJson(Map<String, dynamic> json) => Aspects(
    isNewSubscriber: json["is_new_subscriber"],
    isReactivated: json["is_reactivated"],
  );

  Map<String, dynamic> toJson() => {
    "is_new_subscriber": isNewSubscriber,
    "is_reactivated": isReactivated,
  };
}

class Availability {
  final bool isStoreClosed;
  final dynamic closingType;
  final dynamic closingTimeType;
  final bool closedNow;
  final dynamic activatingData;
  final dynamic closingData;
  final bool notifyCustomer;
  final dynamic isTimeCounterDisplayed;
  final dynamic isAvailableHoursVisible;
  final List<dynamic> title;
  final List<dynamic> message;
  final List<dynamic> times;

  Availability({
    required this.isStoreClosed,
    required this.closingType,
    required this.closingTimeType,
    required this.closedNow,
    required this.activatingData,
    required this.closingData,
    required this.notifyCustomer,
    required this.isTimeCounterDisplayed,
    required this.isAvailableHoursVisible,
    required this.title,
    required this.message,
    required this.times,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    isStoreClosed: json["is_store_closed"],
    closingType: json["closing_type"],
    closingTimeType: json["closing_time_type"],
    closedNow: json["closed_now"],
    activatingData: json["activating_data"],
    closingData: json["closing_data"],
    notifyCustomer: json["notify_customer"],
    isTimeCounterDisplayed: json["is_time_counter_displayed"],
    isAvailableHoursVisible: json["is_available_hours_visible"],
    title: List<dynamic>.from(json["title"].map((x) => x)),
    message: List<dynamic>.from(json["message"].map((x) => x)),
    times: List<dynamic>.from(json["times"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "is_store_closed": isStoreClosed,
    "closing_type": closingType,
    "closing_time_type": closingTimeType,
    "closed_now": closedNow,
    "activating_data": activatingData,
    "closing_data": closingData,
    "notify_customer": notifyCustomer,
    "is_time_counter_displayed": isTimeCounterDisplayed,
    "is_available_hours_visible": isAvailableHoursVisible,
    "title": List<dynamic>.from(title.map((x) => x)),
    "message": List<dynamic>.from(message.map((x) => x)),
    "times": List<dynamic>.from(times.map((x) => x)),
  };
}

class Category {
  final int id;
  final String arName;
  final String enName;
  final String slug;
  final int industryId;
  final int displayOrder;
  final String name;

  Category({
    required this.id,
    required this.arName,
    required this.enName,
    required this.slug,
    required this.industryId,
    required this.displayOrder,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    arName: json["ar_name"],
    enName: json["en_name"],
    slug: json["slug"],
    industryId: json["industry_id"],
    displayOrder: json["display_order"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ar_name": arName,
    "en_name": enName,
    "slug": slug,
    "industry_id": industryId,
    "display_order": displayOrder,
    "name": name,
  };
}

class Currency {
  final int id;
  final String name;
  final String code;
  final String symbol;
  final Country country;

  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.country,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "symbol": symbol,
    "country": country.toJson(),
  };
}

class Industry {
  final int id;
  final String name;
  final String slug;
  final int displayOrder;

  Industry({
    required this.id,
    required this.name,
    required this.slug,
    required this.displayOrder,
  });

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    displayOrder: json["display_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "display_order": displayOrder,
  };
}

class Language {
  final int id;
  final String name;
  final String code;

  Language({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}

class SmsCampaignsSenderName {
  final dynamic senderName;
  final String status;

  SmsCampaignsSenderName({
    required this.senderName,
    required this.status,
  });

  factory SmsCampaignsSenderName.fromJson(Map<String, dynamic> json) => SmsCampaignsSenderName(
    senderName: json["sender_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "sender_name": senderName,
    "status": status,
  };
}

class StoreBusinessData {
  final String businessType;
  final String commercialName;
  final int civilId;
  final int branchNo;
  final String civilIdImage;
  final String freelanceCertificate;

  StoreBusinessData({
    required this.businessType,
    required this.commercialName,
    required this.civilId,
    required this.branchNo,
    required this.civilIdImage,
    required this.freelanceCertificate,
  });

  factory StoreBusinessData.fromJson(Map<String, dynamic> json) => StoreBusinessData(
    businessType: json["business_type"],
    commercialName: json["commercial_name"],
    civilId: json["civil_id"],
    branchNo: json["branch_no"],
    civilIdImage: json["civil_id_image"],
    freelanceCertificate: json["freelance_certificate"],
  );

  Map<String, dynamic> toJson() => {
    "business_type": businessType,
    "commercial_name": commercialName,
    "civil_id": civilId,
    "branch_no": branchNo,
    "civil_id_image": civilIdImage,
    "freelance_certificate": freelanceCertificate,
  };
}

class StorefrontTheme {
  final String id;
  final String name;
  final String nameAr;
  final String code;
  final String filePath;
  final bool isPurchasable;
  final dynamic price;
  final dynamic salePrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublic;
  final DateTime approvedAt;
  final dynamic features;
  final List<FullPackageName> additionalFeatures;
  final Meta meta;
  final String userUuid;
  final Pivot pivot;
  final dynamic purchasable;

  StorefrontTheme({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.code,
    required this.filePath,
    required this.isPurchasable,
    required this.price,
    required this.salePrice,
    required this.createdAt,
    required this.updatedAt,
    required this.isPublic,
    required this.approvedAt,
    required this.features,
    required this.additionalFeatures,
    required this.meta,
    required this.userUuid,
    required this.pivot,
    required this.purchasable,
  });

  factory StorefrontTheme.fromJson(Map<String, dynamic> json) => StorefrontTheme(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    code: json["code"],
    filePath: json["file_path"],
    isPurchasable: json["is_purchasable"],
    price: json["price"],
    salePrice: json["sale_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isPublic: json["is_public"],
    approvedAt: DateTime.parse(json["approved_at"]),
    features: json["features"],
    additionalFeatures: List<FullPackageName>.from(json["additional_features"].map((x) => FullPackageName.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
    userUuid: json["user_uuid"],
    pivot: Pivot.fromJson(json["pivot"]),
    purchasable: json["purchasable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "code": code,
    "file_path": filePath,
    "is_purchasable": isPurchasable,
    "price": price,
    "sale_price": salePrice,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_public": isPublic,
    "approved_at": approvedAt.toIso8601String(),
    "features": features,
    "additional_features": List<dynamic>.from(additionalFeatures.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "user_uuid": userUuid,
    "pivot": pivot.toJson(),
    "purchasable": purchasable,
  };
}

class FullPackageName {
  final String ar;
  final String en;

  FullPackageName({
    required this.ar,
    required this.en,
  });

  factory FullPackageName.fromJson(Map<String, dynamic> json) => FullPackageName(
    ar: json["ar"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "ar": ar,
    "en": en,
  };
}

class Meta {
  final String name;
  final String image;
  final String features;
  final List<int> industries;
  final String description;
  final String featuresAr;
  final ActiveStores activeStores;
  final String developedBy;
  final String extraImages;
  final String previewLink;
  final String descriptionAr;
  final String publisherStoreId;
  final String publisherThemeId;
  final String defaultModulesStoreUuid;

  Meta({
    required this.name,
    required this.image,
    required this.features,
    required this.industries,
    required this.description,
    required this.featuresAr,
    required this.activeStores,
    required this.developedBy,
    required this.extraImages,
    required this.previewLink,
    required this.descriptionAr,
    required this.publisherStoreId,
    required this.publisherThemeId,
    required this.defaultModulesStoreUuid,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    name: json["name"],
    image: json["image"],
    features: json["features"],
    industries: List<int>.from(json["industries"].map((x) => x)),
    description: json["description"],
    featuresAr: json["features_ar"],
    activeStores: ActiveStores.fromJson(json["activeStores"]),
    developedBy: json["developed_by"],
    extraImages: json["extra_images"],
    previewLink: json["preview_link"],
    descriptionAr: json["description_ar"],
    publisherStoreId: json["publisher_store_id"],
    publisherThemeId: json["publisher_theme_id"],
    defaultModulesStoreUuid: json["default_modules_store_uuid"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "features": features,
    "industries": List<dynamic>.from(industries.map((x) => x)),
    "description": description,
    "features_ar": featuresAr,
    "activeStores": activeStores.toJson(),
    "developed_by": developedBy,
    "extra_images": extraImages,
    "preview_link": previewLink,
    "description_ar": descriptionAr,
    "publisher_store_id": publisherStoreId,
    "publisher_theme_id": publisherThemeId,
    "default_modules_store_uuid": defaultModulesStoreUuid,
  };
}

class ActiveStores {
  final int totalCount;
  final List<ShowcaseStore> showcaseStores;

  ActiveStores({
    required this.totalCount,
    required this.showcaseStores,
  });

  factory ActiveStores.fromJson(Map<String, dynamic> json) => ActiveStores(
    totalCount: json["total_count"],
    showcaseStores: List<ShowcaseStore>.from(json["showcase_stores"].map((x) => ShowcaseStore.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "showcase_stores": List<dynamic>.from(showcaseStores.map((x) => x.toJson())),
  };
}

class ShowcaseStore {
  final String storeUrl;
  final String storeLogo;

  ShowcaseStore({
    required this.storeUrl,
    required this.storeLogo,
  });

  factory ShowcaseStore.fromJson(Map<String, dynamic> json) => ShowcaseStore(
    storeUrl: json["store_url"],
    storeLogo: json["store_logo"],
  );

  Map<String, dynamic> toJson() => {
    "store_url": storeUrl,
    "store_logo": storeLogo,
  };
}

class Pivot {
  final String storeId;
  final String themeId;
  final String id;
  final int isPublished;
  final int isPublishable;
  final dynamic purchaseId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pivot({
    required this.storeId,
    required this.themeId,
    required this.id,
    required this.isPublished,
    required this.isPublishable,
    required this.purchaseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    storeId: json["store_id"],
    themeId: json["theme_id"],
    id: json["id"],
    isPublished: json["is_published"],
    isPublishable: json["is_publishable"],
    purchaseId: json["purchase_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "store_id": storeId,
    "theme_id": themeId,
    "id": id,
    "is_published": isPublished,
    "is_publishable": isPublishable,
    "purchase_id": purchaseId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Subscription {
  final String id;
  final String cycleId;
  final bool isWarning;
  final bool isSuspended;
  final bool isExpired;
  final bool isLifetime;
  final DateTime expiredAt;
  final DateTime subscribedAt;
  final DateTime suspensionStartDate;
  final int originalFractionalBalance;
  final dynamic message;
  final String packageCode;
  final String packageKey;
  final String packageVariant;
  final FullPackageName packageName;
  final FullPackageName fullPackageName;
  final Map<String, bool> policies;
  final Map<String, PoliciesV2> policiesV2;
  final AvailableVariants availableVariants;
  final String status;
  final bool isTrial;
  final bool recurring;
  final RemainingCycle remainingCycle;
  final List<String> deprecatedKeys;
  final String tmpSuspensionStatus;
  final int tier;
  final bool isUsingNewPackageSystem;
  final bool isEnterprise;
  final bool hasFirstPaidSubscription;

  Subscription({
    required this.id,
    required this.cycleId,
    required this.isWarning,
    required this.isSuspended,
    required this.isExpired,
    required this.isLifetime,
    required this.expiredAt,
    required this.subscribedAt,
    required this.suspensionStartDate,
    required this.originalFractionalBalance,
    required this.message,
    required this.packageCode,
    required this.packageKey,
    required this.packageVariant,
    required this.packageName,
    required this.fullPackageName,
    required this.policies,
    required this.policiesV2,
    required this.availableVariants,
    required this.status,
    required this.isTrial,
    required this.recurring,
    required this.remainingCycle,
    required this.deprecatedKeys,
    required this.tmpSuspensionStatus,
    required this.tier,
    required this.isUsingNewPackageSystem,
    required this.isEnterprise,
    required this.hasFirstPaidSubscription,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"],
    cycleId: json["cycle_id"],
    isWarning: json["is_warning"],
    isSuspended: json["is_suspended"],
    isExpired: json["is_expired"],
    isLifetime: json["is_lifetime"],
    expiredAt: DateTime.parse(json["expired_at"]),
    subscribedAt: DateTime.parse(json["subscribed_at"]),
    suspensionStartDate: DateTime.parse(json["suspension_start_date"]),
    originalFractionalBalance: json["original_fractional_balance"],
    message: json["message"],
    packageCode: json["package_code"],
    packageKey: json["package_key"],
    packageVariant: json["package_variant"],
    packageName: FullPackageName.fromJson(json["package_name"]),
    fullPackageName: FullPackageName.fromJson(json["full_package_name"]),
    policies: Map.from(json["policies"]).map((k, v) => MapEntry<String, bool>(k, v)),
    policiesV2: Map.from(json["policies_v2"]).map((k, v) => MapEntry<String, PoliciesV2>(k, PoliciesV2.fromJson(v))),
    availableVariants: AvailableVariants.fromJson(json["available_variants"]),
    status: json["status"],
    isTrial: json["is_trial"],
    recurring: json["recurring"],
    remainingCycle: RemainingCycle.fromJson(json["remaining_cycle"]),
    deprecatedKeys: List<String>.from(json["deprecated_keys"].map((x) => x)),
    tmpSuspensionStatus: json["tmp_suspension_status"],
    tier: json["tier"],
    isUsingNewPackageSystem: json["is_using_new_package_system"],
    isEnterprise: json["is_enterprise"],
    hasFirstPaidSubscription: json["has_first_paid_subscription"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cycle_id": cycleId,
    "is_warning": isWarning,
    "is_suspended": isSuspended,
    "is_expired": isExpired,
    "is_lifetime": isLifetime,
    "expired_at": expiredAt.toIso8601String(),
    "subscribed_at": subscribedAt.toIso8601String(),
    "suspension_start_date": suspensionStartDate.toIso8601String(),
    "original_fractional_balance": originalFractionalBalance,
    "message": message,
    "package_code": packageCode,
    "package_key": packageKey,
    "package_variant": packageVariant,
    "package_name": packageName.toJson(),
    "full_package_name": fullPackageName.toJson(),
    "policies": Map.from(policies).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "policies_v2": Map.from(policiesV2).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "available_variants": availableVariants.toJson(),
    "status": status,
    "is_trial": isTrial,
    "recurring": recurring,
    "remaining_cycle": remainingCycle.toJson(),
    "deprecated_keys": List<dynamic>.from(deprecatedKeys.map((x) => x)),
    "tmp_suspension_status": tmpSuspensionStatus,
    "tier": tier,
    "is_using_new_package_system": isUsingNewPackageSystem,
    "is_enterprise": isEnterprise,
    "has_first_paid_subscription": hasFirstPaidSubscription,
  };
}

class AvailableVariants {
  final Arweqah newProfessional;
  final Arweqah newGrowth;
  final Arweqah arweqah;
  final Arweqah zidLite;
  final Arweqah posLite;
  final Arweqah enterprise;

  AvailableVariants({
    required this.newProfessional,
    required this.newGrowth,
    required this.arweqah,
    required this.zidLite,
    required this.posLite,
    required this.enterprise,
  });

  factory AvailableVariants.fromJson(Map<String, dynamic> json) => AvailableVariants(
    newProfessional: Arweqah.fromJson(json["new_professional"]),
    newGrowth: Arweqah.fromJson(json["new_growth"]),
    arweqah: Arweqah.fromJson(json["arweqah"]),
    zidLite: Arweqah.fromJson(json["zid_lite"]),
    posLite: Arweqah.fromJson(json["pos_lite"]),
    enterprise: Arweqah.fromJson(json["enterprise"]),
  );

  Map<String, dynamic> toJson() => {
    "new_professional": newProfessional.toJson(),
    "new_growth": newGrowth.toJson(),
    "arweqah": arweqah.toJson(),
    "zid_lite": zidLite.toJson(),
    "pos_lite": posLite.toJson(),
    "enterprise": enterprise.toJson(),
  };
}

class Arweqah {
  final List<String> variants;
  final String defaultVariant;

  Arweqah({
    required this.variants,
    required this.defaultVariant,
  });

  factory Arweqah.fromJson(Map<String, dynamic> json) => Arweqah(
    variants: List<String>.from(json["variants"].map((x) => x)),
    defaultVariant: json["default_variant"],
  );

  Map<String, dynamic> toJson() => {
    "variants": List<dynamic>.from(variants.map((x) => x)),
    "default_variant": defaultVariant,
  };
}

class PoliciesV2 {
  final bool enabled;
  final Config? config;
  final AvailableIn? availableIn;

  PoliciesV2({
    required this.enabled,
    required this.config,
    required this.availableIn,
  });

  factory PoliciesV2.fromJson(Map<String, dynamic> json) => PoliciesV2(
    enabled: json["enabled"],
    config: json["config"] == null ? null : Config.fromJson(json["config"]),
    availableIn: json["available_in"] == null ? null : AvailableIn.fromJson(json["available_in"]),
  );

  Map<String, dynamic> toJson() => {
    "enabled": enabled,
    "config": config?.toJson(),
    "available_in": availableIn?.toJson(),
  };
}

class AvailableIn {
  final Ar ar;
  final En en;
  final PackageKey packageKey;

  AvailableIn({
    required this.ar,
    required this.en,
    required this.packageKey,
  });

  factory AvailableIn.fromJson(Map<String, dynamic> json) => AvailableIn(
    ar: arValues.map[json["ar"]]!,
    en: enValues.map[json["en"]]!,
    packageKey: packageKeyValues.map[json["package_key"]]!,
  );

  Map<String, dynamic> toJson() => {
    "ar": arValues.reverse[ar],
    "en": enValues.reverse[en],
    "package_key": packageKeyValues.reverse[packageKey],
  };
}

enum Ar {
  AR,
  EMPTY,
  PURPLE
}

final arValues = EnumValues({
  "الإحترافية": Ar.AR,
  "النمو": Ar.EMPTY,
  "زد لايت": Ar.PURPLE
});

enum En {
  GROWTH,
  PROFESSIONAL,
  ZID_LITE
}

final enValues = EnumValues({
  "Growth": En.GROWTH,
  "Professional": En.PROFESSIONAL,
  "Zid Lite": En.ZID_LITE
});

enum PackageKey {
  NEW_GROWTH,
  NEW_PROFESSIONAL,
  ZID_LITE
}

final packageKeyValues = EnumValues({
  "new_growth": PackageKey.NEW_GROWTH,
  "new_professional": PackageKey.NEW_PROFESSIONAL,
  "zid_lite": PackageKey.ZID_LITE
});

class Config {
  final bool? enableSpecialPrices;
  final String? implementation;
  final bool? withAdvancedAnalytics;
  final bool? ticketingSystem;
  final bool? chat;
  final bool? whatsapp;
  final bool? call;
  final bool? am;
  final int? groupLimit;
  final int? limit;
  final String? model;
  final List<String>? paymentMethods;
  final bool? onlyZidship;
  final List<String>? gateways;
  final bool? allowAll;
  final bool? allowSelected;
  final bool? allowBulkAction;
  final bool? zidshipOnly;
  final int? languageLimit;
  final bool? allowCustom;
  final bool? noTimeLimit;
  final int? responseTimeInHours;
  final int? notifiedStaffLimit;
  final int? packageId;

  Config({
    this.enableSpecialPrices,
    this.implementation,
    this.withAdvancedAnalytics,
    this.ticketingSystem,
    this.chat,
    this.whatsapp,
    this.call,
    this.am,
    this.groupLimit,
    this.limit,
    this.model,
    this.paymentMethods,
    this.onlyZidship,
    this.gateways,
    this.allowAll,
    this.allowSelected,
    this.allowBulkAction,
    this.zidshipOnly,
    this.languageLimit,
    this.allowCustom,
    this.noTimeLimit,
    this.responseTimeInHours,
    this.notifiedStaffLimit,
    this.packageId,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    enableSpecialPrices: json["enable_special_prices"],
    implementation: json["implementation"],
    withAdvancedAnalytics: json["with_advanced_analytics"],
    ticketingSystem: json["ticketing_system"],
    chat: json["chat"],
    whatsapp: json["whatsapp"],
    call: json["call"],
    am: json["am"],
    groupLimit: json["group_limit"],
    limit: json["limit"],
    model: json["model"],
    paymentMethods: json["payment_methods"] == null ? [] : List<String>.from(json["payment_methods"]!.map((x) => x)),
    onlyZidship: json["only_zidship"],
    gateways: json["gateways"] == null ? [] : List<String>.from(json["gateways"]!.map((x) => x)),
    allowAll: json["allow_all"],
    allowSelected: json["allow_selected"],
    allowBulkAction: json["allow_bulk_action"],
    zidshipOnly: json["zidship_only"],
    languageLimit: json["language_limit"],
    allowCustom: json["allow_custom"],
    noTimeLimit: json["no_time_limit"],
    responseTimeInHours: json["response_time_in_hours"],
    notifiedStaffLimit: json["notified_staff_limit"],
    packageId: json["package_id"],
  );

  Map<String, dynamic> toJson() => {
    "enable_special_prices": enableSpecialPrices,
    "implementation": implementation,
    "with_advanced_analytics": withAdvancedAnalytics,
    "ticketing_system": ticketingSystem,
    "chat": chat,
    "whatsapp": whatsapp,
    "call": call,
    "am": am,
    "group_limit": groupLimit,
    "limit": limit,
    "model": model,
    "payment_methods": paymentMethods == null ? [] : List<dynamic>.from(paymentMethods!.map((x) => x)),
    "only_zidship": onlyZidship,
    "gateways": gateways == null ? [] : List<dynamic>.from(gateways!.map((x) => x)),
    "allow_all": allowAll,
    "allow_selected": allowSelected,
    "allow_bulk_action": allowBulkAction,
    "zidship_only": zidshipOnly,
    "language_limit": languageLimit,
    "allow_custom": allowCustom,
    "no_time_limit": noTimeLimit,
    "response_time_in_hours": responseTimeInHours,
    "notified_staff_limit": notifiedStaffLimit,
    "package_id": packageId,
  };
}

class RemainingCycle {
  final int years;
  final int months;
  final int days;

  RemainingCycle({
    required this.years,
    required this.months,
    required this.days,
  });

  factory RemainingCycle.fromJson(Map<String, dynamic> json) => RemainingCycle(
    years: json["years"],
    months: json["months"],
    days: json["days"],
  );

  Map<String, dynamic> toJson() => {
    "years": years,
    "months": months,
    "days": days,
  };
}



class UserProfileData {
  final DateTime birthDate;
  final int countryId;
  final int cityId;
  final Country country;
  final bool isOrganizationEmployee;
  final dynamic workingOrganizationName;
  final dynamic jobTitle;

  UserProfileData({
    required this.birthDate,
    required this.countryId,
    required this.cityId,
    required this.country,
    required this.isOrganizationEmployee,
    required this.workingOrganizationName,
    required this.jobTitle,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
    birthDate:json["birth_date"]!=null? DateTime.tryParse(json["birth_date"])??DateTime.now():DateTime.now(),
    countryId: json["country_id"]??0,
    cityId: json["city_id"]??0,
    country: Country.fromJson(json["country"]),
    isOrganizationEmployee: json["is_organization_employee"],
    workingOrganizationName: json["working_organization_name"],
    jobTitle: json["job_title"],
  );

  Map<String, dynamic> toJson() => {
    "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "country_id": countryId,
    "city_id": cityId,
    "country": country.toJson(),
    "is_organization_employee": isOrganizationEmployee,
    "working_organization_name": workingOrganizationName,
    "job_title": jobTitle,
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
