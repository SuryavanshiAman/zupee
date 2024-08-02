import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:zupee/language/hindi.dart';
import 'package:zupee/test.dart';
import 'package:zupee/utils/routes.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/profile_view_model.dart';

import 'language/english.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/help_view_model.dart';
import 'view_model/profile_update_view_model.dart';
import 'view_model/user_view_model.dart';

void main() {
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
        ChangeNotifierProvider(create: (_) => DiceModel()),
        ChangeNotifierProvider(create: (_) => GameState()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        translations: LocaleTranslations(),
        locale: Locale('en', 'US'), // Set the default locale
        fallbackLocale: Locale('en''US'),
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
        // home:  LudoGame(),
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