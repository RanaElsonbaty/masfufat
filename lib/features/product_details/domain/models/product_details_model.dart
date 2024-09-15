// ignore_for_file: non_constant_identifier_names

import 'dart:convert';



class ProductDetailsModel {
  int? _id;
  String? _addedBy;
  int? _userId;
  String? _name;
  String? _slug;
  String? _productType;
  List<CategoryIds>? _categoryIds;
  int? _brandId;
  List? _wishList;
  String? _brand;
  int? _orderCount;
   String? _unit;
  int? _minQty;
  String? _itemNumber;
  int? _refundable;
  String? _digitalProductType;
  String? _digitalFileReady;
  List<String>? _images;
  String? _thumbnail;
  Map<String, dynamic>? _desc;
  String? _brandImg;
  int? _featured;
  String? _videoProvider;
  Map<String, dynamic>? _videoUrl;
  List<Colorss>? _colors = [];
  int? _variantProduct;
  List<int>? _attributes;
  List<ChoiceOptions>? _choiceOptions;
  List<Variation>? _variation;
  int? _published;
  double? _unitPrice;
  double? _purchasePrice;
  double? _tax;
  String? _taxModel;
  String? _taxType;
  double? _discount;
  String? _discountType;
  int? _currentStock;
  int? _minimumOrderQty;
  String? _details;
  int? _freeShipping;
  String? _createdAt;
  String? _promo;
  String? _short_desc;
  String? _updatedAt;
  int? _status;
  int? _featuredStatus;
  String? _metaTitle;
  String? _metaDescription;
  String? _metaImage;
  int? _requestStatus;
  String? _deniedNote;
  double? _shippingCost;
  List<SinglePropModel>? _props;
  int? _multiplyQty;
  String? _code;
  int? _reviewsCount;
  String? _averageReview;
  int? _reviewsOneCount;
  int? _reviewsTwoCount;
  int? _reviewsThreeCount;
  int? _reviewsFourCount;
  int? _reviewsFiveCount;
  bool? _inWishList;

  double? _reviewsOneAvg;
  double? _reviewsTwoAvg;
  double? _reviewsThreeAvg;
  double? _reviewsFourAvg;
  double? _reviewsFiveAvg;

  List<Review>? _reviews;
  Seller? _seller;
  String? _gtin;
  String? _mpn;
  String? _length;
  String? _height;
  String? _width;
  String? _size;
  String? _space;
  String? _weight;
  String? _madeIn;
  String? _color;
  String? _hsCode;
  ProductDisplayFor? _displayFor;

