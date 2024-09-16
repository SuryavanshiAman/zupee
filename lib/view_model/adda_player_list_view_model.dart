import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/model/player_rank_model.dart';
import 'package:zupee/repo/adda_player_list_repo.dart';
// import 'package:zupee/model/ContestCategoryModel.dart';
// import 'package:zupee/model/medical_model.dart';

import '../helper/response/api_response.dart';
import '../model/tournament_list_model.dart';
import '../repo/tournament_repo.dart';

class PlayerRankViewModel with ChangeNotifier {
  final _playerRankRepo =PlayerRankRepository();

  ApiResponse<PlayerRankModel> playerRankList = ApiResponse.loading();

  setTournamentList(ApiResponse<PlayerRankModel> response) {
    playerRankList = response;
    notifyListeners();
  }

  Future<void>tournamentApi(BuildContext context) async {

    setTournamentList(ApiResponse.loading());
    _playerRankRepo.playerRankApi().then((value) {
      if (value.status == 200) {
        setTournamentList(ApiResponse.completed(value));
      } else {
        setTournamentList(ApiResponse.completed(value));
        if (kDebugMode) {
          print('value:');
        }
      }
    }).onError((error, stackTrace) {
      setTournamentList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
