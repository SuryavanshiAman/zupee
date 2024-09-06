class ConfirmPaymentModel {
  String? status;
  String? message;
  int? balanceStatus;
  Deductions? deductions;

  ConfirmPaymentModel({this.status, this.message, this.deductions,this.balanceStatus});

  ConfirmPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    balanceStatus = json['blancestatus'];
    deductions = json['deductions'] != null
        ? Deductions.fromJson(json['deductions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['blancestatus'] = balanceStatus;
    if (deductions != null) {
      data['deductions'] = deductions!.toJson();
    }
    return data;
  }
}

class Deductions {
  String? bonus;
  String? cashback;
  String? depositWinning;

  Deductions({this.bonus, this.cashback, this.depositWinning});

  Deductions.fromJson(Map<String, dynamic> json) {
    bonus = json['bonus'];
    cashback = json['cashback'];
    depositWinning = json['deposit_winning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bonus'] = bonus;
    data['cashback'] = cashback;
    data['deposit_winning'] = depositWinning;
    return data;
  }
}
