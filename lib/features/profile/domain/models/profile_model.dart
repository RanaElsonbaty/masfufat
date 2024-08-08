
class ProfileModel {
  final int id;
  final String name;
  final dynamic fName;
  final dynamic lName;
  final String phone;
  final String image;
  late final String email;
  final dynamic emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String streetAddress;
  final String country;
  final String city;
  final dynamic zip;
  final dynamic houseNo;
  final dynamic apartmentNo;
  final String cmFirebaseToken;
  final int isActive;
  final dynamic paymentCardLastFour;
  final dynamic paymentCardBrand;
  final dynamic paymentCardFawryToken;
  final dynamic loginMedium;
  final dynamic socialId;
  final int isPhoneVerified;
  final String temporaryToken;
  final int isEmailVerified;
  final double walletBalance;
  final double loyaltyPoint;
  final dynamic loginCode;
  final dynamic linkedProducts;
  final dynamic pendingProducts;
  final int endCustomer;
  final dynamic extAccounts;
  final StoreInformations storeInformations;
  final int isStore;
  final String subscription;
  final String subscriptionStart;
  final String subscriptionEnd;
  final dynamic favMenu;
  final dynamic paymentMethods;
  final dynamic verificationcode;
  final DateTime lastMsgAt;
  final dynamic managerId;
  final int deleted;
  final dynamic activity;
  final dynamic referralCode;
  final dynamic referredBy;
  final String appLanguage;
  final String joinedUsing;
  final String governorate;
  final String area;
  final String commercialRegistrationImg;
  final String taxCertificateImg;


