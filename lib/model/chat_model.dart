class ChatModel {
  List<Data>? data;
  String? message;
  String? status;

  ChatModel({this.data, this.message, this.status});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  int? sernderId;
  int? receiverId;
  String? message;
  int? status;
  String? datetime;

  Data(
      {this.id,
        this.sernderId,
        this.receiverId,
        this.message,
        this.status,
        this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sernderId = json['sernder_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sernder_id'] = sernderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['status'] = status;
    data['datetime'] = datetime;
    return data;
  }
}
