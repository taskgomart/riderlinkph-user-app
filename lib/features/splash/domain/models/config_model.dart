import 'package:ride_sharing_user_app/features/auth/domain/models/additional_field_model.dart';

class ConfigModel {
  String? businessName;
  String? logo;
  bool? bidOnFare;
  String? countryCode;
  String? businessAddress;
  String? businessContactPhone;
  String? businessContactEmail;
  String? businessSupportPhone;
  String? businessSupportEmail;
  String? baseUrl;
  ImageBaseUrl? imageBaseUrl;
  String? currencyDecimalPoint;
  String? currencyCode;
  String? currencySymbolPosition;
  AboutUs? aboutUs;
  AboutUs? privacyPolicy;
  AboutUs? termsAndConditions;
  AboutUs? legal;
  bool? smsVerification;
  bool? emailVerification;
  String? mapApiKey;
  int? paginationLimit;
  String? facebookLogin;
  String? googleLogin;
  List<String>? timeZones;
  bool? verification;
  List<PaymentGateways>? paymentGateways;
  bool? conversionStatus;
  int? conversionRate;
  bool? addIntermediatePoint;
  int? otpResendTime;
  String? currencySymbol;
  int? tripActiveTime;
  bool? reviewStatus;
  MaintenanceMode? maintenanceMode;
  String? webSocketUrl;
  String? webSocketPort;
  String? webSocketKey;
  double? searchRadius;
  double? completionRadius;
  bool? isDemo;
  bool? levelStatus;
  int? popularTips;
  bool? externalSystem;
  String? martBusinessName;
  String? martPlayStoreUrl;
  String? martAppStoreUrl;
  bool? referralEarningStatus;
  double? androidAppMinimumVersion;
  double? iosAppMinimumVersion;
  String? androidAppUrl;
  String? iosAppUrl;
  bool? parcelRefundStatus;
  int? parcelRefundValidity;
  String? parcelRefundValidityType;
  bool? isFirebaseOtpVerification;
  List<ZoneExtraFare>? zoneExtraFare;
  AboutUs? refundPolicy;
  bool? isSmsGateway;
  String? websocketScheme;
  bool? maximumParcelWeightStatus;
  double? maximumParcelWeightCapacity;
  String? parcelWeightUnit;
  bool? safetyFeatureStatus;
  int? safetyFeatureMinimumTripDelayTime;
  String? safetyFeatureMinimumTripDelayTimeType;
  bool? afterTripCompleteSafetyFeatureActiveStatus;
  int? afterTripCompleteSafetyFeatureSetTime;
  String? safetyFeatureEmergencyGovtNumber;
  bool? otpConfirmationForTrip;
  bool? scheduleTripStatus;
  int? minimumScheduleBookTime;
  String? minimumScheduleBookTimeType;
  int? advanceScheduleBookTime;
  String? advanceScheduleBookTimeType;
  bool? walletAddFundStatus;
  double? walletMinimumDepositLimit;
  int? maxImageUploadSize;
  int? maxFileUploadSize;
  CustomerLoginOptions? customerLoginOptions;
  bool? isRealTimeLocationShareEnable;
  bool? isFemaleRideServiceActive;
  List<AdditionalFieldModel>? additionalFieldList;

