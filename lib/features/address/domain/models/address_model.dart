class AddressModel {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;
  bool? state;
  String? country;
  String? latitude;
  String? longitude;
  int? isBilling;
  String? areaId;
  String? title;

  AddressModel(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.email,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.state,
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling,
        this.areaId,
        this.title});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'].toString();
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    if (json['email'] != null) {
      email = json['email'];
    } else {
      email = '';
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude']!=null?json['latitude'].toString():'0.000';
    longitude = json['longitude']!=null?json['longitude'].toString():'0.00';
    isBilling = json['is_billing'];
    areaId = json['area_id'].toString();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['contact_person_name'] = this.contactPersonName;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_billing'] = this.isBilling;
    data['area_id'] = this.areaId;
    data['title'] = this.title;
    return data;
  }
}
