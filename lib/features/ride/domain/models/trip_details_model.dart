import 'package:ride_sharing_user_app/features/auth/domain/enums/refund_status_enum.dart';

class TripDetailsModel {
  TripDetails? data;

  TripDetailsModel(
      {
        this.data,
      });

  TripDetailsModel.fromJson(Map<String, dynamic> json) {

    data = json['data'] != null ? TripDetails.fromJson(json['data']) : null;

  }

}

class TripDetails {
  String? id;
  String? refId;
  Driver? driver;
  Vehicle? vehicle;
  VehicleCategory? vehicleCategory;
  double? estimatedFare;
  String? orgEstFare;
  String? estimatedTime;
  double? estimatedDistance;
  double? actualFare;
  double? discountActualFare;
  String? actualTime;
  String? actualDistance;
  String? waitingTime;
  String? idleTime;
  String? waitingFare;
  double? idleFee;
  double? delayFee;
  double? cancellationFee;
  double? distanceWiseFare;
  String? cancelledBy;
  double? vatTax;
  double? tips;
  String? additionalCharge;
  PickupCoordinates? pickupCoordinates;
  String? pickupAddress;
  PickupCoordinates? destinationCoordinates;
  String? destinationAddress;
  PickupCoordinates? customerRequestCoordinates;
  String? intermediateCoordinates;
  String? paymentMethod;
  double? couponAmount;
  double? discountAmount;
  String? note;
  String? totalFare;
  String? otp;
  int? riseRequestCount;
  String? type;
  String? createdAt;
  String? entrance;
  String? intermediateAddresses;
  String? encodedPolyline;
  String? customerAvgRating;
  String? driverAvgRating;
  String? currentStatus;
  double? paidFare;
  bool? isPaused;
  ParcelInformation? parcelInformation;
  String? paymentStatus;
  bool? isLoading;
  bool? isReviewed;
  double? returnFee;
  double? dueAmount;
  String? returnTime;
  String? parcelCompleteTime;
  String? rideCompleteTime;
  String? rideStartTime;
  String? parcelStartTime;
  ParcelRefund? parcelRefund;
  DriverSafetyAlert? driverSafetyAlert;
  DriverSafetyAlert? customerSafetyAlert;
  String? scheduledAt;
  String? cancellationReason;
  String? pickupNote;
  String? customerLocationUrl;
  List<String>? pickupProofImages;
  List<String>? deliveryProofImages;

  TripDetails(
      {this.id,
        this.refId,
        this.driver,
        this.vehicle,
        this.vehicleCategory,
        this.estimatedFare,
        this.orgEstFare,
        this.estimatedTime,
        this.estimatedDistance,
        this.actualFare,
        this.actualTime,
        this.actualDistance,
        this.waitingTime,
        this.idleTime,
        this.waitingFare,
        this.idleFee,
        this.delayFee,
        this.cancellationFee,
        this.distanceWiseFare,
        this.cancelledBy,
        this.vatTax,
        this.tips,
        this.additionalCharge,
        this.pickupCoordinates,
        this.pickupAddress,
        this.destinationCoordinates,
        this.destinationAddress,
        this.customerRequestCoordinates,
        this.paymentMethod,
        this.couponAmount,
        this.discountAmount,
        this.discountActualFare,
        this.note,
        this.totalFare,
        this.otp,
        this.riseRequestCount,
        this.type,
        this.createdAt,
        this.entrance,
        this.intermediateAddresses,
        this.encodedPolyline,
        this.customerAvgRating,
        this.driverAvgRating,
        this.currentStatus,
        this.paidFare,
        this.isPaused,
        this.parcelInformation,
        this.paymentStatus,
        this.isLoading,
        this.isReviewed,
        this.returnFee,
        this.dueAmount,
        this.returnTime,
        this.parcelCompleteTime,
        this.parcelRefund,
        this.driverSafetyAlert,
        this.customerSafetyAlert,
        this.rideCompleteTime,
        this.parcelStartTime,
        this.rideStartTime,
        this.scheduledAt,
        this.intermediateCoordinates,
        this.cancellationReason,
        this.customerLocationUrl,
        this.pickupNote,
        this.pickupProofImages,
        this.deliveryProofImages,
      });

  TripDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'].toString();
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
    vehicleCategory = json['vehicle_category'] != null ? VehicleCategory.fromJson(json['vehicle_category']) : null;
    estimatedFare = double.tryParse(json['estimated_fare'].toString());
    orgEstFare = json['org_est_fare'].toString();
    estimatedTime = json['estimated_time'].toString();
    estimatedDistance = double.tryParse(json['estimated_distance'].toString());
    actualFare = double.tryParse(json['actual_fare'].toString());
    discountActualFare = double.tryParse(json['discount_actual_fare'].toString());
    actualTime = json['actual_time'].toString();
    actualDistance = json['actual_distance'].toString();
    waitingTime = json['waiting_time'].toString();
    idleTime = json['idle_time'].toString();
    waitingFare = json['waiting_fare'].toString();
    if(json['idle_fee'] != null){
      idleFee = double.tryParse(json['idle_fee'].toString());
    }
    if(json['delay_fee'] != null){
      delayFee = double.tryParse(json['delay_fee'].toString());
    }
    if(json['cancellation_fee'] != null){
      cancellationFee = double.tryParse(json['cancellation_fee'].toString());
    }
    if(json['distance_wise_fare'] != null){
      distanceWiseFare = double.tryParse(json['distance_wise_fare'].toString());
    }
    if(json['return_fee'] != null){
      returnFee = double.tryParse(json['return_fee'].toString());
    }
    dueAmount = double.tryParse(json['due_amount'].toString());

