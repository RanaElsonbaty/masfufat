// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  final String brandSetting;
  final String digitalProductSetting;
  final int systemDefaultCurrency;
  final bool digitalPayment;
  final bool cashOnDelivery;
  final bool showSellerRatings;
  final bool showSellerOrders;
  final bool chatWithSellerStatus;
  final bool chatWithDeliveryStatus;
  final bool sellersProductsCount;
  final String sellerRegistration;
  // final LinkedAccountsSallaClass? linkedAccountsSalla;

  final int companyPhone;
  final String companyEmail;
  final String companyAddress;
  final String companyLogo;
  final int deliveryCountryRestriction;
  final int deliveryZipCodeAreaRestriction;
  final BaseUrls baseUrls;
  final StaticUrls staticUrls;
  final AboutUs aboutUs;
  final PrivacyPolicy privacyPolicy;
  final List<Faq> faq;
  final AboutUs termsConditions;
  final List<CurrencyList> currencyList;
  final String currencySymbolPosition;
  final String businessMode;
  final bool maintenanceMode;
  final List<Language> language;
  // final List<Color> colors;
  final List<String> unit;
  final String shippingMethod;
  final bool emailVerification;
  final bool phoneVerification;
  final String countryCode;
  // final List<SocialLogin> socialLogin;
  final String currencyModel;
  final String forgotPasswordVerification;
  final Announcement announcement;
  final String pixelAnalytics;
  final String softwareVersion;
  final int decimalPointSettings;
  final String inhouseSelectedShippingType;
  final int billingInputByCustomer;
  final int minimumOrderLimit;
  final int walletStatus;
  final int loyaltyPointStatus;
  final int loyaltyPointExchangeRate;
  final int loyaltyPointMinimumPoint;
  final PaymentMethods paymentMethods;
  final List<SocialMedia> socialMedia;
  final int showSellersSection;

  ConfigModel({
    required this.brandSetting,
    required this.digitalProductSetting,
    required this.systemDefaultCurrency,
    required this.digitalPayment,
    required this.cashOnDelivery,
    required this.sellerRegistration,
    required this.chatWithDeliveryStatus,
    required this.sellersProductsCount,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyAddress,
    required this.companyLogo,
    required this.showSellerRatings,
    required this. showSellerOrders,
    required this. chatWithSellerStatus,
    required this.deliveryCountryRestriction,
    // required this.linkedAccountsSalla,
    required this.deliveryZipCodeAreaRestriction,
    required this.baseUrls,
    required this.staticUrls,
    required this.aboutUs,
    required this.privacyPolicy,
    required this.faq,
    required this.termsConditions,
    required this.currencyList,
    required this.currencySymbolPosition,
    required this.businessMode,
    required this.maintenanceMode,
    required this.language,
    // required this.colors,
    required this.unit,
    required this.shippingMethod,
    required this.emailVerification,
    required this.phoneVerification,
    required this.countryCode,
    // required this.socialLogin,
    required this.currencyModel,
    required this.forgotPasswordVerification,
    required this.announcement,
    required this.pixelAnalytics,
    required this.softwareVersion,
    required this.decimalPointSettings,
    required this.inhouseSelectedShippingType,
    required this.billingInputByCustomer,
    required this.minimumOrderLimit,
    required this.walletStatus,
    required this.loyaltyPointStatus,
    required this.loyaltyPointExchangeRate,
    required this.loyaltyPointMinimumPoint,
    required this.paymentMethods,
    required this.socialMedia,
    required this.showSellersSection,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    brandSetting: json["brand_setting"],
    digitalProductSetting: json["digital_product_setting"],
    systemDefaultCurrency: json["system_default_currency"],
    chatWithSellerStatus: json['chat_with_seller_status']=='1'?true:false,
    chatWithDeliveryStatus: json['chat_with_delivery_status']=='1'?true:false,
    showSellerOrders: json['show_seller_orders']=='1'?true:false,
    showSellerRatings: json['show_seller_ratings']=='1'?true:false,
    sellersProductsCount:json['show_sellers_products_count']!=null&&json['show_sellers_products_count']==0?false:true,
    digitalPayment: json["digital_payment"],
    cashOnDelivery: json["cash_on_delivery"],
    sellerRegistration: json["seller_registration"],
    companyPhone: json["company_phone"],
    companyEmail: json["company_email"],
    companyAddress: json["company_address"],
    companyLogo: json["company_logo"],
    deliveryCountryRestriction: json["delivery_country_restriction"],
    deliveryZipCodeAreaRestriction: json["delivery_zip_code_area_restriction"],
    baseUrls: BaseUrls.fromJson(json["base_urls"]),
    staticUrls: StaticUrls.fromJson(json["static_urls"]),
    aboutUs: AboutUs.fromJson(json["about_us"]),
    privacyPolicy: PrivacyPolicy.fromJson(json["privacy_policy"]),
    faq: List<Faq>.from(json["faq"].map((x) => Faq.fromJson(x))),
    termsConditions: AboutUs.fromJson(json["terms_&_conditions"]),
    currencyList: List<CurrencyList>.from( json["currency_list"].map((x) => CurrencyList.fromJson(x))),
    currencySymbolPosition: json["currency_symbol_position"],
    businessMode: json["business_mode"],
    maintenanceMode: json["maintenance_mode"],
    language: List<Language>.from(json["language"].map((x) => Language.fromJson(x))),
    // colors: List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
    unit: List<String>.from(json["unit"].map((x) => x)),
    shippingMethod: json["shipping_method"],
    emailVerification: json["email_verification"],
    phoneVerification: json["phone_verification"],
    countryCode: json["country_code"],
    // socialLogin: List<SocialLogin>.from(json["social_login"].map((x) => SocialLogin.fromJson(x))),
    currencyModel: json["currency_model"],
    forgotPasswordVerification: json["forgot_password_verification"],
    announcement: Announcement.fromJson(json["announcement"]),
    pixelAnalytics: json["pixel_analytics"],
    softwareVersion: json["software_version"] ?? '',
    decimalPointSettings: json["decimal_point_settings"],
    inhouseSelectedShippingType: json["inhouse_selected_shipping_type"],
    billingInputByCustomer: json["billing_input_by_customer"],
    minimumOrderLimit: json["minimum_order_limit"],
    walletStatus: json["wallet_status"],
    loyaltyPointStatus: json["loyalty_point_status"],
    loyaltyPointExchangeRate: json["loyalty_point_exchange_rate"],
    loyaltyPointMinimumPoint: json["loyalty_point_minimum_point"],
    paymentMethods: PaymentMethods.fromJson(json["payment_methods"]),
    socialMedia: List<SocialMedia>.from(json["social_media"].map((x) => SocialMedia.fromJson(x))),
    showSellersSection: json["show_sellers_section"],
    // linkedAccountsSalla: json["linked_accounts_salla"]!=null?LinkedAccountsSallaClass.fromJson(json["linked_accounts_salla"]):null,
  );

  Map<String, dynamic> toJson() => {
    "brand_setting": brandSetting,
    "digital_product_setting": digitalProductSetting,
    "system_default_currency": systemDefaultCurrency,
    "digital_payment": digitalPayment,
    "cash_on_delivery": cashOnDelivery,
    "seller_registration": sellerRegistration,
    "company_phone": companyPhone,
    "company_email": companyEmail,
    "company_logo": companyLogo,
    "delivery_country_restriction": deliveryCountryRestriction,
    "delivery_zip_code_area_restriction": deliveryZipCodeAreaRestriction,
    "base_urls": baseUrls.toJson(),
    "static_urls": staticUrls.toJson(),
    "about_us": aboutUs.toJson(),
    "privacy_policy": privacyPolicy.toJson(),
    "faq": List<dynamic>.from(faq.map((x) => x.toJson())),
    "terms_&_conditions": termsConditions.toJson(),
    "currency_list": List<dynamic>.from(currencyList.map((x) => x.toJson())),
    "currency_symbol_position": currencySymbolPosition,
    "business_mode": businessMode,
    "maintenance_mode": maintenanceMode,
    "language": List<dynamic>.from(language.map((x) => x.toJson())),
    // "colors": List<dynamic>.from(colorss.map((x) => x.toJson())),
    "unit": List<dynamic>.from(unit.map((x) => x)),
    "shipping_method": shippingMethod,
    "email_verification": emailVerification,
    "phone_verification": phoneVerification,
    "country_code": countryCode,
    // "social_login": List<dynamic>.from(socialLogin.map((x) => x.toJson())),
    "currency_model": currencyModel,
    "forgot_password_verification": forgotPasswordVerification,
    "announcement": announcement.toJson(),
    "pixel_analytics": pixelAnalytics,
    "software_version": softwareVersion,
    "decimal_point_settings": decimalPointSettings,
    "inhouse_selected_shipping_type": inhouseSelectedShippingType,
    "billing_input_by_customer": billingInputByCustomer,
    "minimum_order_limit": minimumOrderLimit,
    "wallet_status": walletStatus,
    "loyalty_point_status": loyaltyPointStatus,
    "loyalty_point_exchange_rate": loyaltyPointExchangeRate,
    "loyalty_point_minimum_point": loyaltyPointMinimumPoint,
    "payment_methods": paymentMethods.toJson(),
    "social_media": List<dynamic>.from(socialMedia.map((x) => x.toJson())),
    "show_sellers_section": showSellersSection,
    // "linked_accounts_salla": linkedAccountsSalla,
  };
}

