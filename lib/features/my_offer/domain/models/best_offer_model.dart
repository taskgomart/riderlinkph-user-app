

class BestOfferModel {
  String? responseCode;
  String? message;
  int? totalSize;
  String? limit;
  String? offset;
  List<OfferModel>? data;


  BestOfferModel(
      {this.responseCode,
        this.message,
        this.totalSize,
        this.limit,
        this.offset,
        this.data,
      });

  BestOfferModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    totalSize = int.tryParse(json['total_size'].toString());
    limit = json['limit'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = <OfferModel>[];
      json['data'].forEach((v) {
        data!.add(OfferModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class OfferModel {
  String? id;
  String? title;
  String? shortDescription;
  String? termsConditions;
  String? image;
  double? discountAmount;
  List<String>? zoneDiscount;
  List<String>? customerLevelDiscount;
  List<String>? customerDiscount;
  List<String>? moduleDiscount;
  String? discountAmountType;
  double? maxDiscountAmount;
  double? minTripAmount;
  int? limit;
  String? startDate;
  String? endDate;
  bool? isActive;
  String? createdAt;

  OfferModel(
      {this.id,
        this.title,
        this.shortDescription,
        this.termsConditions,
        this.image,
        this.discountAmount,
        this.zoneDiscount,
        this.customerLevelDiscount,
        this.customerDiscount,
        this.moduleDiscount,
        this.discountAmountType,
        this.maxDiscountAmount,
        this.minTripAmount,
        this.limit,
        this.startDate,
        this.endDate,
        this.isActive,
        this.createdAt});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    termsConditions = json['terms_conditions'];
    image = json['image'];
    discountAmount = double.tryParse(json['discount_amount'].toString());
    zoneDiscount = json['zone_discount'].cast<String>();
    customerLevelDiscount = json['customer_level_discount'].cast<String>();
    customerDiscount = json['customer_discount'].cast<String>();
    moduleDiscount = json['module_discount'].cast<String>();
    discountAmountType = json['discount_amount_type'];
    maxDiscountAmount = double.tryParse(json['max_discount_amount'].toString());
    minTripAmount = double.tryParse(json['min_trip_amount'].toString());
    limit = int.tryParse(json['limit'].toString());
    startDate = json['start_date'];
    endDate = json['end_date'];
    isActive = json['is_active'] != null ? (bool.tryParse(json['is_active'].toString()) ?? (json['is_active'].toString() == '1')) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['terms_conditions'] = termsConditions;
    data['image'] = image;
    data['discount_amount'] = discountAmount;
    data['zone_discount'] = zoneDiscount;
    data['customer_level_discount'] = customerLevelDiscount;
    data['customer_discount'] = customerDiscount;
    data['module_discount'] = moduleDiscount;
    data['discount_amount_type'] = discountAmountType;
    data['max_discount_amount'] = maxDiscountAmount;
    data['min_trip_amount'] = minTripAmount;
    data['limit'] = limit;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}