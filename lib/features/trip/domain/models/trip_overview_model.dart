class TripOverView {
  int? successRate;
  int? totalTrips;
  int? totalEarn;
  int? totalCancel;
  int? totalReviews;
  IncomeStat? incomeStat;

  TripOverView(
      {this.successRate,
        this.totalTrips,
        this.totalEarn,
        this.totalCancel,
        this.totalReviews,
        this.incomeStat});

  TripOverView.fromJson(Map<String, dynamic> json) {
    successRate = int.tryParse(json['success_rate'].toString());
    totalTrips = int.tryParse(json['total_trips'].toString());
    totalEarn = int.tryParse(json['total_earn'].toString());
    totalCancel = int.tryParse(json['total_cancel'].toString());
    totalReviews = int.tryParse(json['total_reviews'].toString());
    incomeStat = json['income_stat'] != null
        ? IncomeStat.fromJson(json['income_stat'])
        : null;
  }
}

class IncomeStat {
  int? sun;
  int? mon;
  int? tues;
  int? wed;
  int? thu;
  int? fri;
  int? sat;

  IncomeStat(
      {this.sun, this.mon, this.tues, this.wed, this.thu, this.fri, this.sat});

  IncomeStat.fromJson(Map<String, dynamic> json) {
    sun = int.tryParse(json['Sun'].toString());
    mon = int.tryParse(json['Mon'].toString());
    tues = int.tryParse(json['Tues'].toString());
    wed = int.tryParse(json['Wed'].toString());
    thu = int.tryParse(json['Thu'].toString());
    fri = int.tryParse(json['Fri'].toString());
    sat = int.tryParse(json['Sat'].toString());
  }
}
