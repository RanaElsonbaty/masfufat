// To parse this JSON data, do
//
//     final supportReplyModel = supportReplyModelFromJson(jsonString);

import 'dart:convert';

List<SupportReplyModel> supportReplyModelFromJson(String str) => List<SupportReplyModel>.from(json.decode(str).map((x) => SupportReplyModel.fromJson(x)));

String supportReplyModelToJson(List<SupportReplyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportReplyModel {
  final int id;
  final int supportTicketId;
  final int adminId;
  final String customerMessage;
  final dynamic attachment;
  final dynamic adminMessage;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Attachment> ticketAttachments;
  final List<Attachment> attachments;
  final bool ofline;

  SupportReplyModel( {
    required this.id,
    required this.supportTicketId,
    required this.adminId,
    required this.customerMessage,
    required this.attachment,
    required this.adminMessage,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.ticketAttachments,
    required this.attachments,
     this.ofline=false,
  });

  factory SupportReplyModel.fromJson(Map<String, dynamic> json) => SupportReplyModel(
    id: json["id"],
    supportTicketId: json["support_ticket_id"],
    adminId:json["admin_id"] ?? 0,
    customerMessage: json["customer_message"]!=null? json["customer_message"]??'':'',
    attachment: json["attachment"],
    adminMessage: json["admin_message"]??'',
    position: json["position"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    ticketAttachments: List<Attachment>.from(json["ticket_attachments"].map((x) => Attachment.fromJson(x))),
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    ofline:  false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "support_ticket_id": supportTicketId,
    "admin_id": adminId,
    "customer_message": customerMessage,
    "attachment": attachment,
    "admin_message": adminMessage,
    "position": position,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "ticket_attachments": List<dynamic>.from(ticketAttachments.map((x) => x.toJson())),
    "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
  };
}

class Attachment {
  final int id;
  final int ticketId;
  final String fileName;
  final String filePath;
  final String fileType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int ticketConvId;
  final String fileUrl;

  Attachment({
    required this.id,
    required this.ticketId,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.createdAt,
    required this.updatedAt,
    required this.ticketConvId,
    required this.fileUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"]??0,
    ticketId: json["ticket_id"]??0,
    fileName: json["file_name"],
    filePath: json["file_path"]??'',
    fileType: json["file_type"]??'',
    createdAt:json["created_at"]!=null? DateTime.parse(json["created_at"]):DateTime.now(),
    updatedAt:json["updated_at"]!=null? DateTime.parse(json["updated_at"]):DateTime.now(),
    ticketConvId: json["ticket_conv_id"]??0,
    fileUrl: json["file_url"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "file_name": fileName,
    "file_path": filePath,
    "file_type": fileType,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "ticket_conv_id": ticketConvId,
    "file_url": fileUrl,
  };
}
