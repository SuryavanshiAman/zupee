class ProfileModel {
  String? status;
  String? message;
  Data? data;
  GameStatus? gameStatus;

  ProfileModel({this.status, this.message, this.data, this.gameStatus});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    gameStatus = json['game_status'] != null
        ? GameStatus.fromJson(json['game_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (gameStatus != null) {
      data['game_status'] = gameStatus!.toJson();
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
  String? referrerId;
  String? createdAt;
  String? updatedAt;
  int? kycStatus;

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
        this.referrerId,
        this.createdAt,
        this.updatedAt,
        this.kycStatus
      });

  Data.fromJson(Map<String, dynamic> json) {
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
    referrerId = json['referrer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kycStatus = json['kyc_status'];
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
    data['referrer_id'] = referrerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['kyc_status'] = kycStatus;
    return data;
  }
}

class GameStatus {
  int? totalGames;
  int? winGame;
  int? lossGame;

  GameStatus({this.totalGames, this.winGame, this.lossGame});

  GameStatus.fromJson(Map<String, dynamic> json) {
    totalGames = json['total_games'];
    winGame = json['win_game'];
    lossGame = json['loss_game'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_games'] = totalGames;
    data['win_game'] = winGame;
    data['loss_game'] = lossGame;
    return data;
  }
}
