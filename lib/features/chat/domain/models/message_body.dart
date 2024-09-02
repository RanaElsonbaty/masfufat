class MessageBody {
  int? _id;
  String? _message;
  List<dynamic>? _file;

  MessageBody({required int id, required String message, required List file}) {
    _id = id;
    _message = message;
    _file = file;
  }

  int? get id => _id;
  String? get message => _message;
  List<dynamic>? get file => _file;

  MessageBody.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _message = json['message'];
    _file = json['attachments[]'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['message'] = _message;
    data['attachments[]'] = _file;
    return data;
  }
}
