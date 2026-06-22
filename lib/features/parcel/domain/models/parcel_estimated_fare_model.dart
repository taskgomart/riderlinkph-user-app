class ParcelEstimatedFare {
  String? responseCode;
  ParcelFare? data;


  ParcelEstimatedFare(
      {this.responseCode,
        this.data});

  ParcelEstimatedFare.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    data = json['data'] != null ? ParcelFare.fromJson(json['data']) : null;

  }

}

class ParcelFare {
  String? id;
  String? zoneId;
  double? baseFare;
  double? baseFarePerKm;
  List<Fare>? fare;
  double? estimatedDistance;
  String? estimatedDuration;
  double? estimatedFare;
  double? discountFare;
  double? discountAmount;
  String? requestType;
  String? encodedPolyline;
  bool? couponApplicable;
  double? returnFee;
  double? cancellationFee;
  double? extraEstimatedFare;
  double? extraDiscountFare;
  double? extraDiscountAmount;
  double? extraReturnFee;
  double? extraCancellationFee;
  double? extraFareAmount;
  double? extraFareFee;
  String? extraFareReason;
  double? surgeMultiplier;

  ParcelFare(
      {this.id,
        this.zoneId,
        this.baseFare,
        this.baseFarePerKm,
        this.fare,
        this.estimatedDistance,
        this.estimatedDuration,
        this.estimatedFare,
        this.discountAmount,
        this.discountFare,
        this.requestType,
        this.couponApplicable,
        this.returnFee,
        this.cancellationFee,
        this.encodedPolyline,
        this.extraCancellationFee,
        this.extraDiscountAmount,
        this.extraDiscountFare,
        this.extraEstimatedFare,
        this.extraFareAmount,
        this.extraFareFee,
        this.extraFareReason,
        this.extraReturnFee,
        this.surgeMultiplier
      });

  ParcelFare.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneId = json['zone_id'];
    baseFare = double.tryParse(json['base_fare'].toString());
    baseFarePerKm = double.tryParse(json['base_fare_per_km'].toString());
    if (json['fare'] != null) {
      fare = <Fare>[];
      json['fare'].forEach((v) {
        fare!.add(Fare.fromJson(v));
      });
    }
    estimatedDistance = double.tryParse(json['estimated_distance'].toString());
    estimatedDuration = json['estimated_duration'].toString();
    estimatedFare = double.tryParse(json['estimated_fare'].toString());
    discountFare = double.tryParse(json['discount_fare'].toString());
    discountAmount = double.tryParse(json['discount_amount'].toString());
    couponApplicable = json['coupon_applicable'] != null ? (bool.tryParse(json['coupon_applicable'].toString()) ?? (json['coupon_applicable'].toString() == '1')) : null;
    requestType = json['request type'];
    encodedPolyline = json['encoded_polyline'];
    returnFee = double.tryParse(json['return_fee'].toString());
    cancellationFee = double.tryParse(json['cancellation_fee'].toString());
    extraEstimatedFare = double.tryParse(json['extra_estimated_fare'].toString());
    extraDiscountFare = double.tryParse(json['extra_discount_fare'].toString());
    extraDiscountAmount = double.tryParse(json['extra_discount_amount'].toString());
    extraReturnFee = double.tryParse(json['extra_return_fee'].toString());
    extraCancellationFee = double.tryParse(json['extra_cancellation_fee'].toString());
    extraFareAmount = double.tryParse(json['extra_fare_amount'].toString());
    extraFareFee = double.tryParse(json['extra_fare_fee'].toString());
    extraFareReason = json['extra_fare_reason'];
    surgeMultiplier = double.tryParse(json['surge_multiplier'].toString());
  }

}

class Fare {
  int? id;
  String? parcelFareId;
  String? parcelWeightId;
  String? parcelCategoryId;
  double? fare;
  String? zoneId;
  String? createdAt;
  String? updatedAt;

  Fare(
      {this.id,
        this.parcelFareId,
        this.parcelWeightId,
        this.parcelCategoryId,
        this.fare,
        this.zoneId,
        this.createdAt,
        this.updatedAt});

  Fare.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    parcelFareId = json['parcel_fare_id'];
    parcelWeightId = json['parcel_weight_id'];
    parcelCategoryId = json['parcel_category_id'];
    fare = double.tryParse(json['fare_per_km'].toString());
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
