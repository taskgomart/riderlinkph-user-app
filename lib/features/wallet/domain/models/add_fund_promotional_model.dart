class AddFundPromotionalModel {
  String? responseCode;
  String? message;
  int? totalSize;
  int? limit;
  int? offset;
  List<Data>? data;
  List<String>? errors;

  AddFundPromotionalModel({
    this.responseCode,
    this.message,
    this.totalSize,
    this.limit,
    this.offset,
    this.data,
    this.errors
  });

  AddFundPromotionalModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    totalSize = int.tryParse(json['total_size'].toString());
    limit = int.tryParse(json['limit'].toString());
    offset = int.tryParse(json['offset'].toString());
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['errors'] = errors;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? description;
  double? bonusAmount;
  String? amountType;
  int? minAddAmount;
  int? maxBonusAmount;
  String? startDate;
  String? endDate;
  List<String>? userType;
  int? isActive;

  Data({
    this.id,
    this.name,
    this.description,
    this.bonusAmount,
    this.amountType,
    this.minAddAmount,
    this.maxBonusAmount,
    this.startDate,
    this.endDate,
    this.userType,
    this.isActive
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    bonusAmount = double.tryParse(json['bonus_amount'].toString());
    amountType = json['amount_type'];
    minAddAmount = int.tryParse(json['min_add_amount'].toString());
    maxBonusAmount = int.tryParse(json['max_bonus_amount'].toString());
    startDate = json['start_date'];
    endDate = json['end_date'];
    userType = json['user_type'].cast<String>();
    isActive = int.tryParse(json['is_active'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['bonus_amount'] = bonusAmount;
    data['amount_type'] = amountType;
    data['min_add_amount'] = minAddAmount;
    data['max_bonus_amount'] = maxBonusAmount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['user_type'] = userType;
    data['is_active'] = isActive;
    return data;
  }
}
