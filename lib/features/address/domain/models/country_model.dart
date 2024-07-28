// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  final int id;
  final String name;
  // final String phoneCode;/
  // final String photo;
  final String enabled;
  final String code;
  final String rank;
  // final DateTime deletedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final int deleted;
  // final List<Translation> translations;

  CountryModel({
    required this.id,
    required this.name,
    // required this.phoneCode,
    // required this.photo,
    required this.enabled,
    required this.code,
    required this.rank,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.deleted,
    // required this.translations,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["id"]??'',
    name: json["name"]??'',
    // phoneCode: json["phone_code"],
    // photo: json["photo"],
    enabled: json["enabled"].toString(),
    code: json["code"]??'',
    rank: json["rank"]??'',
    // deletedAt: DateTime.parse(json["deleted_at"]),
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
    // deleted: json["deleted"],
    // translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    // "phone_code": phoneCode,
    // "photo": photo,
    "enabled": enabled,
    "code": code,
    "rank": rank,
    // "deleted_at": deletedAt.toIso8601String(),
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
    // "deleted": deleted,
    // "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
  };
}

class Translation {
  final int translationableId;
  final String value;

  Translation({
    required this.translationableId,
    required this.value,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    translationableId: json["translationable_id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "translationable_id": translationableId,
    "value": value,
  };
}
