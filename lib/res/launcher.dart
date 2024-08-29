
import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  static void whatsappLaunch() async {
    var url = "https://api.whatsapp.com/text=Mai+jeet+gaya&type=phone_number&app_absent";
        // "whatsapp://send?phone="+whatsapp+"&text=hello";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  static  void launchFacebook() async {
    const fbUrl = 'https://www.facebook.com'; // Open Facebook website
    const fbAppUrl = 'fb://facewebmodal/f?href=https://www.facebook.com'; // Open Facebook app

    if (await canLaunchUrl(Uri.parse(fbAppUrl))) {
      await launchUrl(Uri.parse(fbAppUrl));
    } else if (await canLaunchUrl(Uri.parse(fbUrl))) {
      await launchUrl(Uri.parse(fbUrl));
    } else {
      throw 'Could not launch Facebook';
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
