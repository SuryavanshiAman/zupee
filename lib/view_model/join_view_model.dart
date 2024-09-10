import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:zupee/repo/join_contest_repo.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/Game/ludo_constant.dart';
import 'package:zupee/view/Game/ludo_player.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

import 'firebase_view_model.dart';

class JoinViewModel with ChangeNotifier {
  final _joinRepo = JoinRepository();

  bool _loading = false;
  int documentId = 1;
  bool get loading => _loading;
  int _fieldKey = 0;
  int get fieldKey => _fieldKey;
  setFieldKey(int value) {
    if(value==0){
      _fieldKey = value;
    }else{
    _fieldKey = value-1;}
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ProfileViewModel profileViewModel = ProfileViewModel();
  Future<void> joinApi(dynamic tournamentID, dynamic tableId, context) async {
    final profile =
        Provider.of<ProfileViewModel>(context, listen: false).profileResponse;
    final ludoProvider = Provider.of<LudoProvider>(context, listen: false);
    final firebaseViewModel =
        Provider.of<FirebaseViewModel>(context, listen: false);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setLoading(true);
    Map data = {
      "userid": userId,
      "tournament_id": tournamentID,
      "table_id": tableId
    };
    print("tournament_id:$data");
    _joinRepo.joinApi(data).then((value) async {
      if (value['status'] == "200") {
        print("AAgya data");
        setLoading(false);
        profileViewModel.getProfileApi(context);
        FirebaseFirestore fireStore = FirebaseFirestore.instance;
        CollectionReference ludoCollection = fireStore.collection('ludo');
        bool isAdded = false;
        final playerColors =  ludoProvider.players;
        final twoPlayer =(ludoProvider.playerQuantity==2);
        // while (!isAdded) {
        //   DocumentSnapshot documentSnapshot =
        //       await ludoCollection.doc(documentId.toString()).get();
        //
        //   if (!documentSnapshot.exists) {
        //     // If the document does not exist, create a new document and add the data
        //     print("Creating new document with ID $documentId");
        //     Map<String, dynamic> jsonData = {
        //       "1":
        //           '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[0].type}"}',
        //       "2": '',
        //       "3": '',
        //       "4": ''
        //     };
        //     await ludoCollection.doc(documentId.toString()).set(jsonData);
        //     setFieldKey(int.parse(1.toString()));
        //     isAdded = true; // Data is added, stop the loop
        //   } else {
        //     // Document exists, check for available spaces
        //     print("Document $documentId exists, checking for available spaces");
        //     Map<String, dynamic>? existingData =
        //         documentSnapshot.data() as Map<String, dynamic>?;
        //     for (int i = 1; i <= 4; i++) {
        //       String fieldKey = i.toString();
        //       print("Checking field $fieldKey in document $documentId");
        //       if (existingData != null &&
        //           (existingData[fieldKey] == '' ||
        //               existingData[fieldKey] == null)) {
        //         print(
        //             "Empty spot found at $fieldKey in document $documentId, updating...");
        //         await ludoCollection.doc(documentId.toString()).update({
        //           fieldKey:
        //               '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[i - 1].type}"}'
        //         });
        //         setFieldKey(int.parse(fieldKey));
        //         isAdded = true;
        //         break;
        //       }
        //     }
        //     if (!isAdded) {
        //       documentId += 1;
        //     }
        //   }
        // }
        while (!isAdded) {
          DocumentSnapshot documentSnapshot = await ludoCollection.doc(documentId.toString()).get();

          if (!documentSnapshot.exists) {
            // If the document does not exist, create a new document
            print("Creating new document with ID $documentId");

            // Create JSON data based on player quantity
            Map<String, dynamic> jsonData = twoPlayer
                ? {
              "1": '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[0].type}"}',
              "3": ''  // Leave 2nd position empty, use 3rd position
            }
                : {
              "1": '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[0].type}"}',
              "2": '',
              "3": '',
              "4": ''
            };

            await ludoCollection.doc(documentId.toString()).set(jsonData);
            setFieldKey(1);  // Set fieldKey for first position
            isAdded = true;

          } else {
            // Document exists, check for available spaces
            print("Document $documentId exists, checking for available spaces");
            Map<String, dynamic>? existingData = documentSnapshot.data() as Map<String, dynamic>?;

            if (ludoProvider.playerQuantity==2) {
              // Logic for two players: Check positions 1 and 3 only
              for (int i = 1; i <= 3; i += 2) {  // Check position 1 and 3
                String fieldKey = i.toString();
                if (existingData != null && (existingData[fieldKey] == '' || existingData[fieldKey] == null)) {
                  print("Empty spot found at $fieldKey, updating...");
                  await ludoCollection.doc(documentId.toString()).update({
                    fieldKey:
                    '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[i == 1 ? 0 : 1].type}"}'
                  });
                  setFieldKey(i);
                  isAdded = true;
                  break;
                }
              }
            } else {
              // Logic for more than 2 players: Check all positions (1-4)
              for (int i = 1; i <= 4; i++) {
                String fieldKey = i.toString();
                if (existingData != null && (existingData[fieldKey] == '' || existingData[fieldKey] == null)) {
                  print("Empty spot found at $fieldKey, updating...");
                  await ludoCollection.doc(documentId.toString()).update({
                    fieldKey:
                    '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[i - 1].type}"}'
                  });
                  setFieldKey(i);
                  isAdded = true;
                  break;
                }
              }
            }

            // If no available space, increment document ID and try again
            if (!isAdded) {
              documentId += 1;
            }
          }
        }
        if (isAdded) {
          print("hellowAman");
          firebaseViewModel.setTable(documentId);
        }
        ludoProvider.resetPawns(context, firebaseViewModel.table);
        Utils.showSuccessToast(value['message']);
      } else {
        setLoading(false);
        Utils.showErrorToast(value['message']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('joinApi: $error');
      }
    });
  }
}