    cancelledBy = json['cancelled_by'];
    if(json['vat_tax'] != null){
      vatTax = double.tryParse(json['vat_tax'].toString());
    }

    if(json['tips'] != null){
      tips = double.tryParse(json['tips'].toString());
    }
    additionalCharge = json['additional_charge'].toString();
    pickupCoordinates = json['pickup_coordinates'] != null ? PickupCoordinates.fromJson(json['pickup_coordinates']) : null;
    pickupAddress = json['pickup_address'];
    destinationCoordinates = json['destination_coordinates'] != null ? PickupCoordinates.fromJson(json['destination_coordinates']) : null;
    destinationAddress = json['destination_address'];
    customerRequestCoordinates = json['customer_request_coordinates'] != null ? PickupCoordinates.fromJson(json['customer_request_coordinates']) : null;
    intermediateCoordinates = json['intermediate_coordinates'];

    paymentMethod = json['payment_method'];
    if(json['coupon_amount'] != null){
      try{
        couponAmount = double.tryParse(json['coupon_amount'].toString());
      }catch(e){
        couponAmount = double.tryParse(json['coupon_amount'].toString());
      }
    }

    discountAmount = double.tryParse(json['discount_amount'].toString());
    note = json['note'];
    totalFare = json['total_fare'].toString();
    otp = json['otp'];
    riseRequestCount = int.tryParse(json['rise_request_count'].toString());
    type = json['type'];
    createdAt = json['created_at'];
    entrance = json['entrance'];
    intermediateAddresses = json['intermediate_addresses'];
    encodedPolyline = json['encoded_polyline'];
    customerAvgRating = json['customer_avg_rating'];
    driverAvgRating = json['driver_avg_rating'];
    currentStatus = json['current_status'];
    if(json['paid_fare'] != null){
      try{
        paidFare = double.tryParse(json['paid_fare'].toString());
      }catch(e){
        paidFare = double.tryParse(json['paid_fare'].toString());
      }
    }

    parcelRefund = json['parcel_refund'] != null
        ?  ParcelRefund.fromJson(json['parcel_refund'])
        : null;

    isPaused = json['is_paused'] != null ? (bool.tryParse(json['is_paused'].toString()) ?? (json['is_paused'].toString() == '1')) : null;
    parcelInformation = json['parcel_information'] != null ? ParcelInformation.fromJson(json['parcel_information']) : null;
    paymentStatus = json['payment_status'];
    isLoading = false;
    isReviewed = json['driver_review'] != null ? (bool.tryParse(json['driver_review'].toString()) ?? (json['driver_review'].toString() == '1')) : null;
    returnTime = json['return_time'];
    parcelCompleteTime = json['parcel_complete_time'];
    rideCompleteTime = json['ride_complete_time'];
    rideStartTime = json['ride_start_time'];
    parcelStartTime = json['parcel_start_time'];
    driverSafetyAlert = json['driver_safety_alert'] != null ? DriverSafetyAlert.fromJson(json['driver_safety_alert']) : null;
    customerSafetyAlert = json['customer_safety_alert'] != null ? DriverSafetyAlert.fromJson(json['customer_safety_alert']) : null;
    scheduledAt = json['scheduled_at'];
    cancellationReason = json['cancellation_reason'];
    customerLocationUrl = json['customer_location_url'];
    pickupNote = json['pickup_note'];
    pickupProofImages = json['pickup_proof_images']?.cast<String>();
    deliveryProofImages = json['delivery_proof_images']?.cast<String>();
  }

}

class Driver {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  String? profileImage;
  Vehicle? vehicle;

  Driver(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.profileImage,
        this.vehicle
     });

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    profileImage = json['profile_image'];
    vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;


  }

}

class Vehicle {
  Model? model;
  String? licencePlateNumber;
  String? licenceExpireDate;
  String? vinNumber;
  String? transmission;
  String? fuelType;
  String? ownership;
  List<String>? documents;
  int? isActive;
  String? createdAt;

  Vehicle(
      {this.model,
        this.licencePlateNumber,
        this.licenceExpireDate,
        this.vinNumber,
        this.transmission,
        this.fuelType,
        this.ownership,
        this.documents,
        this.isActive,
        this.createdAt});

