// To parse this JSON data, do
//
//     final packages = packagesFromJson(jsonString);

import 'dart:convert';

List<Packages> packagesFromJson(String str) => List<Packages>.from(json.decode(str).map((x) => Packages.fromJson(x)));

String packagesToJson(List<Packages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Packages {
  final int id;
  final String name;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
  final int enabled;
  final String services;
  final String icon;
  final String desc;
  final int period;
  final String pricingLevel;
  final String type;
  final int deleted;
  final bool currentPack;
  final List<Feature> features;

  Packages({
    required this.id,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.enabled,
    required this.services,
    required this.icon,
    required this.desc,
    required this.period,
    required this.pricingLevel,
    required this.type,
    required this.deleted,
    required this.currentPack,
    required this.features,
  });

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: DateTime.parse(json["deleted_at"]),
    enabled: json["enabled"],
    services: json["services"],
    icon: json["icon"],
    desc: json["desc"],
    period: json["period"],
    pricingLevel: json["pricing_level"],
    type: json["type"],
    deleted: json["deleted"],
    currentPack: json["current_pack"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt.toIso8601String(),
    "enabled": enabled,
    "services": services,
    "icon": icon,
    "desc": desc,
    "period": period,
    "pricing_level": pricingLevel,
    "type": type,
    "deleted": deleted,
    "current_pack": currentPack,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
  };
}

class Feature {
  final int id;
  final String name;

  Feature({
    required this.id,
    required this.name,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
