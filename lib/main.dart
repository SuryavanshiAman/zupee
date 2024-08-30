import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:zupee/language/hindi.dart';
import 'package:zupee/res/app_constant.dart';
import 'package:zupee/test.dart';
import 'package:zupee/utils/routes.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view/Game/ludo_game_home_page.dart';
import 'package:zupee/view/Game/winner_screen.dart';
import 'package:zupee/view_model/about_view_model.dart';
import 'package:zupee/view_model/confirm_payment_view_model.dart';
import 'package:zupee/view_model/firebase_view_model.dart';
import 'package:zupee/view_model/join_view_model.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/timer_view_model.dart';
import 'package:zupee/view_model/tournament_view_moedl.dart';
import 'package:zupee/view_model/transaction_history_view_model.dart';

import 'frzi.dart';
import 'language/english.dart';
import 'view/Game/ludo_provider.dart';
import 'view_model/add_bank_details_view_model.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/deposit_view_model.dart';
import 'view_model/help_view_model.dart';
import 'view_model/contest_category_view_model.dart';
import 'view_model/profile_update_view_model.dart';
import 'view_model/update_language_view_model.dart';
import 'view_model/user_view_model.dart';
import 'view_model/view_bank_details_view_model.dart';
import 'view_model/withdraw_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
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
      ],
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
        // home:  WinnerScreen(),
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