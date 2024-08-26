class ProfileModel {
  String? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? mobileNumber;
  String? username;
  String? email;
  String? password;
  int? score;
  int? coins;
  int? level;
  String? profilePicture;
  String? bonus;
  String? winningAmountWallet;
  String? depositWallet;
  String? wallet;
  String? cashback;
  String? referralCode;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.mobileNumber,
        this.username,
        this.email,
        this.password,
        this.score,
        this.coins,
        this.level,
        this.profilePicture,
        this.bonus,
        this.winningAmountWallet,
        this.depositWallet,
        this.wallet,
        this.cashback,
        this.referralCode,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    print(json['wallet']);
    id = json['id'];
    mobileNumber = json['mobile_number'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    score = json['score'];
    coins = json['coins'];
    level = json['level'];
    profilePicture = json['profile_picture'];
    bonus = json['bonus'];
    winningAmountWallet = json['winning_amount_wallet'];
    depositWallet = json['deposit_wallet'];
    wallet = json['wallet'];
    cashback = json['cashback'];
    referralCode = json['referral_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mobile_number'] = mobileNumber;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['score'] = score;
    data['coins'] = coins;
    data['level'] = level;
    data['profile_picture'] = profilePicture;
    data['bonus'] = bonus;
    data['winning_amount_wallet'] = winningAmountWallet;
    data['deposit_wallet'] = depositWallet;
    data['wallet'] = wallet;
    data['cashback'] = cashback;
    data['referral_code'] = referralCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