  ConfigModel(
      {this.businessName,
        this.logo,
        this.bidOnFare,
        this.countryCode,
        this.businessAddress,
        this.businessContactPhone,
        this.businessContactEmail,
        this.businessSupportPhone,
        this.businessSupportEmail,
        this.baseUrl,
        this.imageBaseUrl,
        this.currencyDecimalPoint,
        this.currencyCode,
        this.currencySymbolPosition,
        this.aboutUs,
        this.privacyPolicy,
        this.termsAndConditions,
        this.legal,
        this.smsVerification,
        this.emailVerification,
        this.mapApiKey,
        this.paginationLimit,
        this.facebookLogin,
        this.googleLogin,
        this.timeZones,
        this.verification,
        this.paymentGateways,
        this.conversionStatus,
        this.conversionRate,
        this.addIntermediatePoint,
        this.otpResendTime,
        this.currencySymbol,
        this.tripActiveTime,
        this.reviewStatus,
        this.maintenanceMode,
        this.webSocketUrl,
        this.webSocketPort,
        this.webSocketKey,
        this.searchRadius,
        this.completionRadius,
        this.isDemo,
        this.levelStatus,
        this.popularTips,
        this.externalSystem,
        this.martBusinessName,
        this.martPlayStoreUrl,
        this.martAppStoreUrl,
        this.referralEarningStatus,
        this.androidAppMinimumVersion,
        this.androidAppUrl,
        this.iosAppMinimumVersion,
        this.iosAppUrl,
        this.parcelRefundStatus,
        this.parcelRefundValidity,
        this.parcelRefundValidityType,
        this.isFirebaseOtpVerification,
        this.zoneExtraFare,
        this.refundPolicy,
        this.isSmsGateway,
        this.websocketScheme,
        this.maximumParcelWeightStatus,
        this.maximumParcelWeightCapacity,
        this.parcelWeightUnit,
        this.afterTripCompleteSafetyFeatureActiveStatus,
        this.afterTripCompleteSafetyFeatureSetTime,
        this.safetyFeatureEmergencyGovtNumber,
        this.safetyFeatureMinimumTripDelayTime,
        this.safetyFeatureMinimumTripDelayTimeType,
        this.safetyFeatureStatus,
        this.otpConfirmationForTrip,
        this.scheduleTripStatus,
        this.advanceScheduleBookTime,
        this.advanceScheduleBookTimeType,
        this.minimumScheduleBookTime,
        this.minimumScheduleBookTimeType,
        this.walletAddFundStatus,
        this.walletMinimumDepositLimit,
        this.maxImageUploadSize,
        this.maxFileUploadSize,
        this.customerLoginOptions,
        this.isRealTimeLocationShareEnable,
        this.isFemaleRideServiceActive,
        this.additionalFieldList
      });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    logo = json['logo'];
    bidOnFare = json['bid_on_fare'] != null ? (bool.tryParse(json['bid_on_fare'].toString()) ?? (json['bid_on_fare'].toString() == '1')) : null;
    if(json['country_code'] != null && json['country_code'] != ""){
      countryCode = json['country_code']??'BD';
    }else{
      countryCode = 'BD';
    }

