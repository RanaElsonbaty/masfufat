import 'dart:convert';

StoreSettingModel linkedAccountsFromJson(String str) =>
    StoreSettingModel.fromJson(json.decode(str));

String linkedAccountsToJson(StoreSettingModel data) => json.encode(data.toJson());

class StoreSettingModel {
  String? token;
  String? appName;
  String? logo;
  LinkedAccountsSallaClass? store;

  StoreSettingModel({
    this.token,
    this.appName,
    this.logo,
    this.store
  });

  StoreSettingModel copyWith({
    String? token,
    String? appName,
    String? logo,
    LinkedAccountsSallaClass? store,
  }) =>
      StoreSettingModel(
          token: token ?? this.token,
          appName: appName ?? this.appName,
          logo: logo ?? this.logo,
          store: store ?? this.store
      );

  factory StoreSettingModel.fromJson(Map<String, dynamic> json) {
    return StoreSettingModel(
        token: json["token"],
        appName: json["app_name"],
        logo: json["logo"],
        store: json['store_details']!=null?LinkedAccountsSallaClass.fromJson(json['store_details']):null
    );
  }

  Map<String, dynamic> toJson() => {
    "token": token,
    "app_name": appName,
    "logo": logo,
    "store_details":store
  };
}
class LinkedAccountsSalla {
  final LinkedAccountsSallaClass linkedAccountsSalla;

  LinkedAccountsSalla({
    required this.linkedAccountsSalla,
  });

  factory LinkedAccountsSalla.fromJson(Map<String, dynamic> json) => LinkedAccountsSalla(
    linkedAccountsSalla: LinkedAccountsSallaClass.fromJson(json["linked_accounts_salla"]),
  );

  Map<String, dynamic> toJson() => {
    "linked_accounts_salla": linkedAccountsSalla.toJson(),
  };
}

class LinkedAccountsSallaClass {
  final int id;
  final String name;
  final String entity;
  final String type;
  final String email;
  final String avatar;
  final String plan;
  final String status;
  final bool verified;
  final String currency;
  final String domain;
  final String description;
  final Licenses licenses;
  final Social social;

  LinkedAccountsSallaClass({
    required this.id,
    required this.name,
    required this.entity,
    required this.type,
    required this.email,
    required this.avatar,
    required this.plan,
    required this.status,
    required this.verified,
    required this.currency,
    required this.domain,
    required this.description,
    required this.licenses,
    required this.social,
  });

  factory LinkedAccountsSallaClass.fromJson(Map<String, dynamic> json) => LinkedAccountsSallaClass(
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
    licenses: Licenses.fromJson(json["licenses"]),
    social: Social.fromJson(json["social"]),
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
    "licenses": licenses.toJson(),
    "social": social.toJson(),
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