  ProfileModel({
    required this.id,
    required this.name,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.image,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.streetAddress,
    required this.country,
    required this.city,
    required this.zip,
    required this.houseNo,
    required this.apartmentNo,
    required this.cmFirebaseToken,
    required this.isActive,
    required this.paymentCardLastFour,
    required this.paymentCardBrand,
    required this.paymentCardFawryToken,
    required this.loginMedium,
    required this.socialId,
    required this.isPhoneVerified,
    required this.temporaryToken,
    required this.isEmailVerified,
    required this.walletBalance,
    required this.loyaltyPoint,
    required this.loginCode,
    required this.linkedProducts,
    required this.pendingProducts,
    required this.endCustomer,
    required this.extAccounts,
    required this.storeInformations,
    required this.isStore,
    required this.subscription,
    required this.subscriptionStart,
    required this.subscriptionEnd,
    required this.favMenu,
    required this.paymentMethods,
    required this.verificationcode,
    required this.lastMsgAt,
    required this.managerId,
    required this.deleted,
    required this.activity,
    required this.referralCode,
    required this.referredBy,
    required this.appLanguage,
    required this.joinedUsing,
    required this.governorate,
    required this.area,
    required this.commercialRegistrationImg,
    required this.taxCertificateImg,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"],
      name: json["name"],
      fName: json["f_name"],
      lName: json["l_name"],
      phone: json["phone"],
      image: json["image"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      streetAddress:json["street_address"] ?? '',
      country: json["country"],
      city: json["city"],
      zip: json["zip"],
      houseNo: json["house_no"],
      apartmentNo: json["apartment_no"],
      cmFirebaseToken: json["cm_firebase_token"],
      isActive: json["is_active"],
      paymentCardLastFour: json["payment_card_last_four"],
      paymentCardBrand: json["payment_card_brand"],
      paymentCardFawryToken: json["payment_card_fawry_token"],
      loginMedium: json["login_medium"],
      socialId: json["social_id"],
      isPhoneVerified: json["is_phone_verified"],
      temporaryToken: json["temporary_token"],
      isEmailVerified: json["is_email_verified"],
      walletBalance: json["wallet_balance"]!=null?json["wallet_balance"]!.toDouble():0.00 ,
      loyaltyPoint: json["loyalty_point"]!=null? json["loyalty_point"].toDouble():0.00,
      loginCode: json["login_code"],
      linkedProducts: json["linked_products"],
      pendingProducts: json["pending_products"],
      endCustomer: json["end_customer"],
      extAccounts: json["ext_accounts"],
      storeInformations: StoreInformations.fromJson(json["store_informations"]),
      isStore: json["is_store"],
      subscription: json["subscription"],
      subscriptionStart: json["subscription_start"] ?? "",
      subscriptionEnd: json["subscription_end"] ?? "",
      favMenu: json["fav_menu"],
      paymentMethods: json["payment_methods"],
      verificationcode: json["verificationcode"],
      lastMsgAt: DateTime.parse(json["last_msg_at"]),
      managerId: json["manager_id"],
      deleted: json["deleted"],
      activity: json["activity"],
      referralCode: json["referral_code"],
      referredBy: json["referred_by"],
      appLanguage: json["app_language"],
      joinedUsing: json["joined_using"],
      governorate: json["governorate"],
      area: json["area"],
      commercialRegistrationImg: json["commercial_registration_img"],
      taxCertificateImg: json["tax_certificate_img"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "f_name": fName,
    "l_name": lName,
    "phone": phone,
    "image": image,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "street_address": streetAddress,
    "country": country,
    "city": city,
    "zip": zip,
    "house_no": houseNo,
    "apartment_no": apartmentNo,
    "cm_firebase_token": cmFirebaseToken,
    "is_active": isActive,
    "payment_card_last_four": paymentCardLastFour,
    "payment_card_brand": paymentCardBrand,
    "payment_card_fawry_token": paymentCardFawryToken,
    "login_medium": loginMedium,
    "social_id": socialId,
    "is_phone_verified": isPhoneVerified,
    "temporary_token": temporaryToken,
    "is_email_verified": isEmailVerified,
    "wallet_balance": walletBalance,
    "loyalty_point": loyaltyPoint,
    "login_code": loginCode,
    "linked_products": linkedProducts,
    "pending_products": pendingProducts,
    "end_customer": endCustomer,
    "ext_accounts": extAccounts,
    "store_informations": storeInformations.toJson(),
    "is_store": isStore,
    "subscription": subscription,
    "subscription_start": subscriptionStart,
    "subscription_end": subscriptionEnd,
    "fav_menu": favMenu,
    "payment_methods": paymentMethods,
    "verificationcode": verificationcode,
    "last_msg_at": lastMsgAt.toIso8601String(),
    "manager_id": managerId,
    "deleted": deleted,
    "activity": activity,
    "referral_code": referralCode,
    "referred_by": referredBy,
    "app_language": appLanguage,
    "joined_using": joinedUsing,
    "governorate": governorate,
    "area": area,
    "commercial_registration_img": commercialRegistrationImg,
    "tax_certificate_img": taxCertificateImg,
  };
}

class StoreInformations {
  final String pricingLevel;
  final String companyName;
  final String name;
  final String phone;
  final String email;
  final String password;
  late final String delegateName;
  final String delegatePhone;
  final String commercialRegistrationNo;
  final String taxNo;
  final String governorate;
  final String lat;
  final String lon;
  final String address;
  final dynamic plan;
  final String remember;
  final String nationality;
  final String siteUrl;
  final String vendorAccountNumber;
  final String image;
  final String commercialRegistrationImg;
  final String taxCertificateImg;
  final String identityType;
  final String IdNumber;
  final String zip;
  final String releaseDateIdNumber;
  final String occupation;
  final String expiryDateIdNumber;
  final int country;
  final String employer;
  final String gender;
  final String releaseDateCommercialRegister;
  final String expiryDateCommercialRegister;
  final String releaseDateTaxNo;
  final String expiryDateTaxNo;
  final String buildingNo;
  final String titleExplanation;
  final String subNo;
  final String shortTitleCode;
  final String unitNo;
  final String neighborhood;
  final String street;
  final int area;
  final int city;

  StoreInformations( {
    required this.pricingLevel,
    required this.companyName,
    required this.releaseDateCommercialRegister,
    required this.unitNo,
    required this.expiryDateCommercialRegister,
    required this.vendorAccountNumber,
    required this.shortTitleCode,
    required this.releaseDateTaxNo,
    required this.buildingNo,
    required this.expiryDateTaxNo,
    required this.releaseDateIdNumber,required this.expiryDateIdNumber,
    required this.name,
    required this.phone,
    required this.email,
    required this.employer,
    required this.neighborhood,
    required this.siteUrl,
    required this.password,
    required this.delegateName,
    required this.street,
    required this.delegatePhone,
    required this.commercialRegistrationNo,
    required this.occupation,
    required this.subNo,
    required this.taxNo,
    required this.governorate,
    required this.nationality,
    required this.lat,
    required this.lon,
    required this.titleExplanation,
    required this.address,
    required this.zip,
    required this.gender,

    required this.plan,
    required this.remember,
    required this.image,
    required this.commercialRegistrationImg,
    required this.taxCertificateImg,
    required this.country,
    required this.area,
    required this.identityType,
    required this.city,
    required this.IdNumber,
  });

  factory StoreInformations.fromJson(Map<String, dynamic> json) => StoreInformations(
    pricingLevel: json["pricing_level"]!=null? json["pricing_level"].toString():'0',
    companyName: json["company_name"],
    name: json["name"],
    vendorAccountNumber:json['vendor_account_number'] ?? "",
    phone: json["phone"],
    buildingNo:json['building_no']!=null?json['building_no'].toString():"",
    subNo:json['sub_no']!=null?json['sub_no'].toString():"",
    shortTitleCode:json['short_title_code']!=null?json['short_title_code'].toString():"",
    unitNo:json['unit_no']!=null?json['unit_no'].toString():"",
    neighborhood:json['neighborhood']!=null?json['neighborhood'].toString():"",
    street:json['street']!=null?json['street'].toString():"",
    titleExplanation:json['title_explanation']!=null?json['title_explanation'].toString():"",
    zip:json['zip'] ?? "",
    expiryDateCommercialRegister: json['release_date_commercial_register'] ?? "",
    expiryDateTaxNo:json['expiry_date_commercial_register'] ?? "",
    releaseDateCommercialRegister: json['release_date_tax_no'] ?? "",
    releaseDateTaxNo: json['expiry_date_tax_no'] ?? "",
    releaseDateIdNumber:json['release_date_id_number'] ?? "",
    expiryDateIdNumber:json['expiry_date_id_number'] ?? "",
    email: json["email"],
    password: json["password"] ?? '',
    delegateName: json["delegate_name"] ?? '',
    delegatePhone: json["delegate_phone"]!=null?json["delegate_phone"].toString():"",
    commercialRegistrationNo: json["commercial_registration_no"],
    taxNo: json["tax_no"]!=null?json["tax_no"].toString():'',
    governorate: json["governorate"].toString(),
    lat: json["lat"]!=null?json["lat"].toString():'0.0',
    lon: json["lon"]!=null?json["lon"].toString():'0.0',
    gender: json['gender'] ?? "",
    nationality:json['nationality'] ?? "",
    employer :json['employer'] ?? "",
    occupation :json['occupation'] ?? "",
    siteUrl:json['site_url'] ?? "",
    address: json["address"] ?? '',
    plan: json["plan"],
    remember: json["remember"]!=null? json["remember"].toString():'',
    image: json["image"],
    IdNumber:json['id_number'] ?? "",
    identityType:json['identity_type'] ?? "",
    commercialRegistrationImg: json["commercial_registration_img"] ?? '',
    taxCertificateImg: json["tax_certificate_img"]!=null?json["tax_certificate_img"].toString():'',
    country: json["country"],
    area: json["area"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "pricing_level": pricingLevel,
    "company_name": companyName,
    "name": name,
    "phone": phone,
    "email": email,
    "password": password,
    "delegate_name": delegateName,
    "delegate_phone": delegatePhone,
    "commercial_registration_no": commercialRegistrationNo,
    "tax_no": taxNo,
    "governorate": governorate,
    "lat": lat,
    "lon": lon,
    "address": address,
    "plan": plan,
    'id_number':IdNumber,
    "remember": remember,
    "occupation":occupation

    ,
    'gender':gender,
    "release_date_id_number":releaseDateIdNumber,
    'expiry_date_id_number':expiryDateIdNumber,
    "employer":employer,
    "image": image,'site_url':siteUrl,
    "commercial_registration_img": commercialRegistrationImg,
    "tax_certificate_img": taxCertificateImg,
    "country": country,
    'zip'
        :zip,"area": area,
    'release_date_commercial_register':releaseDateCommercialRegister,
    'expiry_date_commercial_register':expiryDateCommercialRegister,
    'release_date_tax_no':releaseDateTaxNo,
    // 'release_date_tax_no':releaseDateTaxNo,
    'vendor_account_number':vendorAccountNumber,
    "identity_type": identityType,
    "nationality": nationality,
    "city": city,
  };
}