    businessAddress = json['business_address'];
    businessContactPhone = json['business_contact_phone'];
    businessContactEmail = json['business_contact_email'];
    businessSupportPhone = json['business_support_phone'];
    businessSupportEmail = json['business_support_email'];
    baseUrl = json['base_url'];
    webSocketUrl = json['websocket_url'];
    webSocketPort = json['websocket_port'];
    webSocketKey = json['websocket_key'];
    imageBaseUrl = json['image_base_url'] != null
        ? ImageBaseUrl.fromJson(json['image_base_url'])
        : null;
    currencyDecimalPoint = json['currency_decimal_point'];
    currencyCode = json['currency_code'];
    currencySymbolPosition = json['currency_symbol_position'];
    aboutUs = json['about_us'] != null
        ? AboutUs.fromJson(json['about_us'])
        : null;
    privacyPolicy = json['privacy_policy'] != null
        ? AboutUs.fromJson(json['privacy_policy'])
        : null;
    termsAndConditions = json['terms_and_conditions'] != null
        ? AboutUs.fromJson(json['terms_and_conditions'])
        : null;
    legal = json['legal'] != null
        ? AboutUs.fromJson(json['legal'])
        : null;
    smsVerification = json['sms_verification'] != null ? (bool.tryParse(json['sms_verification'].toString()) ?? (json['sms_verification'].toString() == '1')) : null;
    emailVerification = json['email_verification'] != null ? (bool.tryParse(json['email_verification'].toString()) ?? (json['email_verification'].toString() == '1')) : null;
    mapApiKey = json['map_api_key'];
    paginationLimit = int.tryParse(json['pagination_limit'].toString());
    facebookLogin = json['facebook_login'].toString();
    googleLogin = json['google_login'].toString();
    verification = json['verification'] != null ? (bool.tryParse(json['verification'].toString()) ?? (json['verification'].toString() == '1')) : null;
    conversionStatus = json['conversion_status'] != null ? (bool.tryParse(json['conversion_status'].toString()) ?? (json['conversion_status'].toString() == '1')) : null;
    conversionRate = int.tryParse(json['conversion_rate'].toString());
    addIntermediatePoint = json['add_intermediate_points'] != null ? (bool.tryParse(json['add_intermediate_points'].toString()) ?? (json['add_intermediate_points'].toString() == '1')) : null;
    otpResendTime = int.tryParse(json['otp_resend_time'].toString());
    currencySymbol = json['currency_symbol'];
    tripActiveTime = int.tryParse(json['trip_request_active_time'].toString());
    reviewStatus = json['review_status'] != null ? (bool.tryParse(json['review_status'].toString()) ?? (json['review_status'].toString() == '1')) : null;
    maintenanceMode = json['maintenance_mode'] != null
        ? MaintenanceMode.fromJson(json['maintenance_mode'])
        : null;
    isDemo = json['is_demo'] != null ? (bool.tryParse(json['is_demo'].toString()) ?? (json['is_demo'].toString() == '1')) : null;
    levelStatus = json['level_status'] != null ? (bool.tryParse(json['level_status'].toString()) ?? (json['level_status'].toString() == '1')) : null;
    popularTips = int.tryParse(json['popular_tips'].toString());
    if (json['payment_gateways'] != null) {
      paymentGateways = <PaymentGateways>[];
      json['payment_gateways'].forEach((v) {
        paymentGateways!.add(PaymentGateways.fromJson(v));
      });
    }
    if(json['driver_completion_radius'] != null){
      try{
        completionRadius = double.tryParse(json['driver_completion_radius'].toString());
      }catch(e){
        completionRadius = double.tryParse(json['driver_completion_radius'].toString());
      }
    }
    if(json['search_radius'] != null){
      try{
        searchRadius = double.tryParse(json['search_radius'].toString());
      }catch(e){
        searchRadius = double.tryParse(json['search_radius'].toString());
      }
    }
    externalSystem = json['external_system'] != null ? (bool.tryParse(json['external_system'].toString()) ?? (json['external_system'].toString() == '1')) : null;
    martBusinessName = json['mart_business_name'];
    martPlayStoreUrl = json['mart_app_url_android'];
    martAppStoreUrl = json['mart_app_url_ios'];
    referralEarningStatus = json['referral_earning_status'] != null ? (bool.tryParse(json['referral_earning_status'].toString()) ?? (json['referral_earning_status'].toString() == '1')) : null;
    androidAppMinimumVersion = double.tryParse(json['app_minimum_version_for_android'].toString());
    androidAppUrl = json['app_url_for_android'];
    iosAppMinimumVersion = double.tryParse(json['app_minimum_version_for_ios'].toString());
    iosAppUrl = json['app_url_for_ios'];
    parcelRefundStatus = json['parcel_refund_status'] != null ? (bool.tryParse(json['parcel_refund_status'].toString()) ?? (json['parcel_refund_status'].toString() == '1')) : null;
    parcelRefundValidity = int.tryParse(json['parcel_refund_validity'].toString());
    parcelRefundValidityType = json['parcel_refund_validity_type'];
    isFirebaseOtpVerification = json['firebase_otp_verification'] != null ? (bool.tryParse(json['firebase_otp_verification'].toString()) ?? (json['firebase_otp_verification'].toString() == '1')) : null;
    isSmsGateway = json['sms_gateway'] != null ? (bool.tryParse(json['sms_gateway'].toString()) ?? (json['sms_gateway'].toString() == '1')) : null;
    websocketScheme = json['websocket_scheme'];
    parcelWeightUnit = json['parcel_weight_unit'];
    zoneExtraFare = List<ZoneExtraFare>.from(json["zone_extra_fare"].map((x) => ZoneExtraFare.fromJson(x)));
    refundPolicy = json['refund_policy'] != null ? AboutUs.fromJson(json['refund_policy']) : null;
    maximumParcelWeightStatus = json['maximum_parcel_weight_status'] != null ? (bool.tryParse(json['maximum_parcel_weight_status'].toString()) ?? (json['maximum_parcel_weight_status'].toString() == '1')) : null;
    safetyFeatureStatus = json['safety_feature_status'] != null ? (bool.tryParse(json['safety_feature_status'].toString()) ?? (json['safety_feature_status'].toString() == '1')) : null;
    safetyFeatureMinimumTripDelayTime = int.tryParse(json['safety_feature_minimum_trip_delay_time'].toString());
    safetyFeatureMinimumTripDelayTimeType = json['safety_feature_minimum_trip_delay_time_type'];
    afterTripCompleteSafetyFeatureActiveStatus = json['after_trip_completed_safety_feature_active_status'] != null ? (bool.tryParse(json['after_trip_completed_safety_feature_active_status'].toString()) ?? (json['after_trip_completed_safety_feature_active_status'].toString() == '1')) : null;
    afterTripCompleteSafetyFeatureSetTime = int.tryParse(json['after_trip_completed_safety_feature_set_time'].toString());
    safetyFeatureEmergencyGovtNumber = json['safety_feature_emergency_govt_number'];
    maximumParcelWeightCapacity = double.tryParse(json['maximum_parcel_weight_capacity'].toString());
    otpConfirmationForTrip = json['otp_confirmation_for_trip'] != null ? (bool.tryParse(json['otp_confirmation_for_trip'].toString()) ?? (json['otp_confirmation_for_trip'].toString() == '1')) : null;
    scheduleTripStatus = json['schedule_trip_status'] != null ? (bool.tryParse(json['schedule_trip_status'].toString()) ?? (json['schedule_trip_status'].toString() == '1')) : null;
    advanceScheduleBookTime = int.tryParse(json['advance_schedule_book_time'].toString());
    advanceScheduleBookTimeType = json['advance_schedule_book_time_type'];
    minimumScheduleBookTime = int.tryParse(json['minimum_schedule_book_time'].toString());
    minimumScheduleBookTimeType = json['minimum_schedule_book_time_type'];
    walletAddFundStatus = json['wallet_add_fund_status'] != null ? (bool.tryParse(json['wallet_add_fund_status'].toString()) ?? (json['wallet_add_fund_status'].toString() == '1')) : null;
    walletMinimumDepositLimit = double.tryParse(json['wallet_minimum_deposit_limit'].toString());
    maxImageUploadSize = int.tryParse(json['upload_max_image_size'].toString());
    maxFileUploadSize = int.tryParse(json['upload_max_file_size'].toString());
    customerLoginOptions = json['customer_login_options'] != null ? CustomerLoginOptions.fromJson(json['customer_login_options']) : null;
    isRealTimeLocationShareEnable = json['is_real_time_location_sharing_enabled'] != null ? (bool.tryParse(json['is_real_time_location_sharing_enabled'].toString()) ?? (json['is_real_time_location_sharing_enabled'].toString() == '1')) : null;
    isFemaleRideServiceActive = json['female_only_ride_service'] != null ? (bool.tryParse(json['female_only_ride_service'].toString()) ?? (json['female_only_ride_service'].toString() == '1')) : null;
    if (json['customer_additional_registration_form_fields'] != null) {
      additionalFieldList = <AdditionalFieldModel>[];
      json['customer_additional_registration_form_fields'].forEach((v) {
        additionalFieldList!.add(AdditionalFieldModel.fromJson(v));
      });
    }
  }

}


