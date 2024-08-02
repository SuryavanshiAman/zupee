class HelpModel {
  String? status;
  List<Data>? data;

  HelpModel({this.status, this.data});

  HelpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  List<Support>? support;

  Data({this.name, this.support});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['support'] != null) {
      support = <Support>[];
      json['support'].forEach((v) {
        support!.add(Support.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (support != null) {
      data['support'] = support!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Support {
  String? description;

  Support({this.description});

  Support.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    return data;
  }
}
