import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:zupee/repo/join_contest_repo.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

import 'firebase_view_model.dart';

class JoinViewModel with ChangeNotifier {
  final _joinRepo = JoinRepository();

  bool _loading = false;
  int documentId = 1;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

ProfileViewModel profileViewModel =ProfileViewModel();
  Future<void> joinApi(dynamic tournamentID,dynamic tableId, context) async {
    final profile = Provider.of<ProfileViewModel>(context, listen: false).profileResponse;
    final firebaseViewModel = Provider.of<FirebaseViewModel>(context, listen: false);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setLoading(true);
    Map data = {
      "userid":userId,
      "tournament_id":tournamentID,
      "table_id":tableId
    };
    print("tournament_id:$data");
    _joinRepo.joinApi(data).then((value) async{
    if (value['status'] == "200") {
      print("AAgya data");
        setLoading(false);
        profileViewModel.getProfileApi(context);
        FirebaseFirestore fireStore = FirebaseFirestore.instance;
        CollectionReference ludoCollection =
        fireStore.collection('ludo');
        bool isAdded = false;
        while (!isAdded) {
          DocumentSnapshot documentSnapshot =
              await ludoCollection.doc(documentId.toString()).get();

          if (!documentSnapshot.exists) {
            // If the document does not exist, create a new document and add the data
            print("Creating new document with ID $documentId");
            Map<String, dynamic> jsonData = {
              "1":
              '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}"}',
              "2": '',
              "3": '',
              "4": ''
            };
            await ludoCollection
                .doc(documentId.toString())
                .set(jsonData);
            isAdded = true; // Data is added, stop the loop
          } else {
            // Document exists, check for available spaces
            print(
                "Document $documentId exists, checking for available spaces");
            Map<String, dynamic>? existingData =
            documentSnapshot.data() as Map<String, dynamic>?;
            for (int i = 1; i <= 4; i++) {
              String fieldKey = i.toString();
              print(
                  "Checking field $fieldKey in document $documentId");
              if (existingData != null &&
                  (existingData[fieldKey] == '' ||
                      existingData[fieldKey] == null)) {
                print(
                    "Empty spot found at $fieldKey in document $documentId, updating...");
                await ludoCollection
                    .doc(documentId.toString())
                    .update({
                  fieldKey:
                  '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}"}'
                });
                isAdded = true; // Data is added, stop the loop
                break; // Exit the loop after updating the first empty spot
              }
            }

            if (!isAdded) {
              documentId += 1;
            }
          }
        }
        if (isAdded) {
          print("hellowAman");
          firebaseViewModel.setTable(documentId);
        }
        Utils.showSuccessToast(value['message']);
      }
      else {
        setLoading(false);
        Utils.showErrorToast(value['message']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('registerError: $error');
      }
    });
  }
}