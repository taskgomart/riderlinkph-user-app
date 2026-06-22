class SignUpBody {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;
  String? address;
  String? identificationType;
  String? identificationNumber;
  String? referralCode;



  SignUpBody({
    this.fName, this.lName, this.phone, this.email,
    this.password, this.confirmPassword, this.referralCode,
    this.address, this.identificationNumber, this.identificationType
  });

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['first_name'];
    lName = json['last_name'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    referralCode = json['referral_code'];
    email = json['email'];
    address = json['address'];
    identificationType = json['identification_type'];
    identificationNumber = json['identification_number'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = fName;
    data['last_name'] = lName;
    data['phone'] = phone;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['referral_code'] = referralCode;
    data['email'] = email;
    return data;
  }
}