
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
  _id = id;
  _ticketId = ticketId;
  _title = title;
  _description = description;
  _image = image;
  _status = status;
  _createdAt = createdAt;
  _updatedAt = updatedAt;
  _seen = seen;
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
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = _id;
  data['title'] = _title;
  data['description'] = _description;
  data['image'] = _image;
  data['status'] = _status;
  data['created_at'] = _createdAt;
  data['updated_at'] = _updatedAt;
  data['seen'] = _seen;
  data['ticket_id'] = _ticketId;
  return data;
  }
  }
