class RemainingDistanceModel {
  double? distance;
  String? distanceText;
  String? duration;
  int? durationSec;
  String? durationInTraffic;
  int? durationInTrafficSec;
  String? status;
  String? driveMode;
  String? encodedPolyline;

  RemainingDistanceModel(
      {this.distance,
        this.distanceText,
        this.duration,
        this.durationSec,
        this.status,
        this.driveMode,
        this.encodedPolyline,
        this.durationInTraffic,
        this.durationInTrafficSec
      });

  RemainingDistanceModel.fromJson(Map<String, dynamic> json) {
    distance = double.tryParse(json['distance'].toString());
    distanceText = json['distance_text'];
    duration = json['duration'];
    durationSec = int.tryParse(json['duration_sec'].toString());
    status = json['status'];
    driveMode = json['drive_mode'];
    encodedPolyline = json['encoded_polyline'];
    durationInTraffic = json['duration_in_traffic'];
    durationInTrafficSec = int.tryParse(json['duration_in_traffic_sec'].toString());
  }

}
