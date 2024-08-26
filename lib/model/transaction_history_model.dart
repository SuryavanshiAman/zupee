class TransactionHistoryModel {
  String? status;
  String? message;
  List<Data>? data;

  TransactionHistoryModel({this.status, this.message, this.data});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? type;
  int? amount;
  String? datetime;
  String? description;

  Data({this.type, this.amount, this.datetime, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
    datetime = json['datetime'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['datetime'] = this.datetime;
    data['description'] = this.description;
    return data;
  }
}
