import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/model/banner_model.dart';
import 'package:zupee/repo/banner_repo.dart';

class BannerViewModel with ChangeNotifier {
  final _bannerRepo = BannerRepository();
  BannerModel? _bannerResponse;
  BannerModel? get bannerResponse => _bannerResponse;
  setBannerData(BannerModel response) {
    _bannerResponse = response;
    notifyListeners();
  }

  Future<void> bannerApi(BuildContext context) async {
    _bannerRepo.bannerApi().then((value) {
      if (value['status'] == "200") {
        BannerModel bannerModel = BannerModel.fromJson(value);
        Provider.of<BannerViewModel>(context, listen: false).setBannerData(bannerModel);
      } else {
        if (kDebugMode) {
          print('value: ${value.message}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