class AboutUs {
  final String sa;
  final String en;

  AboutUs({
    required this.sa,
    required this.en,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
    sa: json["sa"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "sa": sa,
    "en": en,
  };
}

class Announcement {
  final dynamic status;
  final String color;
  final String textColor;
  final String announcement;

  Announcement({
    required this.status,
    required this.color,
    required this.textColor,
    required this.announcement,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    status: json["status"],
    color: json["color"],
    textColor: json["text_color"],
    announcement: json["announcement"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "color": color,
    "text_color": textColor,
    "announcement": announcement,
  };
}

class BaseUrls {
  final String productImageUrl;
  final String productThumbnailUrl;
  final String digitalProductUrl;
  final String brandImageUrl;
  final String customerImageUrl;
  final String bannerImageUrl;
  final String categoryImageUrl;
  final String reviewImageUrl;
  final String sellerImageUrl;
  final String shopImageUrl;
  final String notificationImageUrl;
  final String deliveryManImageUrl;

  BaseUrls({
    required this.productImageUrl,
    required this.productThumbnailUrl,
    required this.digitalProductUrl,
    required this.brandImageUrl,
    required this.customerImageUrl,
    required this.bannerImageUrl,
    required this.categoryImageUrl,
    required this.reviewImageUrl,
    required this.sellerImageUrl,
    required this.shopImageUrl,
    required this.notificationImageUrl,
    required this.deliveryManImageUrl,
  });

  factory BaseUrls.fromJson(Map<String, dynamic> json) => BaseUrls(
    productImageUrl: json["product_image_url"],
    productThumbnailUrl: json["product_thumbnail_url"],
    digitalProductUrl: json["digital_product_url"],
    brandImageUrl: json["brand_image_url"],
    customerImageUrl: json["customer_image_url"],
    bannerImageUrl: json["banner_image_url"],
    categoryImageUrl: json["category_image_url"],
    reviewImageUrl: json["review_image_url"],
    sellerImageUrl: json["seller_image_url"],
    shopImageUrl: json["shop_image_url"],
    notificationImageUrl: json["notification_image_url"],
    deliveryManImageUrl: json["delivery_man_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "product_image_url": productImageUrl,
    "product_thumbnail_url": productThumbnailUrl,
    "digital_product_url": digitalProductUrl,
    "brand_image_url": brandImageUrl,
    "customer_image_url": customerImageUrl,
    "banner_image_url": bannerImageUrl,
    "category_image_url": categoryImageUrl,
    "review_image_url": reviewImageUrl,
    "seller_image_url": sellerImageUrl,
    "shop_image_url": shopImageUrl,
    "notification_image_url": notificationImageUrl,
    "delivery_man_image_url": deliveryManImageUrl,
  };
}

class Colorss {
  final int id;
  final String name;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  Colorss({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Colorss.fromJson(Map<String, dynamic> json) => Colorss(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class CurrencyList {
  final int id;
  final String name;
  final String symbol;
  final String code;
  final double exchangeRate;
  final int status;

  CurrencyList({
    required this.id,
    required this.name,
    required this.symbol,
    required this.code,
    required this.exchangeRate,
    required this.status,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory CurrencyList.fromJson(Map<String, dynamic> json) => CurrencyList(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    code: json["code"],
    exchangeRate: json["exchange_rate"].toDouble(),
    status: json["status"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "code": code,
    "exchange_rate": exchangeRate,
    "status": status,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
  };
}

class Faq {
  final int id;
  final String question;
  final String answer;
  final int ranking;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.ranking,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    ranking: json["ranking"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "ranking": ranking,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Language {
  final String code;
  final String name;

  Language({
    required this.code,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}

class PaymentMethods {
  final CashOnDelivery cashOnDelivery;
  final CashOnDelivery delayed;
  final CashOnDelivery wallet;
  final AmazonPay bankTransfer;
  // final AmazonPay mercadopago;
  // final AmazonPay liqpay;
  // final AmazonPay paypal;
  // final AmazonPay hyperPay;
  // final AmazonPay foloosi;
  // final AmazonPay paytm;
  // final AmazonPay amazonPay;
  // final AmazonPay paytabs;
  // final AmazonPay bkash;
  final AmazonPay fatoorah;
  // final AmazonPay ccavenue;
  // final AmazonPay thawani;
  // final AmazonPay sixcash;
  // final AmazonPay hubtel;
  // final AmazonPay tap;
  // final AmazonPay swish;
  // final AmazonPay payfast;
  // final AmazonPay esewa;
  // final AmazonPay vivaWallet;
  // final AmazonPay stripe;
  // final AmazonPay iyziPay;
  // final AmazonPay momo;
  // final AmazonPay moncash;
  // final AmazonPay razorPay;
  // final AmazonPay senangPay;
  // final AmazonPay paymobAccept;
  // final AmazonPay maxicash;
  // final AmazonPay pvit;
  // final AmazonPay flutterwave;
  // final AmazonPay paystack;
  // final AmazonPay xendit;
  // final AmazonPay worldpay;
  // final AmazonPay sslCommerz;
  // final Empty empty;

  PaymentMethods({
    required this.cashOnDelivery,
    required this.delayed,
    required this.wallet,
    required this.bankTransfer,
    // required this.mercadopago,
    // required this.liqpay,
    // required this.paypal,
    // required this.hyperPay,
    // required this.foloosi,
    // required this.paytm,
    // required this.amazonPay,
    // required this.paytabs,
    // required this.bkash,
    required this.fatoorah,
    // required this.ccavenue,
    // required this.thawani,
    // required this.sixcash,
    // required this.hubtel,
    // required this.tap,
    // required this.swish,
    // required this.payfast,
    // required this.esewa,
    // required this.vivaWallet,
    // required this.stripe,
    // required this.iyziPay,
    // required this.momo,
    // required this.moncash,
    // required this.razorPay,
    // required this.senangPay,
    // required this.paymobAccept,
    // required this.maxicash,
    // required this.pvit,
    // required this.flutterwave,
    // required this.paystack,
    // required this.xendit,
    // required this.worldpay,
    // required this.sslCommerz,
    // required this.empty,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
    cashOnDelivery: CashOnDelivery.fromJson(json["cash_on_delivery"]),
    delayed: CashOnDelivery.fromJson(json["delayed"]),
    wallet: CashOnDelivery.fromJson(json["wallet"]),
    bankTransfer: AmazonPay.fromJson(json["bank_transfer"]),

    fatoorah: AmazonPay.fromJson(json["fatoorah"]),

  );

  Map<String, dynamic> toJson() => {
    "cash_on_delivery": cashOnDelivery.toJson(),
    "delayed": delayed.toJson(),
    "wallet": wallet.toJson(),
    "bank_transfer": bankTransfer.toJson(),

    "fatoorah": fatoorah.toJson(),

  };
}

class AmazonPay {
  final String name;
  final int enabled;
  final String logo;
  final String apiKey;
  final List<Bank> banks;

  AmazonPay({
    required this.name,
    required this.enabled,
    required this.logo,
    required this.banks,
    required this.apiKey,
  });

  factory AmazonPay.fromJson(Map<String, dynamic> json) => AmazonPay(
    name: json["name"],
    enabled: json["enabled"],
    logo: json["logo"],
    apiKey: json["api_key"] ?? "",
    banks:json["banks"]!=null? List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "enabled": enabled,
    "logo": logo,
    "api_key": apiKey,
    "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
  };
}

class Bank {
  final String name;
  final String ownerName;
  final String accountNumber;
  final String iban;

  Bank({
    required this.name,
    required this.ownerName,
    required this.accountNumber,
    required this.iban,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    name: json["name"],
    ownerName: json["owner_name"],
    accountNumber: json["account_number"],
    iban: json["iban"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "owner_name": ownerName,
    "account_number": accountNumber,
    "iban": iban,
  };
}

class CashOnDelivery {
  final String name;
  final bool enabled;
  final String logo;

  CashOnDelivery({
    required this.name,
    required this.enabled,
    required this.logo,
  });

  factory CashOnDelivery.fromJson(Map<String, dynamic> json) => CashOnDelivery(
    name: json["name"],
    enabled: json["enabled"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "enabled": enabled,
    "logo": logo,
  };
}

class Empty {
  final dynamic isMyfatoorah;
  final dynamic id;
  final dynamic name;
  final int enabled;
  final dynamic logo;

  Empty({
    required this.isMyfatoorah,
    required this.id,
    required this.name,
    required this.enabled,
    required this.logo,
  });

  factory Empty.fromJson(Map<String, dynamic> json) => Empty(
    isMyfatoorah: json["is_myfatoorah"],
    id: json["id"],
    name: json["name"],
    enabled: json["enabled"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "is_myfatoorah": isMyfatoorah,
    "id": id,
    "name": name,
    "enabled": enabled,
    "logo": logo,
  };
}

class PrivacyPolicy {
  final String sa;
  final dynamic en;
  final dynamic fr;

  PrivacyPolicy({
    required this.sa,
    required this.en,
    required this.fr,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
    sa: json["sa"],
    en: json["en"],
    fr: json["fr"],
  );

  Map<String, dynamic> toJson() => {
    "sa": sa,
    "en": en,
    "fr": fr,
  };
}

class SocialLogin {
  final String loginMedium;
  final bool status;

  SocialLogin({
    required this.loginMedium,
    required this.status,
  });

  factory SocialLogin.fromJson(Map<String, dynamic> json) => SocialLogin(
    loginMedium: json["login_medium"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "login_medium": loginMedium,
    "status": status,
  };
}

class SocialMedia {
  final String name;
  final String link;
  final String icon;

  SocialMedia( {
    required this.link,
    required this.name,
    required this.icon,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    link: json["link"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "icon": icon,
  };
}

class StaticUrls {
  final String contactUs;
  final String brands;
  final String categories;
  final String customerAccount;

  StaticUrls({
    required this.contactUs,
    required this.brands,
    required this.categories,
    required this.customerAccount,
  });

  factory StaticUrls.fromJson(Map<String, dynamic> json) => StaticUrls(
    contactUs: json["contact_us"],
    brands: json["brands"],
    categories: json["categories"],
    customerAccount: json["customer_account"],
  );

  Map<String, dynamic> toJson() => {
    "contact_us": contactUs,
    "brands": brands,
    "categories": categories,
    "customer_account": customerAccount,
  };
}



