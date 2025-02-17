import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:zupee/language/hindi.dart';
import 'package:zupee/res/app_constant.dart';
import 'package:zupee/res/check_network/network_checker.dart';
import 'package:zupee/test.dart';
import 'package:zupee/utils/routes.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/about_view_model.dart';
import 'package:zupee/view_model/adda_player_list_view_model.dart';
import 'package:zupee/view_model/banner_view_model.dart';
import 'package:zupee/view_model/confirm_payment_view_model.dart';
import 'package:zupee/view_model/delete_notification_view_model.dart';
import 'package:zupee/view_model/firebase_view_model.dart';
import 'package:zupee/view_model/join_view_model.dart';
import 'package:zupee/view_model/kyc_view_model.dart';
import 'package:zupee/view_model/notification_view_model.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/send_result_view_model.dart';
import 'package:zupee/view_model/timer_view_model.dart';
import 'package:zupee/view_model/tournament_view_moedl.dart';
import 'package:zupee/view_model/transaction_history_view_model.dart';
import 'language/english.dart';
import 'view/Game/ludo_provider.dart';
import 'view_model/add_bank_details_view_model.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/deposit_view_model.dart';
import 'view_model/get_chat_view_model.dart';
import 'view_model/help_view_model.dart';
import 'view_model/contest_category_view_model.dart';
import 'view_model/profile_update_view_model.dart';
import 'view_model/refund_view_model.dart';
import 'view_model/send_chat_view_model.dart';
import 'view_model/update_language_view_model.dart';
import 'view_model/user_view_model.dart';
import 'view_model/view_bank_details_view_model.dart';
import 'view_model/view_kyc_details_view_model.dart';
import 'view_model/withdraw_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBX3NAr87DrxvDsbFBjBnbMP1QBkHamT_w",
            authDomain: "ludozupee-d8599.firebaseapp.com",
            databaseURL: "https://hopgamming-532b5-default-rtdb.firebaseio.com",
            projectId: "ludozupee-d8599",
            storageBucket: "ludozupee-d8599.appspot.com",
            messagingSenderId: "127939317909",
            appId: "1:127939317909:web:040220605e7a8a057f4b9c",
            measurementId: "G-Y63KYVV5RF"
        )
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // YoutubeLink();
  }
  else{
    await Firebase.initializeApp();}
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NetworkChecker _networkChecker;

  @override
  void initState() {
    super.initState();
    _networkChecker = NetworkChecker();
  }

  @override
  void dispose() {
    _networkChecker.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=kIsWeb?400:MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileUpdateViewModel()),
        ChangeNotifierProvider(create: (_) => HelpViewModel()),
        ChangeNotifierProvider(create: (_) => LudoProvider()),
        ChangeNotifierProvider(create: (_) => AboutViewModel()),
        ChangeNotifierProvider(create: (_) => AddBankDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => ViewBankDetailViewModel()),
        ChangeNotifierProvider(create: (_) => UpdateLanguageViewModel()),
        ChangeNotifierProvider(create: (_) => DepositViewModel()),
        ChangeNotifierProvider(create: (_) => ContestCategoryViewModel()),
        ChangeNotifierProvider(create: (_) => FirebaseViewModel()),
        ChangeNotifierProvider(create: (_) => WithdrawViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionHistoryViewModel()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => TournamentViewModel()),
        ChangeNotifierProvider(create: (_) => ConfirmPaymentViewModel()),
        ChangeNotifierProvider(create: (_) => JoinViewModel()),
        ChangeNotifierProvider(create: (_) => SendResultViewModel()),
        ChangeNotifierProvider(create: (_) => SendResultViewModel()),
        ChangeNotifierProvider(create: (_) => PlayerRankViewModel()),
        ChangeNotifierProvider(create: (_) => BannerViewModel()),
        ChangeNotifierProvider(create: (_) => SendChatViewModel()),
        ChangeNotifierProvider(create: (_) => GetChatViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => AddKycViewModel()),
        ChangeNotifierProvider(create: (_) => ViewKycDetailViewModel()),
        ChangeNotifierProvider(create: (_) => RefundViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteNotificationViewModel()),
      ],
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: width
          ),
          child: GetMaterialApp(
            title: AppConstants.appName,
            translations: LocaleTranslations(),
            locale: const Locale('en', 'US'), // Set the default locale
            fallbackLocale: const Locale('en''US'),
            debugShowCheckedModeBanner: false,
            initialRoute: RoutesName.splashScreen,
            onGenerateRoute: (settings) {
              if (settings.name != null) {
                return MaterialPageRoute(
                  builder: Routers.generateRoute(settings.name!),
                  settings: settings,
                );
              }
              return null;
            },
            builder: (context, child)  {
              return Stack(

                children: [
                  child!, // The current screen widget
                  StreamBuilder<NetworkStatus>(
                    stream: _networkChecker.networkStatusStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final status = snapshot.data;
                        if (status == NetworkStatus.noInternet || status == NetworkStatus.slowInternet) {
                          return _buildNetworkStatusOverlay(status!);
                        }
                      }
                      return const SizedBox.shrink(); // No overlay if no issue
                    },
                  ),
                ],
              );
            },
            // home:SquareProgressIndicator( secondsRemaining: 30,),
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkStatusOverlay(NetworkStatus status) {
    String message;
    Color backgroundColor;

    switch (status) {
      case NetworkStatus.noInternet:
        message = 'No internet connection';
        backgroundColor = Colors.redAccent;
        break;
      case NetworkStatus.slowInternet:
        message = 'Internet is slow';
        backgroundColor = Colors.orangeAccent;
        break;
      default:
        message = '';
        backgroundColor = Colors.transparent;
    }

    return
      Material(
      color: Colors.transparent,
      child: Container(
        height: height*0.05,
        alignment: Alignment.bottomCenter,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
class LocaleTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
  'en_US': LocaleStringEn().keys['en_US']!,
  'hi_IN': LocaleStringHi().keys['hi_IN']!,

  };
}
double height=0.0;
double width=0.0;