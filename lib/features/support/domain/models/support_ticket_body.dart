import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class SupportTicketBody {
  String? _type;
  String? _subject;
  String? _description;
  String? _priority;
  String? _orderid;
  List<XFile>? _attachments;
  SupportTicketBody(
      String orderid, String type, String subject, String description,String priority,List<XFile> attachments) {
    _orderid = orderid;
    _type = type;
    _priority = priority;
    _attachments=attachments;
    _subject = subject;
    _description = description;
  }
  String? get orderid => _orderid;
  String? get type => _type;
  List<XFile>? get attachments => _attachments;
  String? get subject => _subject;
  String? get priority => _priority;
  String? get description => _description;

  SupportTicketBody.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _subject = json['subject'];
    _attachments = json['attachments[]'];
    _priority = json['priority'];
    _description = json['description'];
    _orderid = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = _type;
    data['subject'] = _subject;
    data['description'] = _description;
    data['Priority'] = _priority;
    data['order_id'] = _orderid;
    data['attachments[]'] = _attachments;
    return data;
  }
}
