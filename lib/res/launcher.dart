
import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static void launchURL(String url) async {
    print("url:$url");
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // static void openTelegram(String telegram) async {
  //   if (await canLaunchUrl(Uri.parse(telegram))) {
  //     await launchUrl(Uri.parse(telegram));
  //   } else {
  //     throw "Could not launch $telegram";
  //   }
  // }
}
