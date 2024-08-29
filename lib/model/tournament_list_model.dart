class TournamentModel {
  String? status;
  List<Data>? data;
  String? message;

  TournamentModel({this.status, this.data, this.message});

  TournamentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  int? amount;
  int? winPrize;
  int? winnerNo;
  String? contestName;
  int? contestId;
  int? status;
  int? categoryId;
  int? playerNo;
  String? tournamentStarttime;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.amount,
        this.winPrize,
        this.winnerNo,
        this.contestName,
        this.contestId,
        this.status,
        this.categoryId,
        this.playerNo,
        this.tournamentStarttime,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    winPrize = json['win_prize'];
    winnerNo = json['winner_no'];
    contestName = json['contest_name'];
    contestId = json['contest_id'];
    status = json['status'];
    categoryId = json['category_id'];
    playerNo = json['player_no'];
    tournamentStarttime = json['tournament_starttime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['win_prize'] = winPrize;
    data['winner_no'] = winnerNo;
    data['contest_name'] = contestName;
    data['contest_id'] = contestId;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['player_no'] = playerNo;
    data['tournament_starttime'] = tournamentStarttime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
