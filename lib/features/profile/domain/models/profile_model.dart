import 'package:ride_sharing_user_app/features/profile/domain/models/profile_additional_data.dart';

class ProfileModel {

  ProfileInfo? data;


  ProfileModel(
      {
        this.data,
     });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ProfileInfo.fromJson(json['data']) : null;
  }
}

class ProfileInfo {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? identificationNumber;
  String? identificationType;
  String? profileImage;
  List<String>? identificationImage;
  int? isActive;
  Wallet? wallet;
  Level? level;
  String? userRating;
  int? totalRideCount;
  double? completionPercent;
  int? loyaltyPoints;
  String? loggedInVia;
  List<ProfileAdditionalData>? additionalData;

  ProfileInfo(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.gender,
        this.identificationNumber,
        this.identificationType,
        this.profileImage,
        this.identificationImage,
        this.isActive,
        this.wallet,
        this.level,
        this.userRating,
        this.totalRideCount,
        this.completionPercent,
        this.loyaltyPoints,
        this.loggedInVia,
        this.additionalData,
      });

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email']??'';
    phone = json['phone'];
    gender = json['gender'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    profileImage = json['profile_image']??'';
    if(json['identification_image'] != null){
      identificationImage = json['identification_image'].cast<String>();
    }

    isActive = int.tryParse(json['is_active'].toString());
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    level = json['level'] != null ? Level.fromJson(json['level']) : null;
    userRating = json['user_rating'].toString();
    totalRideCount = int.tryParse(json['total_ride_count'].toString());
    completionPercent = double.tryParse(json['completion_percent'].toString());
    loyaltyPoints = int.tryParse(json['loyalty_points'].toString());
    loggedInVia = json['logged_in_via'];
    if (json['additional_data'] != null) {
      additionalData = <ProfileAdditionalData>[];
      json['additional_data'].forEach((v) {
        additionalData!.add(ProfileAdditionalData.fromJson(v));
      });
    }

  }

}


class Wallet {
  String? id;
  double? payableBalance;
  double? receivableBalance;
  double? pendingBalance;
  double? walletBalance;
  double? totalWithdrawn;
  double? referralEarn;

  Wallet(
      {this.id,
        this.payableBalance,
        this.receivableBalance,
        this.pendingBalance,
        this.walletBalance,
        this.totalWithdrawn,
        this.referralEarn
      });

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payableBalance = double.tryParse(json['payable_balance'].toString());
    receivableBalance = double.tryParse(json['receivable_balance'].toString());
    pendingBalance = double.tryParse(json['pending_balance'].toString());
    walletBalance = double.tryParse(json['wallet_balance'].toString());
    totalWithdrawn = double.tryParse(json['total_withdrawn'].toString());
    referralEarn = double.tryParse(json['referral_earn'].toString());
  }

}

class Level {
  String? id;
  int? sequence;
  String? name;
  String? rewardType;
  String? image;

  Level(
      {this.id,
        this.sequence,
        this.name,
        this.rewardType,
        this.image
        });

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sequence = int.tryParse(json['sequence'].toString());
    name = json['name'];
    rewardType = json['reward_type'];
    image = json['image'];

  }

}