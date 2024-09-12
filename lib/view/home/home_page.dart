import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/profile_view_model.dart';

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width * 0.08, size.height);
    path.lineTo(size.width * 0.92, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileViewModel =
          Provider.of<ProfileViewModel>(context, listen: false);
      profileViewModel.getProfileApi(context);
      _scrollController.addListener(_handleScroll);
    });
  }

  void _handleScroll() {
    setState(() {
      if (_scrollController.position.pixels > 10) {
        _showTitle = false;
      } else {
        _showTitle = true;
      }
    });
  }

  final List<String> avatars = [
    'assets/images/dice.png',
    'assets/images/instagram.png',
    'assets/images/zupee.png',
  ];

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).profileResponse?.data;
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
        expandedHeight: 40.0,
        floating: false,
        pinned: true,
        backgroundColor: _showTitle ? blue : Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.red,
        leadingWidth: 250,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "LUDO ZUPEE",
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 26,
                fontWeight: FontWeight.w900),
          ),
        ),
        actions: [
          Icon(
            Icons.notifications_none,
            color: _showTitle ? Colors.white : tertiary,
            size: 35,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.walletScreen);
            },
            child: Container(
              alignment: Alignment.center,
              height: height * 0.05,
              width: width * 0.25,
              decoration: BoxDecoration(
                  color: _showTitle ? Colors.white : tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: Text(
                profileViewModel?.wallet ?? " ",
                style: TextStyle(
                    color: _showTitle ? tertiary : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.04,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.depositScreen);
            },
            child: Image.asset(
              _showTitle ? Assets.imagesRupeesWhite : Assets.imagesRupeesBlue,
              scale: 2.5,
            ),
          ),
          SizedBox(
            width: width * 0.04,
          ),
        ],
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  width: width,
                  color: blue,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage(Assets.imagesHomeLogo),
                        height: height * 0.23,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.037,
                        width: width * 0.55,
                        decoration: BoxDecoration(
                            color: black.withOpacity(0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Stack(
                              children: avatars.asMap().entries.map((entry) {
                                int idx = entry.key;
                                String avatar = entry.value;
                                return Transform.translate(
                                  offset: Offset(idx * -12.0, 0),
                                  child: Container(
                                    width: width * 0.06,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(avatar)),
                                      border:
                                          Border.all(color: white, width: 1),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              '2,17,460 playing',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Text(
                        "Ludo Supreme",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 28),
                      ),
                      Text(
                        "Ludo in under 10 minute".tr,
                        style: const TextStyle(
                            color: labelColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: secondary,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: height * 0.06,
                              width: width * 0.5,
                              decoration: const BoxDecoration(
                                color: Colors
                                    .blue, // Replace with your secondary color
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                            ),
                          ),
                          CustomContainer(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.ludoSupreme);
                            },
                            height: height * 0.07,
                            widths: width * 0.5,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Text(
                              "Play Now".tr,
                              style: const TextStyle(
                                color:
                                    tertiary, // Replace with your tertiary color
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: height * 0.2,
                              width: width * 0.9,
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                      image: AssetImage(Assets.imagesMoneyApps),
                                      fit: BoxFit.fill),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 19.0, bottom: 15),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.05,
                                  width: width * 0.35,
                                  decoration: const BoxDecoration(
                                      color: green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: const Text("₹11 Entry"),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 48.0),
                            child: ClipPath(
                              clipper: TrapeziumClipper(),
                              child: Container(
                                alignment: Alignment.center,
                                width: width * 0.4,
                                height: height * 0.023,
                                margin: const EdgeInsets.all(5),
                                color: white,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Closes in 04h 40m'.tr,
                                    style: const TextStyle(
                                        color: green, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Complete and Get Cash".tr,
                            style: const TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "0/1 completed",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                      Container(
                        // alignment: Alignment.center,
                        height: height * 0.2,
                        width: width * 0.55,
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Get up to ₹25",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              const Text("Make 1st deposit",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.045,
                                width: width * 0.35,
                                decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                child: const Text("Deposit Now",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: tertiary)),
                              ),
                              // Text("₹11 Entry"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
          childCount: 1,
        ),
      ),
    ]));
  }
}