  Vehicle.fromJson(Map<String, dynamic> json) {
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    licencePlateNumber = json['licence_plate_number'];
    licenceExpireDate = json['licence_expire_date'];
    vinNumber = json['vin_number'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    ownership = json['ownership'];
    documents = json['documents'].cast<String>();
    isActive = int.tryParse(json['is_active'].toString());
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.toJson();
    }
    data['licence_plate_number'] = licencePlateNumber;
    data['licence_expire_date'] = licenceExpireDate;
    data['vin_number'] = vinNumber;
    data['transmission'] = transmission;
    data['fuel_type'] = fuelType;
    data['ownership'] = ownership;
    data['documents'] = documents;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}

class Model {
  String? id;
  String? name;
  int? seatCapacity;
  int? maximumWeight;
  int? hatchBagCapacity;
  String? engine;
  String? description;
  String? image;
  int? isActive;
  String? createdAt;

  Model(
      {this.id,
        this.name,
        this.seatCapacity,
        this.maximumWeight,
        this.hatchBagCapacity,
        this.engine,
        this.description,
        this.image,
        this.isActive,
        this.createdAt});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    seatCapacity = int.tryParse(json['seat_capacity'].toString());
    maximumWeight = int.tryParse(json['maximum_weight'].toString());
    hatchBagCapacity = int.tryParse(json['hatch_bag_capacity'].toString());
    engine = json['engine'];
    description = json['description'];
    image = json['image'];
    isActive = int.tryParse(json['is_active'].toString());
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['seat_capacity'] = seatCapacity;
    data['maximum_weight'] = maximumWeight;
    data['hatch_bag_capacity'] = hatchBagCapacity;
    data['engine'] = engine;
    data['description'] = description;
    data['image'] = image;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class ParcelInformation {
  String? parcelCategoryId;
  String? parcelCategoryName;
  String? payer;
  double? weight;

  ParcelInformation({this.parcelCategoryId, this.payer, this.weight,this.parcelCategoryName});

  ParcelInformation.fromJson(Map<String, dynamic> json) {
    parcelCategoryId = json['parcel_category_id'];
    parcelCategoryName = json['parcel_category_name'];
    payer = json['payer'];
    weight = double.tryParse(json['weight'].toString());
  }

}

class VehicleCategory {
  String? id;
  String? name;
  String? image;
  String? type;

  VehicleCategory({this.id, this.name, this.image, this.type});

  VehicleCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }
}

class ParcelRefund {
  List<Attachments>? attachments;
  String? readableId;
  double? parcelApproximatePrice;
  String? reason;
  RefundStatus? status;
  String? approvalNote;
  String? denyNote;
  String? note;
  double? refundAmountByAdmin;
  String? refundMethod;
  String? customerNote;
  bool? isCouponUsed;

  ParcelRefund(
      {this.attachments,
        this.readableId,
        this.parcelApproximatePrice,
        this.reason,
        this.status,
        this.approvalNote,
        this.denyNote,
        this.note,
        this.refundAmountByAdmin,
        this.refundMethod,
        this.customerNote,
        this.isCouponUsed
      });

  ParcelRefund.fromJson(Map<String, dynamic> json) {
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    readableId = json['readable_id'];
    parcelApproximatePrice = double.tryParse(json['parcel_approximate_price'].toString());
    reason = json['reason'];
    status = _getStatusType(json['status']);
    approvalNote = json['approval_note'];
    denyNote = json['deny_note'];
    note = json['note'];
    refundAmountByAdmin = double.tryParse(json['refund_amount_by_admin'].toString());
    refundMethod = json['refund_method'];
    customerNote = json['customer_note'];
    isCouponUsed = json['coupon_setup_used'] != null ? (bool.tryParse(json['coupon_setup_used'].toString()) ?? (json['coupon_setup_used'].toString() == '1')) : null;
  }
}

RefundStatus _getStatusType(String value) {
  switch(value) {
    case 'pending': {
      return RefundStatus.pending;
    }
    case 'refunded': {
      return RefundStatus.refunded;
    }
    case 'denied': {
      return RefundStatus.denied;

    }
    default: {
      return RefundStatus.approved;
    }
  }
}


class Attachments {
  String? file;

  Attachments({this.file});

  Attachments.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }
}

class DriverSafetyAlert {
  String? id;
  String? alertLocation;
  List<String>? reason;
  String? comment;
  String? status;
  String? tripRequestId;
  String? sentBy;
  String? resolvedLocation;
  int? numberOfAlert;
  String? resolvedBy;
  String? tripStatusWhenMakeAlert;

  DriverSafetyAlert(
      {this.id,
        this.alertLocation,
        this.reason,
        this.comment,
        this.status,
        this.tripRequestId,
        this.sentBy,
        this.resolvedLocation,
        this.numberOfAlert,
        this.resolvedBy,
        this.tripStatusWhenMakeAlert});

  DriverSafetyAlert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alertLocation = json['alert_location'];
    reason = json['reason'].cast<String>();
    comment = json['comment'];
    status = json['status'];
    tripRequestId = json['trip_request_id'];
    sentBy = json['sent_by'];
    resolvedLocation = json['resolved_location'];
    numberOfAlert = int.tryParse(json['number_of_alert'].toString());
    resolvedBy = json['resolved_by'];
    tripStatusWhenMakeAlert = json['trip_status_when_make_alert'];
  }
}