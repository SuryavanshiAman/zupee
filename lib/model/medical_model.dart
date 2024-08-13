class MedicalModel {
  bool? success;
  String? message;
  List<Data>? data;

  MedicalModel({this.success, this.message, this.data});

  MedicalModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  int? count;
  List<Aman>? data;

  Data({this.date, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Aman>[];
      json['data'].forEach((v) {
        data!.add(Aman.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Aman {
  String? temperature;
  String? bloodPressure;
  String? diabetic;
  String? pulse;
  String? height;
  String? spo2;
  String? bloodGroup;
  String? weight;
  List<Diagnosis>? diagnosis;
  List<Symptoms>? symptoms;
  List<Labtest>? labtest;
  List<MedicineDetails>? medicineDetails;
  List<Notes>? notes;
  String? createdAt;
  String? doctorName;
  String? signature;
  String? profileImage;
  String? logo;
  String? about;
  String? hospitalNumber;
  String? alternateNumber;
  String? mobile;
  String? time;
  String? address;
  String? patientName;
  String? patientPhone;
  String? dob;
  String? age;
  String? gender;

  Aman(
      {this.temperature,
        this.bloodPressure,
        this.diabetic,
        this.pulse,
        this.height,
        this.spo2,
        this.bloodGroup,
        this.weight,
        this.diagnosis,
        this.symptoms,
        this.labtest,
        this.medicineDetails,
        this.notes,
        this.createdAt,
        this.doctorName,
        this.signature,
        this.profileImage,
        this.logo,
        this.about,
        this.hospitalNumber,
        this.alternateNumber,
        this.mobile,
        this.time,
        this.address,
        this.patientName,
        this.patientPhone,
        this.dob,
        this.age,
        this.gender});

  Aman.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    bloodPressure = json['blood_pressure'];
    diabetic = json['diabetic'];
    pulse = json['pulse'];
    height = json['height'];
    spo2 = json['spo2'];
    bloodGroup = json['blood_group'];
    weight = json['weight'];
    if (json['diagnosis'] != null) {
      diagnosis = <Diagnosis>[];
      json['diagnosis'].forEach((v) {
        diagnosis!.add(Diagnosis.fromJson(v));
      });
    }
    if (json['symptoms'] != null) {
      symptoms = <Symptoms>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(Symptoms.fromJson(v));
      });
    }
    if (json['labtest'] != null) {
      labtest = <Labtest>[];
      json['labtest'].forEach((v) {
        labtest!.add(Labtest.fromJson(v));
      });
    }
    if (json['medicine_details'] != null) {
      medicineDetails = <MedicineDetails>[];
      json['medicine_details'].forEach((v) {
        medicineDetails!.add(MedicineDetails.fromJson(v));
      });
    }
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    doctorName = json['doctor_name'];
    signature = json['signature'];
    profileImage = json['profile_image'];
    logo = json['logo'];
    about = json['about'];
    hospitalNumber = json['hospital_number'];
    alternateNumber = json['alternate_number'];
    mobile = json['mobile'];
    time = json['time'];
    address = json['address'];
    patientName = json['patient_name'];
    patientPhone = json['patient_phone'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temperature'] = temperature;
    data['blood_pressure'] = bloodPressure;
    data['diabetic'] = diabetic;
    data['pulse'] = pulse;
    data['height'] = height;
    data['spo2'] = spo2;
    data['blood_group'] = bloodGroup;
    data['weight'] = weight;
    if (diagnosis != null) {
      data['diagnosis'] = diagnosis!.map((v) => v.toJson()).toList();
    }
    if (symptoms != null) {
      data['symptoms'] = symptoms!.map((v) => v.toJson()).toList();
    }
    if (labtest != null) {
      data['labtest'] = labtest!.map((v) => v.toJson()).toList();
    }
    if (medicineDetails != null) {
      data['medicine_details'] =
          medicineDetails!.map((v) => v.toJson()).toList();
    }
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['doctor_name'] = doctorName;
    data['signature'] = signature;
    data['profile_image'] = profileImage;
    data['logo'] = logo;
    data['about'] = about;
    data['hospital_number'] = hospitalNumber;
    data['alternate_number'] = alternateNumber;
    data['mobile'] = mobile;
    data['time'] = time;
    data['address'] = address;
    data['patient_name'] = patientName;
    data['patient_phone'] = patientPhone;
    data['dob'] = dob;
    data['age'] = age;
    data['gender'] = gender;
    return data;
  }
}

class Diagnosis {
  String? diagnosis;
  String? remark;

  Diagnosis({this.diagnosis, this.remark});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    diagnosis = json['diagnosis'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diagnosis'] = diagnosis;
    data['remark'] = remark;
    return data;
  }
}

class Symptoms {
  String? symptoms;
  String? remark;

  Symptoms({this.symptoms, this.remark});

  Symptoms.fromJson(Map<String, dynamic> json) {
    symptoms = json['symptoms'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptoms'] = symptoms;
    data['remark'] = remark;
    return data;
  }
}

class Labtest {
  String? lab;
  String? remark;

  Labtest({this.lab, this.remark});

  Labtest.fromJson(Map<String, dynamic> json) {
    lab = json['lab'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lab'] = lab;
    data['remark'] = remark;
    return data;
  }
}

class MedicineDetails {
  String? medicineData;
  String? timeTake;
  String? toBeTaken;
  String? tablets;

  MedicineDetails(
      {this.medicineData, this.timeTake, this.toBeTaken, this.tablets});

  MedicineDetails.fromJson(Map<String, dynamic> json) {
    medicineData = json['medicineData'];
    timeTake = json['timeTake'];
    toBeTaken = json['toBeTaken'];
    tablets = json['tablets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicineData'] = medicineData;
    data['timeTake'] = timeTake;
    data['toBeTaken'] = toBeTaken;
    data['tablets'] = tablets;
    return data;
  }
}
class Notes {
  String? symptoms;
  String? remark;

  Notes(
      { this.symptoms, this.remark});

  Notes.fromJson(Map<String, dynamic> json) {
    symptoms = json['symptoms'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptoms'] = symptoms;
    data['remark'] = remark;
    return data;
  }
}
