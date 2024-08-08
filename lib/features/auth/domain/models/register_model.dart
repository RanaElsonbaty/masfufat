class RegisterModel {
  String? companyName;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? delegateName;
  String? delegatePhone;
  String? commercialRegistrationNo;
  String? taxNo;
  String? governorate;
  String? lat;
  String? lon;
  String? address;
  String? plan;
  String? remember;
  String? image;
  String? commercialRegistrationImg;
  String? taxCertificateImg;
  String? code;



  RegisterModel({
    this.companyName,
    this.name,
    this.delegatePhone,
    this.delegateName,
    this.lat,
    this.lon,
    this.address,
    this.commercialRegistrationImg,
    this.taxNo,
    this.taxCertificateImg,
    this.plan,
    this.remember,
    this.email,
    this.image,
    this.governorate,
    this.phone,
    this.commercialRegistrationNo,
    this.password,
    this.code,


  });



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['company_name'] = companyName;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['delegate_name'] = delegateName;
    data['delegate_phone'] = delegatePhone;
    data['commercial_registration_no'] = commercialRegistrationNo;
    data['tax_no'] = taxNo;
    data['governorate'] = governorate;
    data['lat'] = lat;
    data['lon'] = lon;
    data['address'] = address;
    data['plan'] = plan;
    data['remember'] = remember;
    data['image'] = image;
    data['commercial_registration_img'] = commercialRegistrationImg;
    data['tax_certificate_img'] = taxCertificateImg;
    data['referral_code'] = code;


    return data;
  }
}
