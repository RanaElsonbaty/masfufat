// To parse this JSON data, do
//
//     final orderRefuntModel = orderRefuntModelFromJson(jsonString);

import 'dart:convert';

OrderRefuntModel orderRefuntModelFromJson(String str) => OrderRefuntModel.fromJson(json.decode(str));

String orderRefuntModelToJson(OrderRefuntModel data) => json.encode(data.toJson());

class OrderRefuntModel {
  final double productPrice;
  final int quntity;
  final int productTotalDiscount;
  final double productTotalTax;
  final double subtotal;
  final double couponDiscount;
  final double refundAmount;
  final List<RefundRequest> refundRequest;

  OrderRefuntModel({
    required this.productPrice,
    required this.quntity,
    required this.productTotalDiscount,
    required this.productTotalTax,
    required this.subtotal,
    required this.couponDiscount,
    required this.refundAmount,
    required this.refundRequest,
  });

  factory OrderRefuntModel.fromJson(Map<String, dynamic> json) => OrderRefuntModel(
    productPrice: double.tryParse(json["product_price"].toString())!,
    quntity: json["quntity"],
    productTotalDiscount: json["product_total_discount"],
    productTotalTax: json["product_total_tax"].toDouble(),
    subtotal: json["subtotal"].toDouble(),
    couponDiscount: json["coupon_discount"].toDouble(),
    refundAmount: json["refund_amount"].toDouble(),
    refundRequest: List<RefundRequest>.from(json["refund_request"].map((x) => RefundRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_price": productPrice,
    "quntity": quntity,
    "product_total_discount": productTotalDiscount,
    "product_total_tax": productTotalTax,
    "subtotal": subtotal,
    "coupon_discount": couponDiscount,
    "refund_amount": refundAmount,
    "refund_request": List<dynamic>.from(refundRequest.map((x) => x.toJson())),
  };
}

class RefundRequest {
  final int id;
  final int orderDetailsId;
  final int customerId;
  final String status;
  final double amount;
  final int productId;
  final int orderId;
  final String refundReason;
  final List<String> images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic approvedNote;
  final dynamic rejectedNote;
  final dynamic paymentInfo;
  final dynamic changeBy;
  final int deleted;
  final dynamic refundAttachments;

  RefundRequest({
    required this.id,
    required this.orderDetailsId,
    required this.customerId,
    required this.status,
    required this.amount,
    required this.productId,
    required this.orderId,
    required this.refundReason,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    required this.approvedNote,
    required this.rejectedNote,
    required this.paymentInfo,
    required this.changeBy,
    required this.deleted,
    required this.refundAttachments,
  });

  factory RefundRequest.fromJson(Map<String, dynamic> json) => RefundRequest(
    id: json["id"],
    orderDetailsId: json["order_details_id"],
    customerId: json["customer_id"],
    status: json["status"],
    amount: json["amount"].toDouble(),
    productId: json["product_id"],
    orderId: json["order_id"],
    refundReason: json["refund_reason"],
    images:json["images"] !=null&&json["images"]!=[]?List<String>.from(json["images"].map((x) => x)):[],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    approvedNote: json["approved_note"],
    rejectedNote: json["rejected_note"],
    paymentInfo: json["payment_info"],
    changeBy: json["change_by"],
    deleted: json["deleted"],
    refundAttachments: json["refund_attachments"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_details_id": orderDetailsId,
    "customer_id": customerId,
    "status": status,
    "amount": amount,
    "product_id": productId,
    "order_id": orderId,
    "refund_reason": refundReason,
    "images": List<dynamic>.from(images.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "approved_note": approvedNote,
    "rejected_note": rejectedNote,
    "payment_info": paymentInfo,
    "change_by": changeBy,
    "deleted": deleted,
    "refund_attachments": refundAttachments,
  };
}
