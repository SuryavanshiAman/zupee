// class NotificationModel {
//   List<Data>? data;
//   String? message;
//   String? status;
//
//   NotificationModel({this.data, this.message,this.status});
//
//   NotificationModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = message;
//     data['status'] = status;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? message;
//   String? userid;
//   String? type;
//   String? createdAt;
//
//   Data({this.id, this.message, this.userid, this.type, this.createdAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     message = json['message'];
//     userid = json['userid'];
//     type = json['type'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['message'] = message;
//     data['userid'] = userid;
//     data['type'] = type;
//     data['created_at'] = createdAt;
//     return data;
//   }
// }
class NotificationModel {
  String? status;
  String? msgStatus;
  List<Data>? data;
  String? message;

  NotificationModel({this.status, this.msgStatus, this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msgStatus = json['msg_status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg_status'] = this.msgStatus;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? message;
  String? userid;
  String? type;
  int? status;
  String? createdAt;

  Data(
      {this.id,
        this.message,
        this.userid,
        this.type,
        this.status,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    userid = json['userid'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['userid'] = this.userid;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
