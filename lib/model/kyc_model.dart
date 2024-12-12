class KycModel {
  int? status;
  Data? data;

  KycModel({this.status, this.data});

  KycModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userid;
  String? legalName;
  String? aadhaarNo;
  String? pancardNo;
  String? aadhaarCardImageFront;
  String? aadhaarCardImageBack;
  String? panCardImage;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userid,
        this.legalName,
        this.aadhaarNo,
        this.pancardNo,
        this.aadhaarCardImageFront,
        this.aadhaarCardImageBack,
        this.panCardImage,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    legalName = json['legal_name'];
    aadhaarNo = json['aadhaar_no'];
    pancardNo = json['pancard_no'];
    aadhaarCardImageFront = json['aadhaar_card_image_front'];
    aadhaarCardImageBack = json['aadhaar_card_image_back'];
    panCardImage = json['pan_card_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['legal_name'] = legalName;
    data['aadhaar_no'] = aadhaarNo;
    data['pancard_no'] = pancardNo;
    data['aadhaar_card_image_front'] = aadhaarCardImageFront;
    data['aadhaar_card_image_back'] = aadhaarCardImageBack;
    data['pan_card_image'] = panCardImage;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