class ImageBaseUrl {
  String? profileImageDriver;
  String? banner;
  String? vehicleCategory;
  String? vehicleModel;
  String? vehicleBrand;
  String? profileImage;
  String? identityImage;
  String? documents;
  String? level;
  String? pages;
  String? conversation;
  String? parcel;
  String? additionalData;
  String? parcelPickupProof;
  String? parcelDeliveryProof;

  ImageBaseUrl(
      {this.profileImageDriver,
        this.banner,
        this.vehicleCategory,
        this.vehicleModel,
        this.vehicleBrand,
        this.profileImage,
        this.identityImage,
        this.documents,
        this.level,
        this.pages,
        this.conversation,
        this.parcel,
        this.additionalData,
        this.parcelDeliveryProof,
        this.parcelPickupProof
      });

  ImageBaseUrl.fromJson(Map<String, dynamic> json) {
    profileImageDriver = json['profile_image_driver'];
    banner = json['banner'];
    vehicleCategory = json['vehicle_category'];
    vehicleModel = json['vehicle_model'];
    vehicleBrand = json['vehicle_brand'];
    profileImage = json['profile_image'];
    identityImage = json['identity_image'];
    documents = json['documents'];
    level = json['level'];
    pages = json['pages'];
    conversation = json['conversation'];
    parcel =  json['parcel'];
    additionalData = json['additional_data'];
    parcelPickupProof = json['parcel_pickup_proof'];
    parcelDeliveryProof = json['parcel_delivery_proof'];
  }


}
class AboutUs {
  String? image;
  String? name;
  String? shortDescription;
  String? longDescription;