  ProductDetailsModel({
    int? id,
    String? addedBy,
    ProductDisplayFor? displayFor,
    String? space,
    List? wishList,
    String? unit,
    int? reviewsOneCount,
    int? orderCount,
    int? reviewsTwoCount,
    int? reviewsThreeCount,
    int? reviewsFourCount,
    int? reviewsFiveCount,
    double? reviewsOneAvg,
    double? reviewsTwoAvg,
    double? reviewsThreeAvg,
    double? reviewsFourAvg,
    double? reviewsFiveAvg,
    int? userId,
    String? name,
    String? brand,
    String? mpn,
    String? itemNumber,
    String? color,
    Map<String, dynamic>? desc,
    String? slug,
    String? hsCode,
    String? productType,
    List<CategoryIds>? categoryIds,
    int? brandId,
    String? brandImg,
    List<SinglePropModel>? props,
    int? minQty,
    String? promo,
    String? shortDisc,
    int? refundable,
    String? digitalProductType,
    String? digitalFileReady,
    List<String>? images,
    String? thumbnail,
    int? featured,
    String? videoProvider,
    Map<String, dynamic>? videoUrl,
    List<Colorss>? colors,
    int? variantProduct,
    List<int>? attributes,
    List<ChoiceOptions>? choiceOptions,
    List<Variation>? variation,
    int? published,
    double? unitPrice,
    double? purchasePrice,
    double? tax,
    String? taxModel,
    String? taxType,
    double? discount,
    String? discountType,
    int? currentStock,
    int? minimumOrderQty,
    String? details,
    int? freeShipping,
    String? createdAt,
    String? updatedAt,
    int? status,
    int? featuredStatus,
    String? metaTitle,
    String? metaDescription,
    String? metaImage,
    int? requestStatus,
    String? deniedNote,
    double? shippingCost,
    int? multiplyQty,
    String? code,
    String? length,
    String? width,
    String? height,
    String? size,
    String? weight,
    String? gtin,
    int? reviewsCount,
    String? averageReview,
    String? madeIn,
    List<Review>? reviews,
    Seller? seller,
  }) {
    if (id != null) {
      _id = id;
    }
    if (brand != null) {
      _brand = brand;
    } if (wishList != null) {
      _wishList = wishList;
    }
    if (color != null) {
      _color = color;
    }if (orderCount != null) {
      _orderCount = orderCount;
    }
    if (desc != null) {
      _desc = desc;
    }
    if (unit != null) {
      _unit = unit;
    }
    if (madeIn != null) {
      _madeIn = madeIn;
    }
    if (props != null) {
      _props = props;
    }
    if (addedBy != null) {
      _addedBy = addedBy;
    }
    if (mpn != null) {
      _mpn = mpn;
    }
    if (itemNumber != null) {
      _itemNumber = _itemNumber;
    }
    if (brandImg != null) {
      _brandImg = brandImg;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (hsCode != null) {
      _hsCode = hsCode;
    }
    if (space != null) {
      _space = space;
    }
    if (weight != null) {
      _weight = weight;
    }
    if (gtin != null) {
      _gtin = gtin;
    }
    if (name != null) {
      _name = name;
    }
    if (height != null) {
      _height = height;
    }
    if (size != null) {
      _size = size;
    }
    if (length != null) {
      _length = length;
    }
    if (width != null) {
      _width = width;
    }
    if (slug != null) {
      _slug = slug;
    }
    if (productType != null) {
      _productType = productType;
    }
    if (categoryIds != null) {
      _categoryIds = categoryIds;
    }
    if (brandId != null) {
      _brandId = brandId;
    }

    if (minQty != null) {
      _minQty = minQty;
    }
    if (refundable != null) {
      _refundable = refundable;
    }
    if (digitalProductType != null) {
      _digitalProductType = digitalProductType;
    }
    if (digitalFileReady != null) {
      _digitalFileReady = digitalFileReady;
    }
    if (images != null) {
      _images = images;
    }
    if (thumbnail != null) {
      _thumbnail = thumbnail;
    }
    if (featured != null) {
      _featured = featured;
    }

    if (videoProvider != null) {
      _videoProvider = videoProvider;
    }
    if (videoUrl != null) {
      _videoUrl = videoUrl;
    }
    if (colors != null) {
      _colors = colors;
    }
    if (variantProduct != null) {
      _variantProduct = variantProduct;
    }
    if (attributes != null) {
      _attributes = attributes;
    }

    if (displayFor != null) {
      _displayFor = displayFor;
    }

    if (reviewsOneCount != null) {
      _reviewsOneCount = reviewsOneCount;
    }
    if (reviewsTwoCount != null) {
      _reviewsTwoCount = reviewsTwoCount;
    }
    if (reviewsThreeCount != null) {
      _reviewsThreeCount = reviewsThreeCount;
    }
    if (reviewsFourCount != null) {
      _reviewsFourCount = reviewsFourCount;
    }
    if (reviewsFiveCount != null) {
      _reviewsFiveCount = reviewsFiveCount;
    }

    if (reviewsOneAvg != null) {
      _reviewsOneAvg = reviewsOneAvg;
    }
    if (reviewsTwoAvg != null) {
      _reviewsTwoAvg = reviewsTwoAvg;
    }
    if (reviewsThreeAvg != null) {
      _reviewsThreeAvg = reviewsThreeAvg;
    }
    if (reviewsFourAvg != null) {
      _reviewsFourAvg = reviewsFourAvg;
    }
    if (reviewsFiveAvg != null) {
      _reviewsFiveAvg = reviewsFiveAvg;
    }

    if (choiceOptions != null) {
      _choiceOptions = choiceOptions;
    }
    if (variation != null) {
      _variation = variation;
    }
    if (published != null) {
      _published = published;
    }
    if (unitPrice != null) {
      _unitPrice = unitPrice;
    }
    if (purchasePrice != null) {
      _purchasePrice = purchasePrice;
    }
    if (tax != null) {
      _tax = tax;
    }
    if (taxModel != null) {
      _taxModel = taxModel;
    }
    if (taxType != null) {
      _taxType = taxType;
    }
    if (discount != null) {
      _discount = discount;
    }
    if (discountType != null) {
      _discountType = discountType;
    }
    if (currentStock != null) {
      _currentStock = currentStock;
    }
    if (minimumOrderQty != null) {
      _minimumOrderQty = minimumOrderQty;
    }
    if (details != null) {
      _details = details;
    }
    if (freeShipping != null) {
      _freeShipping = freeShipping;
    }

    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (status != null) {
      _status = status;
    }
    if (featuredStatus != null) {
      _featuredStatus = featuredStatus;
    }
    if (metaTitle != null) {
      _metaTitle = metaTitle;
    }
    if (metaDescription != null) {
      _metaDescription = metaDescription;
    }
    if (metaImage != null) {
      _metaImage = metaImage;
    }
    if (requestStatus != null) {
      _requestStatus = requestStatus;
    }
    if (deniedNote != null) {
      _deniedNote = deniedNote;
    }
    if (shippingCost != null) {
      _shippingCost = shippingCost;
    }
    if (multiplyQty != null) {
      _multiplyQty = multiplyQty;
    }
    if (code != null) {
      _code = code;
    }
    if (reviewsCount != null) {
      _reviewsCount = reviewsCount;
    }
    if (averageReview != null) {
      _averageReview = averageReview;
    }
    if (reviews != null) {
      _reviews = reviews;
    }
    if (seller != null) {
      _seller = seller;
    }
    if (promo != null) {
      _promo = promo;
    }

    if (shortDisc != null) {
      _short_desc = shortDisc;
    }
  }

  int? get id => _id;
  String? get gtin => _gtin;
  String? get length => _length;
  String? get size => _size;
  String? get itemNumber => _itemNumber;
  String? get hsCode => _hsCode;
  String? get color => _color;
  String? get width => _width;
  String? get madeIn => _madeIn;
  String? get weight => _weight;
  String? get space => _space;
  String? get mpn => _mpn;
  String? get height => _height;
  String? get addedBy => _addedBy;
  Map<String, dynamic>? get desc => _desc;
  String? get brand => _brand;
  String? get brandImg => _brandImg;
  bool? get inWishList => _inWishList;
  int? get userId => _userId;
  int? get orderCount => _orderCount;
  int? get reviewsOneCount => _reviewsOneCount;
  int? get reviewsTwoCount => _reviewsTwoCount;
  int? get reviewsThreeCount => _reviewsThreeCount;
  int? get reviewsFourCount => _reviewsFourCount;
  int? get reviewsFiveCount => _reviewsFiveCount;

  double? get reviewsOneAvg => _reviewsOneAvg;
  double? get reviewsTwoAvg => _reviewsTwoAvg;
  double? get reviewsThreeAvg => _reviewsThreeAvg;
  double? get reviewsFourAvg => _reviewsFourAvg;
  double? get reviewsFiveAvg => _reviewsFiveAvg;

  String? get promo => _promo;
  String? get shortDesc => _short_desc;
  String? get name => _name;
  List<SinglePropModel>? get props => _props;
  String? get slug => _slug;
  String? get productType => _productType;
  List<CategoryIds>? get categoryIds => _categoryIds;
  int? get brandId => _brandId;
  List? get wishList => _wishList;
  String? get unit => _unit;
  int? get minQty => _minQty;
  int? get refundable => _refundable;
  String? get digitalProductType => _digitalProductType;
  String? get digitalFileReady => _digitalFileReady;
  List<String>? get images => _images;
  String? get thumbnail => _thumbnail;
  int? get featured => _featured;
  String? get videoProvider => _videoProvider;
  Map<String, dynamic>? get videoUrl => _videoUrl;
  List<Colorss>? get colors => _colors;
  int? get variantProduct => _variantProduct;
  List<int>? get attributes => _attributes;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<Variation>? get variation => _variation;
  int? get published => _published;
  double? get unitPrice => _unitPrice;
  double? get purchasePrice => _purchasePrice;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  String? get taxType => _taxType;
  double? get discount => _discount;
  String? get discountType => _discountType;
  int? get currentStock => _currentStock;
  int? get minimumOrderQty => _minimumOrderQty;
  String? get details => _details;
  int? get freeShipping => _freeShipping;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get status => _status;
  int? get featuredStatus => _featuredStatus;
  String? get metaTitle => _metaTitle;
  String? get metaDescription => _metaDescription;
  String? get metaImage => _metaImage;
  int? get requestStatus => _requestStatus;
  String? get deniedNote => _deniedNote;
  double? get shippingCost => _shippingCost;
  int? get multiplyQty => _multiplyQty;
  String? get code => _code;
  ProductDisplayFor? get displayFor => _displayFor;
  int? get reviewsCount => _reviewsCount;
  String? get averageReview => _averageReview ?? "0.0";
  List<Review>? get reviews => _reviews;
  Seller? get seller => _seller;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    // log('doidid ${json['user_id']}');

    _id = json['id'];
    _addedBy = json['added_by'];
    _brand = json['brand'];
    _userId = json['user_id'];
    _itemNumber = json['item_number'];

    if (json['display_for'] != null) {
      print('display_for =>  ${json['display_for']}');

      _displayFor = getProductDisplayFor(json['display_for']);
    } else {
      _displayFor = ProductDisplayFor.BOTH;
    }
    _orderCount = json['order_count'] ?? 0;
    try{
      if (json['wish_list'] != null) {
        _wishList = json['wish_list'];
      }}catch(e){
      _wishList=[];
    }
    // try{
    //   if (json['reviews'] != null) {
    //     _reviews = json['reviews'];
    //   }
    // }catch(e){
    //   _reviews=[];
    //
    //   print('product reviews error ---> $e');
    //
    // }
    _name = json['name'];
    _brandImg = json['brand_image'];
    _inWishList = json['in_wish_list'];
    _props = json["props"] != null
        ? List.generate(json["props"].length,
            (index) => SinglePropModel.fromJson(json["props"][index]))
        : [];
    if (json['current_stock'] != null) {
      _currentStock = json['current_stock'];
    } else {
      _currentStock = null;
    }
    _desc = json['desc'];
    _slug = json['slug'];
    _productType = json['product_type'];

    if (json['category_ids'] != null) {
      _categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        _categoryIds!.add(CategoryIds.fromJson(v));
      });
    }

    if (json["promo"] != null) {
      _promo = json["promo"];
    }

    if (json["promo_title"] != null ||
        json["promo_title"].toString().isNotEmpty) {
      _short_desc = json["promo_title"];
    }

    if (json["gtin"] != null) {
      _gtin = json["gtin"];
    }
    if (json["mpn"] != null) {
      _mpn = json["mpn"];
    }
    if (json["hs_code"] != null) {
      _hsCode = json["hs_code"];
    }
    if (json["length"] != null) {
      _length = json["length"];
    }
    if (json["width"] != null) {
      _width = json["width"];
    }
    if (json["height"] != null) {
      _height = json["height"];
    }
    if (json["size"] != null) {
      _size = json["size"];
    }
    if (json["space"] != null) {
      _space = json["space"];
    }
    if (json["weight"] != null) {
      _weight = json["weight"];
    }
    if (json["made_in"] != null) {
      _madeIn = json["made_in"];
    }
    if (json["color"] != null) {
      _color = json["color"];
    }
    _brandId = json['brand_id'];
    _unit = json['unit'];
    _minQty = json['min_qty'];
    _refundable = json['refundable'];
    _digitalProductType = json['digital_product_type'];
    _digitalFileReady = json['digital_file_ready'];
    try {
      _images = List<String>.from(json['images']);
    } catch (e) {
      _images = json['images'];
    }
    _thumbnail = json['thumbnail'];
    _featured = json['featured'];
    _videoProvider = json['video_provider'];
    if (json['video_url'] != null) {}
    if (json['colors_formatted'] != null) {
      _colors = <Colorss>[];
      json['colors_formatted'].forEach((v) {
        _colors!.add(Colorss.fromJson(v));
      });
    } else {
      _colors = [];
    }
    if (json['variant_product'] != null) {
      _variantProduct = int.parse(json['variant_product'].toString());
    }

    if (json['choice_options'] != null) {
      _choiceOptions = <ChoiceOptions>[];
      jsonDecode(json['choice_options']).forEach((v) {
        _choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    // print('_variation55 ${json['variation']}');
    if (json['variation'] != null) {
      _variation = <Variation>[];
      jsonDecode(json['variation']).forEach((v) {
        _variation!.add(Variation.fromJson(v));
      });
    }
    _published = json['published'];
    // print('sadasdadadaS${json['pricings']['value']}');
    if (json['pricings'] != null && json['pricings']['value'] != null) {
      _unitPrice = double.tryParse(json['pricings']['value'].toString());
    }
    if (json['purchase_price'] != null) {
      _purchasePrice = double.tryParse(json['purchase_price']);
    }
    _tax = json['tax'] != null ? double.tryParse(json['tax'].toString()) : json['tax'];
    _taxModel = json['tax_model'];
    _taxType = json['tax_type'];
    // print('asdasdsad${json['pricings']['discount_price']}');
    if (json['pricings'] != null &&
        json['pricings']['discount_price'] != null) {
      _discount =
          double.tryParse(json['pricings']['discount_price'].toString());
    } else {
      _discount = 0;
    }
    if (json['pricings'] != null && json['pricings']['discount_type'] != null) {
      _discountType = json['pricings']['discount_type'];
    }

    if (json['minimum_order_qty'] != null) {
      _minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
    } else {
      _minimumOrderQty = 1;
    }

    _details = json['short_desc'];
    _reviewsOneCount = json['reviews_one_count'];
    _reviewsTwoCount = json['reviews_two_count'];
    _reviewsThreeCount = json['reviews_three_count'];
    _reviewsFourCount = json['reviews_four_count'];
    _reviewsFiveCount = json['reviews_five_count'];

    _reviewsOneAvg =
        double.tryParse(json['reviews_one_avg_status'].toString()) ?? 0;
    _reviewsTwoAvg =
        double.tryParse(json['reviews_two_avg_status'].toString()) ?? 0;
    _reviewsThreeAvg =
        double.tryParse(json['reviews_three_avg_status'].toString()) ?? 0;
    _reviewsFiveAvg =
        double.tryParse(json['reviews_five_avg_status'].toString()) ?? 0;
    _reviewsFourAvg =
        double.tryParse(json['reviews_four_avg_status'].toString()) ?? 0;

    _freeShipping = json['free_shipping'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
    _featuredStatus = json['featured_status'];
    _metaTitle = json['meta_title'];
    _metaDescription = json['meta_description'];
    _metaImage = json['meta_image'];

    _deniedNote = json['denied_note'];

    _multiplyQty = json['multiply_qty'];
    _code = json['code'];
    _reviewsCount = json['reviews_count'] != null
        ? int.parse(json['reviews_count'].toString())
        : 0;
    _averageReview = json['average_review'].toString();
    if (json['reviews'] != null) {
      _reviews=  List<Review>.from(json["reviews"].map((x) {
        return Review.fromJson(x);
      }));

    }else{
      _reviews=[];
    }
    _seller =
    json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['added_by'] = _addedBy;
    data['user_id'] = _userId;
    data['name'] = _name;
    data['slug'] = _slug;
    data['desc'] = _desc;
    data['product_type'] = _productType;
    if (_categoryIds != null) {
      data['category_ids'] = _categoryIds!.map((v) => v.toJson()).toList();
    }
    data['brand_id'] = _brandId;
    data['props'] = _props;
    data['unit'] = _unit;
    data['min_qty'] = _minQty;
    data['refundable'] = _refundable;
    data['digital_product_type'] = _digitalProductType;
    data['digital_file_ready'] = _digitalFileReady;
    data['images']["sa"] = _images;
    data['thumbnail'] = _thumbnail;
    data['featured'] = _featured;
    data['video_provider'] = _videoProvider;
    data['video_url'] = _videoUrl;
    if (_colors != null) {
      // data['colors_formatted'] = this.Colorss.map((v) => v.toJson()).toList();
    }
    data['variant_product'] = _variantProduct;
    data['attributes'] = _attributes;
    if (_choiceOptions != null) {
      data['choice_options'] =
          _choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (_variation != null) {
      data['variation'] = _variation!.map((v) => v.toJson()).toList();
    }
    data['published'] = _published;
    data['unit_price'] = _unitPrice;
    data['purchase_price'] = _purchasePrice;
    data['tax'] = _tax;
    data['tax_model'] = _taxModel;
    data['tax_type'] = _taxType;
    data['discount'] = _discount;
    data['discount_type'] = _discountType;
    data['current_stock'] = _currentStock;
    data['minimum_order_qty'] = _minimumOrderQty;
    data['promo_title'] = _details;
    data['free_shipping'] = _freeShipping;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['status'] = _status;
    data['featured_status'] = _featuredStatus;
    data['meta_title'] = _metaTitle;
    data['meta_description'] = _metaDescription;
    data['meta_image'] = _metaImage;
    data['request_status'] = _requestStatus;
    data['denied_note'] = _deniedNote;
    data['shipping_cost'] = _shippingCost;
    data['multiply_qty'] = _multiplyQty;
    data['code'] = _code;
    data['reviews_count'] = _reviewsCount;
    data['average_review'] = _averageReview;
    if (_reviews != null) {
      // data['reviews'] = _reviews!.map((v) => v.toJson()).toList();
    }
    if (_seller != null) {
      data['seller'] = _seller!.toJson();
    }

    return data;
  }
}

class SinglePropModel {
  String? _property;
  String? _value;
  String? get property => _property;
  String? get value => _value;

  SinglePropModel({String? property, String? value}) {
    if (property != null) {
      _property = property;
    }
    if (value != null) {
      _value = value;
    }
  }
  SinglePropModel.fromJson(Map<String, dynamic> json) {
    _property = json['property'];
    _value = json['value'];
  }
}

class CategoryIds {
  String? _id;
  int? _position;

  CategoryIds({String? id, int? position}) {
    if (id != null) {
      _id = id;
    }
    if (position != null) {
      _position = position;
    }
  }

  String? get id => _id;
  int? get position => _position;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['position'] = _position;
    return data;
  }
}

class Colorss {
  String? _name;
  String? _code;

  Colorss({String? name, String? code}) {
    if (name != null) {
      _name = name;
    }
    if (code != null) {
      _code = code;
    }
  }

  String? get name => _name;
  String? get code => _code;

  Colorss.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['code'] = _code;
    return data;
  }
}

class Review {
  final int id;
  final int productId;
  final int customerId;
  final dynamic deliveryManId;
  final dynamic orderId;
  final String comment;
  final String attachment;
  final int rating;
  final int status;
  final int isSaved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int deleted;
  final List<String> attachmentUrl;
  final dynamic customerName;
  final dynamic customerImageUrl;
  final dynamic customer;

  Review({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.deliveryManId,
    required this.orderId,
    required this.comment,
    required this.attachment,
    required this.rating,
    required this.status,
    required this.isSaved,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.attachmentUrl,
    required this.customerName,
    required this.customerImageUrl,
    required this.customer,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    productId: json["product_id"],
    customerId: json["customer_id"],
    deliveryManId: json["delivery_man_id"],
    orderId: json["order_id"],
    comment: json["comment"],
    attachment: json["attachment"],
    rating: json["rating"],
    status: json["status"],
    isSaved: json["is_saved"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deleted: json["deleted"],
    attachmentUrl: List<String>.from(json["attachment_url"].map((x) => x)),
    customerName: json["customer_name"],
    customerImageUrl: json["customer_image_url"],
    customer: json["customer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "customer_id": customerId,
    "delivery_man_id": deliveryManId,
    "order_id": orderId,
    "comment": comment,
    "attachment": attachment,
    "rating": rating,
    "status": status,
    "is_saved": isSaved,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted": deleted,
    "attachment_url": List<dynamic>.from(attachmentUrl.map((x) => x)),
    "customer_name": customerName,
    "customer_image_url": customerImageUrl,
    "customer": customer,
  };
}

class Customer {
  int? _id;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _image;
  String? _email;

  Customer({
    int? id,
    String? fName,
    String? lName,
    String? phone,
    String? image,
    String? email,
  }) {
    if (id != null) {
      _id = id;
    }
    if (fName != null) {
      _fName = fName;
    }
    if (lName != null) {
      _lName = lName;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (image != null) {
      _image = image;
    }
    if (email != null) {
      _email = email;
    }
  }

  int? get id => _id;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get image => _image;
  String? get email => _email;

  Customer.fromJson(Map<String, dynamic> json) {
    print('fromJsonsci ${json['customer_name']}');
    _id = json['id'];
    _fName = json['customer_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['phone'] = _phone;
    data['image'] = _image;
    data['email'] = _email;

    return data;
  }
}
class ChoiceOptions {
  String? _name;
  String? _title;
  List<String>? _options;

  ChoiceOptions({String? name, String? title, List<String>? options}) {
    _name = name;
    _title = title;
    _options = options;
  }

  String? get name => _name;
  String? get title => _title;
  List<String>? get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    if (json['options'] != null) {
      _options = json['options'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['title'] = _title;
    data['options'] = _options;
    return data;
  }
}
enum ProductDisplayFor { BOTH, PURCHASE, ADD }

ProductDisplayFor getProductDisplayFor(String displayFor) {
  if (displayFor == 'both') {
    return ProductDisplayFor.BOTH;
  } else if (displayFor == 'purchase') {
    return ProductDisplayFor.PURCHASE;
  } else if (displayFor == 'add') {
    return ProductDisplayFor.ADD;
  }
  return ProductDisplayFor.BOTH;
}

class Variation {
  String? _type;
  double? _price;
  String? _sku;
  int? _qty;

  Variation({String? type, double? price, String? sku, int? qty}) {
    _type = type;
    _price = price;
    _sku = sku;
    _qty = qty;
  }

  String? get type => _type;
  double? get price => _price;
  String? get sku => _sku;
  int? get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    if (json['type'] != null) {
      _type = json['type'];
    }
    if (json['price'] != null) {
      _price = json['price'].toDouble();
    }
    if (json['sku'] != null) {
      _sku = json['sku'];
    }
    if (json['qty'] != null) {
      _qty = json['qty'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = _type;
    data['price'] = _price;
    data['sku'] = _sku;
    data['qty'] = _qty;
    return data;
  }
}
class Seller {
  int? _id;
  String? _companyName;
  String? _lName;
  String? _phone;
  String? _image;
  Shop? _shop;

  Seller(
      {int? id,
        String? companyName,
        String? lName,
        String? phone,
        String? image,
        Shop? shop}) {
    _id = id;
    _companyName = companyName;
    _lName = lName;
    _phone = phone;
    _image = image;
    _shop = shop;
  }

  int? get id => _id;
  String? get companyName => _companyName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get image => _image;
  Shop? get shop => _shop;

  Seller.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _companyName = json['company_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['company_name']['value'] = _companyName;
    data['l_name'] = _lName;
    data['phone'] = _phone;
    data['image'] = _image;
    data['shop'] = _shop!.toJson();
    return data;
  }
}

class Shop {
  int? _id;
  int? _sellerId;
  String? _name;
  String? _address;
  String? _contact;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _banner;
  int? _temporaryClose;
  String? _vacationEndDate;
  String? _vacationStartDate;
  int? _vacationStatus;

  Shop(
      {int? id,
        int? sellerId,
        String? name,
        String? address,
        String? contact,
        String? image,
        String? createdAt,
        String? updatedAt,
        String? banner,
        int? temporaryClose,
        String? vacationEndDate,
        String? vacationStartDate,
        int? vacationStatus}) {
    _id = id;
    _sellerId = sellerId;
    _name = name;
    _address = address;
    _contact = contact;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _banner = banner;
    _temporaryClose = temporaryClose;
    _vacationEndDate = vacationEndDate;
    _vacationStartDate = vacationStartDate;
    _vacationStatus = vacationStatus;
  }

  int? get id => _id;
  int? get sellerId => _sellerId;
  String? get name => _name;
  String? get address => _address;
  String? get contact => _contact;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get banner => _banner;
  int? get temporaryClose => _temporaryClose;
  String? get vacationEndDate => _vacationEndDate;
  String? get vacationStartDate => _vacationStartDate;
  int? get vacationStatus => _vacationStatus;

  Shop.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sellerId = int.tryParse(json['seller_id'].toString()) ?? 0;
    _name = json['name'];
    _address = json['address'];
    _contact = json['contact'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _banner = json['banner'];
    _temporaryClose = json['temporary_close'] != null
        ? int.parse(json['temporary_close'].toString())
        : 0;
    _vacationEndDate = json['vacation_end_date'];
    _vacationStartDate = json['vacation_start_date'];
    _vacationStatus = json['vacation_status'] != null
        ? int.parse(json['vacation_status'].toString())
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['seller_id'] = _sellerId;
    data['name'] = _name;
    data['address'] = _address;
    data['contact'] = _contact;
    data['image'] = _image;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['banner'] = _banner;
    data['temporary_close'] = _temporaryClose;
    data['vacation_end_date'] = _vacationEndDate;
    data['vacation_start_date'] = _vacationEndDate;
    data['vacation_status'] = _vacationStatus;

    return data;
  }
}