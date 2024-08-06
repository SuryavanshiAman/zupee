class ViewBankDetailsModel {
  String? status;
  String? message;
  List<Data>? data;

  ViewBankDetailsModel({this.status, this.message, this.data});

  ViewBankDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? userid;
  String? name;
  String? accountNo;
  String? bankName;
  String? branchName;
  String? ifscCode;
  String? status;
  String? datetime;

  Data(
      {this.id,
        this.userid,
        this.name,
        this.accountNo,
        this.bankName,
        this.branchName,
        this.ifscCode,
        this.status,
        this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    name = json['name'];
    accountNo = json['account_no'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    ifscCode = json['ifsc_code'];
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['account_no'] = this.accountNo;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['ifsc_code'] = this.ifscCode;
    data['status'] = this.status;
    data['datetime'] = this.datetime;
    return data;
  }
}
