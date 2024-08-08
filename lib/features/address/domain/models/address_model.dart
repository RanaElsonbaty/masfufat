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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_billing'] = isBilling;
    data['area_id'] = areaId;
    data['title'] = title;
    return data;
  }
}
