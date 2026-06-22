
class FinalFareModel {
  String? responseCode;
  String? message;
  FinalFare? data;


  FinalFareModel(
      {this.responseCode,
        this.message,
        this.data,
        });

  FinalFareModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    data = json['data'] != null ? FinalFare.fromJson(json['data']) : null;

  }

}

class FinalFare {
  String? id;
  String? refId;
  double? estimatedFare;
  double? actualFare;
  double? estimatedDistance;
  double? paidFare;
  double? actualDistance;
  String? paymentStatus;
  String? paymentMethod;
  double? couponAmount;
  double? discountAmount;
  String? note;
  String? otp;
  int? riseRequestCount;
  String? type;
  String? createdAt;
  String? entrance;
  String? encodedPolyline;
  String? currentStatus;
  bool? isPaused;
  Coupon? coupon;
  Discount? discount;
  String? screenshot;
  double? distanceWiseFare;
  PickupCoordinates? pickupCoordinates;
  String? pickupAddress;
  PickupCoordinates? destinationCoordinates;
  String? destinationAddress;
  PickupCoordinates? startCoordinates;
  PickupCoordinates? dropCoordinates;
  PickupCoordinates? customerRequestCoordinates;
  String? intermediateAddresses;
  double? idleFee;
  double? delayFee;
  double? cancellationFee;
  String? cancelledBy;
  double? vatTax;
  double? tips;
  double? waitingTime;
  double? delayTime;
  double? idleTime;
  double? actualTime;
  double? estimatedTime;

  FinalFare(
      {this.id,
        this.refId,
        this.estimatedFare,
        this.actualFare,
        this.estimatedDistance,
        this.paidFare,
        this.actualDistance,
        this.paymentStatus,
        this.paymentMethod,
        this.couponAmount,
        this.discountAmount,
        this.note,
        this.otp,
        this.riseRequestCount,
        this.type,
        this.createdAt,
        this.entrance,
        this.encodedPolyline,
        this.currentStatus,
        this.isPaused,
        this.coupon,
        this.discount,
        this.screenshot,
        this.distanceWiseFare,
        this.pickupCoordinates,
        this.pickupAddress,
        this.destinationCoordinates,
        this.destinationAddress,
        this.startCoordinates,
        this.dropCoordinates,
        this.customerRequestCoordinates,
        this.intermediateAddresses,
        this.idleFee,
        this.delayFee,
        this.cancellationFee,
        this.cancelledBy,
        this.vatTax,
        this.tips,
        this.waitingTime,
        this.delayTime,
        this.idleTime,
        this.actualTime,
        this.estimatedTime});

  FinalFare.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    estimatedFare = double.tryParse(json['estimated_fare'].toString());
    actualFare = double.tryParse(json['actual_fare'].toString());
    estimatedDistance = double.tryParse(json['estimated_distance'].toString());
    paidFare = double.tryParse(json['paid_fare'].toString());
    actualDistance = double.tryParse(json['actual_distance'].toString());
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    couponAmount = double.tryParse(json['coupon_amount'].toString());
    discountAmount = double.tryParse(json['discount_amount'].toString());
    note = json['note'];
    otp = json['otp'];
    riseRequestCount = int.tryParse(json['rise_request_count'].toString());
    type = json['type'];
    createdAt = json['created_at'];
    entrance = json['entrance'];
    encodedPolyline = json['encoded_polyline'];
    currentStatus = json['current_status'];
    isPaused = json['is_paused'] != null ? (bool.tryParse(json['is_paused'].toString()) ?? (json['is_paused'].toString() == '1')) : null;
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
    discount = json['discount'] != null ? Discount.fromJson(json['discount']) : null;
    screenshot = json['screenshot'];
    distanceWiseFare = double.tryParse(json['distance_wise_fare'].toString());
    pickupCoordinates = json['pickup_coordinates'] != null
        ? PickupCoordinates.fromJson(json['pickup_coordinates'])
        : null;
    pickupAddress = json['pickup_address'];
    destinationCoordinates = json['destination_coordinates'] != null
        ? PickupCoordinates.fromJson(json['destination_coordinates'])
        : null;
    destinationAddress = json['destination_address'];
    startCoordinates = json['start_coordinates'] != null
        ? PickupCoordinates.fromJson(json['start_coordinates'])
        : null;
    dropCoordinates = json['drop_coordinates'] != null
        ? PickupCoordinates.fromJson(json['drop_coordinates'])
        : null;

    customerRequestCoordinates = json['customer_request_coordinates'] != null
        ? PickupCoordinates.fromJson(json['customer_request_coordinates'])
        : null;
    intermediateAddresses = json['intermediate_addresses'];
    idleFee = double.tryParse(json['idle_fee'].toString());
    delayFee = double.tryParse(json['delay_fee'].toString());
    cancellationFee = double.tryParse(json['cancellation_fee'].toString());
    cancelledBy = json['cancelled_by'];
    vatTax = double.tryParse(json['vat_tax'].toString());
    tips = double.tryParse(json['tips'].toString());
    waitingTime = double.tryParse(json['waiting_time'].toString());
    delayTime = double.tryParse(json['delay_time'].toString());
    idleTime = double.tryParse(json['idle_time'].toString());
    actualTime = double.tryParse(json['actual_time'].toString());
    estimatedTime = double.tryParse(json['estimated_time'].toString());
  }

}


class Coupon {
  String? id;
  String? name;
  String? description;
  String? customerId;
  String? minTripAmount;
  String? maxCouponAmount;
  String? coupon;
  String? amountType;
  String? couponType;
  String? couponCode;
  int? limit;
  String? startDate;
  String? endDate;
  String? rules;
  int? isActive;
  String? createdAt;

  Coupon(
      {this.id,
        this.name,
        this.description,
        this.customerId,
        this.minTripAmount,
        this.maxCouponAmount,
        this.coupon,
        this.amountType,
        this.couponType,
        this.couponCode,
        this.limit,
        this.startDate,
        this.endDate,
        this.rules,
        this.isActive,
        this.createdAt});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    customerId = json['customer_id'];
    minTripAmount = json['min_trip_amount'];
    maxCouponAmount = json['max_coupon_amount'];
    coupon = json['coupon'];
    amountType = json['amount_type'];
    couponType = json['coupon_type'];
    couponCode = json['coupon_code'];
    limit = int.tryParse(json['limit'].toString());
    startDate = json['start_date'];
    endDate = json['end_date'];
    rules = json['rules'];
    isActive = int.tryParse(json['is_active'].toString());
    createdAt = json['created_at'];
  }

}


class PickupCoordinates {
  String? type;
  List<double>? coordinates;

  PickupCoordinates({this.type, this.coordinates});

  PickupCoordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

}

class Discount {
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

  Discount(
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

  Discount.fromJson(Map<String, dynamic> json) {
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