  AboutUs({this.image, this.name, this.shortDescription, this.longDescription});

  AboutUs.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
  }

}
class PaymentGateways {
  String? gateway;
  String? gatewayTitle;
  String? gatewayImage;

  PaymentGateways({this.gateway, this.gatewayTitle, this.gatewayImage});

  PaymentGateways.fromJson(Map<String, dynamic> json) {
    gateway = json['gateway'];
    gatewayTitle = json['gateway_title'];
    gatewayImage = json['gateway_image'];
  }

}

class MaintenanceMode {
  int? maintenanceStatus;
  SelectedMaintenanceSystem? selectedMaintenanceSystem;
  MaintenanceMessages? maintenanceMessages;
  MaintenanceTypeAndDuration? maintenanceTypeAndDuration;

  MaintenanceMode({
    this.maintenanceStatus,
    this.selectedMaintenanceSystem,
    this.maintenanceMessages,
    this.maintenanceTypeAndDuration
  });

  MaintenanceMode.fromJson(Map<String, dynamic> json) {
    maintenanceStatus = int.tryParse(json['maintenance_status'].toString());
    selectedMaintenanceSystem = json['selected_maintenance_system'] != null
        ? SelectedMaintenanceSystem.fromJson(
        json['selected_maintenance_system'])
        : null;
    maintenanceMessages = json['maintenance_messages'] != null
        ? MaintenanceMessages.fromJson(json['maintenance_messages'])
        : null;

    maintenanceTypeAndDuration = json['maintenance_type_and_duration'] != null
        ? MaintenanceTypeAndDuration.fromJson(
        json['maintenance_type_and_duration'])
        : null;
  }

}

class SelectedMaintenanceSystem {
  int? userApp;
  int? driverApp;

  SelectedMaintenanceSystem(
      { this.userApp, this.driverApp});

  SelectedMaintenanceSystem.fromJson(Map<String, dynamic> json) {
    userApp = int.tryParse(json['user_app'].toString());
    driverApp = int.tryParse(json['driver_app'].toString());
  }

}

class MaintenanceMessages {
  int? businessNumber;
  int? businessEmail;
  String? maintenanceMessage;
  String? messageBody;

  MaintenanceMessages(
      {this.businessNumber,
        this.businessEmail,
        this.maintenanceMessage,
        this.messageBody});

  MaintenanceMessages.fromJson(Map<String, dynamic> json) {
    businessNumber = int.tryParse(json['business_number'].toString());
    businessEmail = int.tryParse(json['business_email'].toString());
    maintenanceMessage = json['maintenance_message'];
    messageBody = json['message_body'];
  }

}

class MaintenanceTypeAndDuration {
  String? maintenanceDuration;
  String? startDate;
  String? endDate;

  MaintenanceTypeAndDuration(
      {String? maintenanceDuration, String? startDate, String? endDate}) {
    if (maintenanceDuration != null) {
      maintenanceDuration = maintenanceDuration;
    }
    if (startDate != null) {
      startDate = startDate;
    }
    if (endDate != null) {
      endDate = endDate;
    }
  }

  MaintenanceTypeAndDuration.fromJson(Map<String, dynamic> json) {
    maintenanceDuration = json['maintenance_duration'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

}


class ZoneExtraFare {
  bool status;
  String zoneId;
  String reason;

  ZoneExtraFare({
    required this.status,
    required this.zoneId,
    required this.reason,
  });

  factory ZoneExtraFare.fromJson(Map<String, dynamic> json) => ZoneExtraFare(
    status: json["status"],
    zoneId: json["zone_id"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "zone_id": zoneId,
    "reason": reason,
  };
}

class CustomerLoginOptions {
  bool? manualLogin;
  bool? otpLogin;

  CustomerLoginOptions({this.manualLogin, this.otpLogin});

  CustomerLoginOptions.fromJson(Map<String, dynamic> json) {
    manualLogin = json['manual_login'] != null ? (bool.tryParse(json['manual_login'].toString()) ?? (json['manual_login'].toString() == '1')) : null;
    otpLogin = json['otp_login'] != null ? (bool.tryParse(json['otp_login'].toString()) ?? (json['otp_login'].toString() == '1')) : null;
  }

}