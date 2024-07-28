import 'package:flutter_sixvalley_ecommerce/data/model/image_full_url.dart';

// class NotificationItemModel {
  // ignore_for_file: non_constant_identifier_names

  class NotificationItemModel {
  int? _id;
  String? _title;
  String? _description;
  String? _image;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  List<dynamic>? _seen;
  String? _seen_by;
  String? _ticketId;

  NotificationItemModel(
  {int? id,
  String? title,
  String? ticketId,
  String? description,
  String? image,
  int? status,
  String? createdAt,
  String? updatedAt,
  String? seen_by,
  List<dynamic>? seen}) {
  this._id = id;
  this._ticketId = ticketId;
  this._title = title;
  this._description = description;
  this._image = image;
  this._status = status;
  this._createdAt = createdAt;
  this._updatedAt = updatedAt;
  this._seen = seen;
  this.seen_by;
  }

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<dynamic>? get seen => _seen;
  String? get seen_by => _seen_by;
  String? get ticketId => _ticketId;

  NotificationItemModel.fromJson(Map<String, dynamic> json) {
  _id = json['id'];
  _title = json['title'];
  _description = json['description'];
  _image = json['image'];
  _status = json['status'];
  _createdAt = json['created_at'];
  _updatedAt = json['updated_at'];
  _seen = json['seen'];
  _seen_by = json['seen_by'];
  if (json['ticket_id'] != null) {
  _ticketId = json['ticket_id'];
  } else {
  _ticketId = '';
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this._id;
  data['title'] = this._title;
  data['description'] = this._description;
  data['image'] = this._image;
  data['status'] = this._status;
  data['created_at'] = this._createdAt;
  data['updated_at'] = this._updatedAt;
  data['seen'] = this._seen;
  data['ticket_id'] = this._ticketId;
  return data;
  }
  }
