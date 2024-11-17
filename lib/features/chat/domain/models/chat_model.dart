import 'package:flutter_sixvalley_ecommerce/data/model/image_full_url.dart';

class ChatModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Chat>? chat;

  ChatModel({this.totalSize, this.limit, this.offset, this.chat});

  ChatModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(Chat.fromJson(v));
      });
    }
  }

}

class Chat {
  int? id;
  int? userId;
  int? sellerId;
  int? adminId;
  int? deliveryManId;
  String? message;
  bool? sentByCustomer;
  bool? sentBySeller;
  bool? sentByAdmin;
  bool? sentByDeliveryMan;
  bool? seenByCustomer;
  String? createdAt;
  String? updatedAt;
  SellerInfo? sellerInfo;
  DeliveryMan? deliveryMan;
  int? unseenMessageCount;

  Chat(
      {this.id,
        this.userId,
        this.sellerId,
        this.adminId,
        this.deliveryManId,
        this.message,
        this.sentByCustomer,
        this.sentBySeller,
        this.sentByAdmin,
        this.sentByDeliveryMan,
        this.seenByCustomer,
        this.createdAt,
        this.updatedAt,
        this.sellerInfo,
        this.deliveryMan,
        this.unseenMessageCount,
      });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    adminId = json['admin_id'];
    if(json['delivery_man_id'] != null){
      deliveryManId = int.parse(json['delivery_man_id'].toString());
    }

    message = json['message'];
    sentByCustomer = json['sent_by_customer']==1;
    sentBySeller = json['sent_by_seller']==1;
    sentByAdmin = json['sent_by_admin']==1;
    sentByDeliveryMan = json['sent_by_delivery_man']==1;
    seenByCustomer = json['seen_by_customer']==1;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sellerInfo = json['seller_info'] != null ? SellerInfo.fromJson(json['seller_info']) : null;
    deliveryMan = json['delivery_man'] != null ? DeliveryMan.fromJson(json['delivery_man']) : null;
    unseenMessageCount = json['unseen_message_count'];

  }

}


class SellerInfo {
  // List<Shops>? shops;
   List<Shop>? shops;
  SellerInfo(
      {this.shops});

  SellerInfo.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      shops = <Shop>[];
      json['shops'].forEach((v) {
        shops!.add(Shop.fromJson(v));
      });
    }
  }

}
class Shop {
  final int id;
  final int sellerId;
  final String name;
  final String address;
  final String contact;
  final String image;
  final dynamic bottomBanner;
  final dynamic offerBanner;
  final dynamic vacationStartDate;
  final dynamic vacationEndDate;
  final dynamic vacationNote;
  final int vacationStatus;
  final int temporaryClose;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String banner;
  // final Seller seller;

  Shop({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.image,
    required this.bottomBanner,
    required this.offerBanner,
    required this.vacationStartDate,
    required this.vacationEndDate,
    required this.vacationNote,
    required this.vacationStatus,
    required this.temporaryClose,
    required this.createdAt,
    required this.updatedAt,
    required this.banner,
    // required this.seller,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    sellerId: json["seller_id"],
    name: json["name"]??'',
    address: json["address"],
    contact: json["contact"],
    image: json["image"],
    bottomBanner: json["bottom_banner"],
    offerBanner: json["offer_banner"],
    vacationStartDate: json["vacation_start_date"],
    vacationEndDate: json["vacation_end_date"],
    vacationNote: json["vacation_note"],
    vacationStatus: json["vacation_status"],
    temporaryClose: json["temporary_close"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    banner: json["banner"],
    // seller: Seller.fromJson(json["seller"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "name": name,
    "address": address,
    "contact": contact,
    "image": image,
    "bottom_banner": bottomBanner,
    "offer_banner": offerBanner,
    "vacation_start_date": vacationStartDate,
    "vacation_end_date": vacationEndDate,
    "vacation_note": vacationNote,
    "vacation_status": vacationStatus,
    "temporary_close": temporaryClose,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "banner": banner,
    // "seller": seller.toJson(),
  };
}

class Shops {
  int? id;
  int? sellerId;
  String? name;
  String? address;
  String? contact;
  String? image;
  ImageFullUrl? imageFullUrl;
  String? bottomBanner;
  String? offerBanner;
  String? vacationStartDate;
  String? vacationEndDate;
  String? vacationNote;
  bool? vacationStatus;
  bool? temporaryClose;
  String? createdAt;
  String? updatedAt;
  String? banner;

  Shops(
      {this.id,
        this.sellerId,
        this.name,
        this.address,
        this.contact,
        this.image,
        this.imageFullUrl,
        this.bottomBanner,
        this.offerBanner,
        this.vacationStartDate,
        this.vacationEndDate,
        this.vacationNote,
        this.vacationStatus,
        this.temporaryClose,
        this.createdAt,
        this.updatedAt,
        this.banner});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = int.parse(json['seller_id'].toString());
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    if (json['image_full_url'] != null) {
      imageFullUrl = ImageFullUrl.fromJson(json['image_full_url']);
    }
    bottomBanner = json['bottom_banner'];
    offerBanner = json['offer_banner'];
    vacationStartDate = json['vacation_start_date'];
    vacationEndDate = json['vacation_end_date'];
    vacationNote = json['vacation_note'];
    if(json['vacation_status'] != null){
      try{
        vacationStatus = json['vacation_status']??false;
      }catch(e){
        vacationStatus = json['vacation_status']==1? true :false;
      }
    }
    if(json['temporary_close'] != null){
      try{
        temporaryClose = json['temporary_close']??false;
      }catch(e){
        temporaryClose = json['temporary_close']== 1?true : false;
      }
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
  }

}

class DeliveryMan {
  int? id;
  String? fName;
  String? lName;
  String? image;
  String? phone;
  String? code;
  ImageFullUrl? imageFullUrl;



  DeliveryMan({this.id,
    this.fName,
    this.lName,
    this.image,
    this.code,
    this.phone,
    this.imageFullUrl
  });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    image = json['image'];
    phone = json['phone'];
    code = json['country_code'];
    imageFullUrl = json['image_full_url'] != null
      ? ImageFullUrl.fromJson(json['image_full_url'])
      : null;

  }
}