import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/model/medical_model.dart';
import 'package:zupee/repo/medicin_repo.dart';

import '../helper/response/api_response.dart';

class MedicineViewModel with ChangeNotifier {
  final _medicineRepo =MedicineRepository();

  ApiResponse<MedicalModel> medicineList = ApiResponse.loading();

  setMedicineList(ApiResponse<MedicalModel> response) {
    medicineList = response;
    notifyListeners();
  }

  Future<void>medicineApi(BuildContext context ) async {
    Map data={
      "patient_id":"1",
      "doctor_id":"1"
    };
    setMedicineList(ApiResponse.loading());
    _medicineRepo.medicineApi(data).then((value) {
      if (value.success == true) {
        setMedicineList(ApiResponse.completed(value));
      } else {
        if (kDebugMode) {
          print('value:');
        }
      }
    }).onError((error, stackTrace) {
      setMedicineList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
