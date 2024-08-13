// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'helper/response/status.dart';
// import 'view_model/medecine_view_model.dart';
//
// class AppointmentsScreen extends StatefulWidget {
//
//
//   AppointmentsScreen({super.key});
//
//   @override
//   State<AppointmentsScreen> createState() => _AppointmentsScreenState();
// }
//
// class _AppointmentsScreenState extends State<AppointmentsScreen> {
//   MedicineViewModel medicineViewModel = MedicineViewModel();
//   @override
//   void initState() {
//     medicineViewModel.medicineApi(context);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointments'),
//       ),
//       body: ChangeNotifierProvider<MedicineViewModel>(
//         create: (BuildContext context) => medicineViewModel,
//         child: Consumer<MedicineViewModel>(
//           builder: (context, resultValue, _) {
//             switch (resultValue.medicineList.status) {
//               case Status.LOADING:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               case Status.ERROR:
//                 return Container();
//               case Status.COMPLETED:
//                 final medicineData = resultValue.medicineList.data!.data;
//                 if (medicineData != null && medicineData.isNotEmpty) {
//                   return ListView.builder(
//                     itemCount: medicineData.length,
//                     itemBuilder: (context, index) {
//                       final medicine = medicineData[index];
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding:  EdgeInsets.all(8.0),
//                             child: Text(
//                               medicine.date.toString(),
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: medicine.data!.length,
//                             itemBuilder: (context, index) {
//                               final data =medicine.data![index];
//                               return Card(
//                                 margin: const EdgeInsets.all(8.0),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: Text(
//                       "No Deposit History Found!",
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                   );
//                 }
//               default:
//                 return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper/response/status.dart';
import 'view_model/medecine_view_model.dart';

class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  MedicineViewModel medicineViewModel = MedicineViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      medicineViewModel.medicineApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: ChangeNotifierProvider<MedicineViewModel>(
        create: (BuildContext context) => medicineViewModel,
        child: Consumer<MedicineViewModel>(
          builder: (context, resultValue, _) {
            switch (resultValue.medicineList.status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.ERROR:
                return const Center(
                  child: Text(
                    "An error occurred. Please try again.",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              case Status.COMPLETED:
                final medicineData = resultValue.medicineList.data!.data;
                if (medicineData != null && medicineData.isNotEmpty) {
                  return ListView.builder(
                    itemCount: medicineData.length,
                    itemBuilder: (context, index) {
                      final dateData = medicineData[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              dateData.date.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dateData.data!.length,
                            itemBuilder: (context, subIndex) {
                              final data = dateData.data![subIndex];
                              return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Patient Name: ${data.patientName ?? 'N/A'}"),
                                      Text("Doctor Name: ${data.doctorName ?? 'N/A'}"),
                                      Text("Temperature: ${data.temperature ?? 'N/A'}"),
                                      Text("Blood Pressure: ${data.bloodPressure ?? 'N/A'}"),
                                      Text("Pulse: ${data.pulse ?? 'N/A'}"),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: data.diagnosis!.length,
                                        itemBuilder: (context, subIndex) {
                                          final diagnosis = data.diagnosis![subIndex];
                                          return Card(
                                            margin: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Diagnosis: ${diagnosis.diagnosis ?? 'N/A'}"),
                                                  Text("Remark: ${diagnosis.remark ?? 'N/A'}"),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Text("Symptoms: ${data.symptoms?.map((s) => s.symptoms).join(', ') ?? 'N/A'}"),
                                      Text("Medicines: ${data.medicineDetails?.map((m) => m.medicineData).join(', ') ?? 'N/A'}"),
                                      // Add more fields as necessary
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "No Appointment History Found!",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  );
                }
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
