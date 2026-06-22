class ReferralDetailsModel {
  String? responseCode;
  String? message;
  int? totalSize;
  int? limit;
  int? offset;
  Data? data;
  List<String>? errors;

  ReferralDetailsModel(
      {this.responseCode,
        this.message,
        this.totalSize,
        this.limit,
        this.offset,
        this.data,
        this.errors});

  ReferralDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    totalSize = int.tryParse(json['total_size'].toString());
    limit = int.tryParse(json['limit'].toString());
    offset = int.tryParse(json['offset'].toString());
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    errors = json['errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = errors;
    return data;
  }
}

class Data {
  String? referralCode;
  double? shareCodeEarning;
  bool? firstRideDiscountStatus;
  double? discountAmount;
  String? discountAmountType;
  int? discountValidity;
  String? discountValidityType;

  Data(
      {this.referralCode,
        this.shareCodeEarning,
        this.firstRideDiscountStatus,
        this.discountAmount,
        this.discountAmountType,
        this.discountValidity,
        this.discountValidityType});

  Data.fromJson(Map<String, dynamic> json) {
    referralCode = json['referral_code'];
    shareCodeEarning = double.tryParse(json['share_code_earning'].toString());
    firstRideDiscountStatus = json['first_ride_discount_status'] != null ? (bool.tryParse(json['first_ride_discount_status'].toString()) ?? (json['first_ride_discount_status'].toString() == '1')) : null;
    discountAmount = double.tryParse(json['discount_amount'].toString());
    discountAmountType = json['discount_amount_type'];
    discountValidity = int.tryParse(json['discount_validity'].toString());
    discountValidityType = json['discount_validity_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referral_code'] = referralCode;
    data['share_code_earning'] = shareCodeEarning;
    data['first_ride_discount_status'] = firstRideDiscountStatus;
    data['discount_amount'] = discountAmount;
    data['discount_amount_type'] = discountAmountType;
    data['discount_validity'] = discountValidity;
    data['discount_validity_type'] = discountValidityType;
    return data;
  }
}
