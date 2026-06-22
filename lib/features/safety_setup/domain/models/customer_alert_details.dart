class CustomerAlertDetails {
  String? responseCode;
  String? message;
  int? totalSize;
  int? limit;
  int? offset;
  Data? data;
  List<String>? errors;

  CustomerAlertDetails(
      {this.responseCode,
        this.message,
        this.totalSize,
        this.limit,
        this.offset,
        this.data,
        this.errors});

  CustomerAlertDetails.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    totalSize = int.tryParse(json['total_size'].toString());
    limit = int.tryParse(json['limit'].toString());
    offset = int.tryParse(json['offset'].toString());
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'].cast<String>();
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
