class PlayerRankModel {
  int? status;
  String? message;
  List<Data>? data;

  PlayerRankModel({this.status, this.message, this.data});

  PlayerRankModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userid;
  String? username;
  String? profilePicture;
  String? totalWinAmount;
  int? userRank;

  Data(
      {this.userid,
        this.username,
        this.profilePicture,
        this.totalWinAmount,
        this.userRank});

  Data.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    profilePicture = json['profile_picture'];
    totalWinAmount = json['total_win_amount'];
    userRank = json['user_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['username'] = username;
    data['profile_picture'] = profilePicture;
    data['total_win_amount'] = totalWinAmount;
    data['user_rank'] = userRank;
    return data;
  }
}
