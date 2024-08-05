class AboutModel {
  String? status;
  List<Data>? data;

  AboutModel({this.status, this.data});

  AboutModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  List<About>? about;

  Data({this.id, this.name, this.about});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['about'] != null) {
      about = <About>[];
      json['about'].forEach((v) {
        about!.add(About.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (about != null) {
      data['about'] = about!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class About {
  String? description;

  About({this.description});

  About.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    return data;
  }
}
