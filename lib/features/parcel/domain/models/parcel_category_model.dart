class ParcelCategoryModel {
  String? responseCode;
  String? message;
  int? totalSize;
  String? limit;
  String? offset;
  List<ParcelCategory>? data;


  ParcelCategoryModel(
      {this.responseCode,
        this.message,
        this.totalSize,
        this.limit,
        this.offset,
        this.data
      });

  ParcelCategoryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    totalSize = int.tryParse(json['total_size'].toString());
    limit = json['limit'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = <ParcelCategory>[];
      json['data'].forEach((v) {
        data!.add(ParcelCategory.fromJson(v));
      });
    }

  }

}

class ParcelCategory {
  String? id;
  String? name;
  String? description;
  String? image;
  int? isActive;
  List<WeightFares>? weightFares;
  String? createdAt;

  ParcelCategory(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.isActive,
        this.weightFares,
        this.createdAt});

  ParcelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    isActive = int.tryParse(json['is_active'].toString());
    if (json['weight_fares'] != null) {
      weightFares = <WeightFares>[];
      json['weight_fares'].forEach((v) {
        weightFares!.add(WeightFares.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

}

class WeightFares {
  int? id;
  ParcelFare? parcelFare;
  ParcelWeight? parcelWeight;
  double? fare;
  String? createdAt;

  WeightFares(
      {this.id, this.parcelFare, this.parcelWeight, this.fare, this.createdAt});

  WeightFares.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    parcelFare = json['parcel_fare'] != null
        ? ParcelFare.fromJson(json['parcel_fare'])
        : null;
    parcelWeight = json['parcel_weight'] != null
        ? ParcelWeight.fromJson(json['parcel_weight'])
        : null;
    fare = double.tryParse(json['fare'].toString());
    createdAt = json['created_at'];
  }

}

class ParcelFare {
  String? id;
  double? baseFare;
  double? baseFarePerKm;
  double? cancellationFeePercent;
  double? minCancellationFee;
  String? createdAt;

  ParcelFare(
      {this.id,
        this.baseFare,
        this.baseFarePerKm,
        this.cancellationFeePercent,
        this.minCancellationFee,
        this.createdAt});

  ParcelFare.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseFare = double.tryParse(json['base_fare'].toString());
    baseFarePerKm = double.tryParse(json['base_fare_per_km'].toString());
    cancellationFeePercent = double.tryParse(json['cancellation_fee_percent'].toString());
    minCancellationFee = double.tryParse(json['min_cancellation_fee'].toString());
    createdAt = json['created_at'];
  }

}

class ParcelWeight {
  String? id;
  double? minWeight;
  double? maxWeight;
  String? createdAt;

  ParcelWeight(
      {this.id, this.minWeight, this.maxWeight, this.createdAt});

  ParcelWeight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minWeight = double.tryParse(json['min_weight'].toString());
    maxWeight = double.tryParse(json['max_weight'].toString());
    createdAt = json['created_at'];
  }

}
