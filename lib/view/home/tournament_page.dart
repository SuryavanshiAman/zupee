import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/circular_button.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/time_page.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view/bottomsheet/tournament_bottomsheet.dart';
import 'package:zupee/view_model/confirm_payment_view_model.dart';
import 'package:zupee/view_model/contest_category_view_model.dart';
import 'package:zupee/view_model/join_view_model.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/tournament_view_moedl.dart';

class LudoSupreme extends StatefulWidget {
  const LudoSupreme({super.key});

  @override
  LudoSupremeState createState() => LudoSupremeState();
}

class LudoSupremeState extends State<LudoSupreme> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = true;
  ContestCategoryViewModel contestCategoryViewModel =
      ContestCategoryViewModel();
  bool time = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      contestCategoryViewModel.contestCategoryApi(context);
      final tournamentViewModel =
          Provider.of<TournamentViewModel>(context, listen: false);
      tournamentViewModel.tournamentApi(context, "1");
    });
    time = false;
  }


  void _handleScroll() {
    setState(() {
      if (_scrollController.position.pixels > 100) {
        _showTitle = false;
      } else {
        _showTitle = true;
      }
    });
  }

  bool nextPage = true;
  int setTime = 0;

  String? futureTime;

  int selectedIndices = 1;
  String tournamentID = "0";
  String entry = "0";
  String prizePool = "0";
  late StreamSubscription<ConnectivityResult> _subscription;
  @override
  Widget build(BuildContext context) {
    final tournament = Provider.of<TournamentViewModel>(context);
    final confirmPayment = Provider.of<ConfirmPaymentViewModel>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final ludoProvider = Provider.of<LudoProvider>(context);
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          ludoProvider.setConnection(false);
        });
      } else {
        setState(() {
          ludoProvider.setConnection(true);
        });
      }
    });

    return Scaffold(
      backgroundColor: appBarColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                bottom: PreferredSize(
                  preferredSize: const Size(300.0, 100.0),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: appBarColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      height: height * 0.095,
                      child: ChangeNotifierProvider<ContestCategoryViewModel>(
                        create: (BuildContext context) =>
                            contestCategoryViewModel,
                        child: Consumer<ContestCategoryViewModel>(
                          builder: (context, categoryValue, _) {
                            switch (
                                categoryValue.contestCategoriesList.status) {
                              case Status.LOADING:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case Status.ERROR:
                                return Container();
                              case Status.COMPLETED:
                                final category = categoryValue
                                    .contestCategoriesList.data!.data;
                                if (category != null && category.isNotEmpty) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: category.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              print("${category[index].id.toString()}");
                                              selectedIndices = int.parse(category[index].id.toString());
                                              tournament.tournamentApi(context,
                                                  selectedIndices.toString());
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(13.0),
                                                child: Container(
                                                    // height: height * 0.045,
                                                    padding:
                                                        const EdgeInsets.all(9),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            selectedIndices ==
                                                                int.parse(category[index].id.toString())
                                                                ? secondary
                                                                : white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                        child: Text(
                                                      category[index].name!.tr,
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: black),
                                                    ))),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                    child: Text(
                                      "No Deposit History Found!",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  );
                                }
                              default:
                                return Container();
                            }
                          },
                        ),
                      )),
                ),

                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: !_showTitle ? black : white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                title: !_showTitle
                    ? const Text(
                        " Ludo Supreme",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )
                    : const Text(""),
                // centerTitle: true,
                backgroundColor: _showTitle ? blue : Colors.white,
                pinned: true,
                snap: false,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                    // collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    background: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: height * 0.12,
                              width: width * 0.3,
                              child: Image.asset(
                                Assets.imagesLudoSupreem,
                                fit: BoxFit.fill,
                              )),
                          SizedBox(
                            width: width * 0.25,
                          ),
                          Image(
                            image: const AssetImage(
                              Assets.imagesVideo,
                            ),
                            height: height * 0.07,
                          )
                        ],
                      ),
                    )),
                expandedHeight: 250,
                actions: [
                  _showTitle
                      ? Icon(
                          Icons.notifications_none,
                          color: _showTitle ? Colors.white : tertiary,
                          size: 35,
                        )
                      : Container(),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Text(
                        "₹${profileViewModel.profileResponse?.data?.wallet ?? ""}",
                        style: TextStyle(
                            color: _showTitle ? tertiary : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
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
                      _showTitle
                          ? Assets.imagesRupeesWhite
                          : Assets.imagesRupeesBlue,
                      scale: 2.5,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                ],
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommended Tournaments".tr,
                        style: TextStyle(
                            fontSize: width * 0.05,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: height * 0.03),
                      time
                          ? Container(
                              height: height * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.hourglass_empty,
                                      color: Colors.green, size: 50),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Game starting in...'.tr,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    decoration: const BoxDecoration(
                                      color: green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                    ),
                                    child: CountdownTimer(
                                      futureTime: futureTime,
                                      onTimerTick: (int value) {
                                        // _updateTimerValue(value, context);
                                      },
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(
                                    color: green,
                                  ),
                                  Text(
                                    '4 PLAYERS • 2 WINNERS • ₹16 Prize'.tr,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Consumer<TournamentViewModel>(
                        builder: (context, tournamentValue, _) {
                          switch (tournamentValue.tournamentList.status) {
                            case Status.LOADING:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case Status.ERROR:
                              return Container();
                            case Status.COMPLETED:
                              final tournament =
                                  tournamentValue.tournamentList.data!.data;
                              if (tournament != null && tournament.isNotEmpty) {
                                return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: tournament.length,
                                    itemBuilder: (context, index) {
                                      futureTime = tournament[index]
                                          .tournamentStarttime
                                          .toString();
                                      return Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          elevation: 5,
                                          child: InkWell(
                                            onTap: () {
                                              confirmPayment
                                                  .confirmPaymentApi(
                                                      context,
                                                      tournament[index]
                                                          .id
                                                          .toString())
                                                  .then((_) {
                                                Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  confirmPayment
                                                              .confirmPaymentResponse
                                                              ?.balanceStatus !=
                                                          1
                                                      ? _showBottomSheet(
                                                          context)
                                                      : confirmPaymentBottomSheet(
                                                          context);
                                                });
                                              });

                                              tournamentID = tournament[index]
                                                  .id
                                                  .toString();
                                              ludoProvider.setTournamentID(
                                                  tournament[index]
                                                      .id
                                                      .toString());
                                              ludoProvider.setPrizePool(
                                                  tournament[index]
                                                      .winPrize
                                                      .toString());
                                              entry = tournament[index]
                                                  .amount
                                                  .toString();
                                              prizePool = tournament[index]
                                                  .winPrize
                                                  .toString();
                                              ludoProvider.setPlayerQuantity(
                                                  int.parse(tournament[index]
                                                      .playerNo
                                                      .toString()));
                                            },
                                            child: Container(
                                              height: height * 0.18,
                                              decoration: const BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: height * 0.04,
                                                    width: width,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    decoration: const BoxDecoration(
                                                        color: lightBlue,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .people_outline,
                                                              color:
                                                                  Colors.black,
                                                              size: 18,
                                                            ),
                                                            Text(
                                                                "${tournament[index].playerNo}+",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                        Text(
                                                            "${tournament[index].playerNo} PLAYERS.${tournament[index].winnerNo}WINNER",
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Text(
                                                            tournament[index]
                                                                .contestName!
                                                                .tr,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.03,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: width * 0.04,
                                                        right: width * 0.07),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("PRIZE POOL".tr,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    labelColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500
                                                                // fontWeight: FontWeight.bold
                                                                )),
                                                        Text("ENTRY".tr,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    labelColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: height * 0.05,
                                                          width: width * 0.3,
                                                          decoration: BoxDecoration(
                                                              color: lightBlue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Center(
                                                            child: Text(
                                                                "₹${tournament[index].winPrize.toString()}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color:
                                                                        black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                            height:
                                                                height * 0.02,
                                                            width: width * 0.2,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    lightBlue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .watch_later_outlined,
                                                                  color: red,
                                                                  size: 12,
                                                                ),
                                                                CountdownTimer(
                                                                  futureTime: tournament[
                                                                          index]
                                                                      .tournamentStarttime
                                                                      .toString(),
                                                                  onTimerTick: (int
                                                                      value) {},
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 10,
                                                                  color: red,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Shimmer.fromColors(
                                                              baseColor:
                                                                  secondary,
                                                              highlightColor:
                                                                  Colors.grey[
                                                                      100]!,
                                                              child: Container(
                                                                height: height *
                                                                    0.05,
                                                                width:
                                                                    width * 0.3,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .blue, // Replace with your secondary color
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25)),
                                                                ),
                                                              ),
                                                            ),
                                                            CustomContainer(
                                                              onTap: () {
                                                                confirmPayment
                                                                    .confirmPaymentApi(
                                                                        context,
                                                                        tournament[index]
                                                                            .id
                                                                            .toString())
                                                                    .then((_) {
                                                                  Future.delayed(
                                                                      const Duration(
                                                                          seconds:
                                                                              1),
                                                                      () {
                                                                    confirmPayment.confirmPaymentResponse?.balanceStatus !=
                                                                            1
                                                                        ? _showBottomSheet(
                                                                            context)
                                                                        : confirmPaymentBottomSheet(
                                                                            context);
                                                                  });
                                                                });

                                                                tournamentID =
                                                                    tournament[
                                                                            index]
                                                                        .id
                                                                        .toString();
                                                                ludoProvider.setTournamentID(
                                                                    tournament[
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                                ludoProvider.setPrizePool(
                                                                    tournament[
                                                                            index]
                                                                        .winPrize
                                                                        .toString());
                                                                entry = tournament[
                                                                        index]
                                                                    .amount
                                                                    .toString();
                                                                prizePool = tournament[
                                                                        index]
                                                                    .winPrize
                                                                    .toString();
                                                                ludoProvider.setPlayerQuantity(
                                                                    int.parse(tournament[
                                                                            index]
                                                                        .playerNo
                                                                        .toString()));
                                                              },
                                                              height:
                                                                  height * 0.05,
                                                              widths:
                                                                  width * 0.3,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            25)),
                                                              ),
                                                              child: Text(
                                                                "₹${tournament[index].amount.toString()}",
                                                                style:
                                                                    const TextStyle(
                                                                  color:
                                                                      tertiary, // Replace with your tertiary color
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return const Center(
                                  child: Text(
                                    "No  Found!",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                );
                              }
                            default:
                              return const Center(
                                child: Text(
                                  "No Tournament Found!",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              );
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text("Other Tournaments".tr,
                          style: TextStyle(
                              fontSize: width * 0.05,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Consumer<TournamentViewModel>(
                          builder: (context, tournamentValue, _) {
                            switch (tournamentValue.tournamentList.status) {
                              case Status.LOADING:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case Status.ERROR:
                                return Container();
                              case Status.COMPLETED:
                                final tournament =
                                    tournamentValue.tournamentList.data!.data;
                                if (tournament != null &&
                                    tournament.isNotEmpty) {
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: tournament.length,
                                      itemBuilder: (context, index) {
                                        futureTime = tournament[index]
                                            .tournamentStarttime
                                            .toString();
                                        return Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            elevation: 5,
                                            child: InkWell(
                                              onTap: () {
                                                confirmPaymentBottomSheet(
                                                    context);
                                                confirmPayment
                                                    .confirmPaymentApi(
                                                        context,
                                                        tournament[index]
                                                            .id
                                                            .toString());
                                                tournamentID = tournament[index]
                                                    .id
                                                    .toString();
                                                ludoProvider.setTournamentID(
                                                    tournament[index]
                                                        .id
                                                        .toString());
                                                ludoProvider.setPrizePool(
                                                    tournament[index]
                                                        .winPrize
                                                        .toString());
                                                entry = tournament[index]
                                                    .amount
                                                    .toString();
                                                prizePool = tournament[index]
                                                    .winPrize
                                                    .toString();
                                              },
                                              child: Container(
                                                height: height * 0.18,
                                                decoration: const BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: height * 0.04,
                                                      width: width,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration: const BoxDecoration(
                                                          color: lightBlue,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .people_outline,
                                                            color: Colors.black,
                                                            size: 18,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          Text(
                                                              "${tournament[index].playerNo}+",
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black)),
                                                          SizedBox(
                                                            width: width * 0.16,
                                                          ),
                                                          Text(
                                                              tournament[index]
                                                                  .contestName!
                                                                  .tr,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.03,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04,
                                                          right: width * 0.07),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("PRIZE POOL".tr,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      labelColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500
                                                                  // fontWeight: FontWeight.bold
                                                                  )),
                                                          Text("ENTRY".tr,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      labelColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height:
                                                                height * 0.05,
                                                            width: width * 0.3,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    lightBlue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Center(
                                                              child: Text(
                                                                  "₹${tournament[index].winPrize.toString()}",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Container(
                                                              height:
                                                                  height * 0.02,
                                                              width:
                                                                  width * 0.2,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      lightBlue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .watch_later_outlined,
                                                                    color: red,
                                                                    size: 12,
                                                                  ),
                                                                  CountdownTimer(
                                                                    futureTime: tournament[
                                                                            index]
                                                                        .tournamentStarttime
                                                                        .toString(),
                                                                    onTimerTick:
                                                                        (int
                                                                            value) {},
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        10,
                                                                    color: red,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Shimmer.fromColors(
                                                                baseColor:
                                                                    secondary,
                                                                highlightColor:
                                                                    Colors.grey[
                                                                        100]!,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.05,
                                                                  width: width *
                                                                      0.3,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .blue, // Replace with your secondary color
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(25)),
                                                                  ),
                                                                ),
                                                              ),
                                                              CustomContainer(
                                                                onTap: () {
                                                                  confirmPayment
                                                                      .confirmPaymentApi(
                                                                          context,
                                                                          tournament[index]
                                                                              .id
                                                                              .toString())
                                                                      .then(
                                                                          (_) {
                                                                    Future.delayed(
                                                                        const Duration(
                                                                            seconds:
                                                                                1),
                                                                        () {
                                                                      confirmPayment.confirmPaymentResponse?.balanceStatus !=
                                                                              1
                                                                          ? _showBottomSheet(
                                                                              context)
                                                                          : confirmPaymentBottomSheet(
                                                                              context);
                                                                    });
                                                                  });

                                                                  tournamentID =
                                                                      tournament[
                                                                              index]
                                                                          .id
                                                                          .toString();
                                                                  ludoProvider.setTournamentID(
                                                                      tournament[
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                  ludoProvider.setPrizePool(tournament[
                                                                          index]
                                                                      .winPrize
                                                                      .toString());
                                                                  entry = tournament[
                                                                          index]
                                                                      .amount
                                                                      .toString();
                                                                  prizePool = tournament[
                                                                          index]
                                                                      .winPrize
                                                                      .toString();
                                                                  ludoProvider.setPlayerQuantity(int.parse(tournament[
                                                                          index]
                                                                      .playerNo
                                                                      .toString()));
                                                                },
                                                                height: height *
                                                                    0.05,
                                                                widths:
                                                                    width * 0.3,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25)),
                                                                ),
                                                                child: Text(
                                                                  "₹${tournament[index].amount.toString()}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        tertiary, // Replace with your tertiary color
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                    child: Text(
                                      "No  Found!",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  );
                                }
                              default:
                                return const Center(
                                  child: Text(
                                    "No Tournament Found!",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                );
                            }
                          },
                        ),
                      ),
                    ]),
              ))
            ],
          ),
          ludoProvider.isConnected
              ? Container()
              : InkWell(
                  onTap: () {},
                  child: Container(
                    height: height,
                    width: width,
                    color: black.withOpacity(0.2),
                  ),
                ),
        ],
      ),
    );
  }

  void sendJsonDataToFirebase(Map<String, dynamic> jsonData) async {
    CollectionReference ludoCollection =
        FirebaseFirestore.instance.collection('ludo');
    await ludoCollection.add(jsonData).then((docRef) {}).catchError((error) {});
  }

  bool _isExpanded = false;
  void confirmPaymentBottomSheet(BuildContext context) async {
    final confirmPayment =
        Provider.of<ConfirmPaymentViewModel>(context, listen: false)
            .confirmPaymentResponse;

    final join = Provider.of<JoinViewModel>(context, listen: false);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.cancel_outlined,
                        size: 30, color: black)),
                const Center(
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: appBarColor,
                      child: Center(
                          child: Image(
                              image: AssetImage(Assets.imagesRupeesBlue)))),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Confirm Payment'.tr,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 18.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Entry Fee'.tr,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Text(entry,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          InkWell(
                              onTap: () {
                                setModalState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Icon(_isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more))
                        ],
                      ),
                      if (_isExpanded)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              const Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('From Bonus'.tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                        Text(
                                          'From Cashback'.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: labelColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 8),
                                        Text('From Winning & Deposits'.tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            '₹${confirmPayment?.deductions?.bonus ?? "0"}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                        // const SizedBox(height: 8),
                                        Text(
                                            ' ₹${confirmPayment?.deductions?.cashback ?? "0"}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                        const SizedBox(height: 8),
                                        Text(
                                            '₹${confirmPayment?.deductions?.depositWinning ?? "0"}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Entry Fee Breakdown'.tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                          'To Prize Pool'.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor),
                                        ),
                                        const SizedBox(height: 8),
                                        Text('To Platform Fee'.tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.2,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('',
                                            style: TextStyle(fontSize: 16)),
                                        Text(' ₹0.8',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                        SizedBox(height: 8),
                                        Text('₹0.2',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: labelColor)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                join.loading == false
                    ? Center(
                        child: CustomContainer(
                          onTap: () async {
                            final ludoProvider = Provider.of<LudoProvider>(
                                context,
                                listen: false);
                            setState(() {
                              nextPage = false;
                              time = true;
                              ludoProvider.setStatus(true);
                            });
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showModalBottomSheet(
                                elevation: 5,
                                backgroundColor: primary,
                                isDismissible: false,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35),
                                        topRight: Radius.circular(35))),
                                context: context,
                                builder: (context) {
                                  return TournamentBottomsheet(
                                      futureTime: futureTime);
                                },
                              );
                            });
                            ludoProvider.addMember(context);
                          },
                          alignment: Alignment.center,
                          height: height * 0.07,
                          widths: width * 0.8,
                          color: secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(35)),
                          child: Text(
                            "Join Now".tr,
                            style: const TextStyle(
                                fontSize: 16,
                                color: tertiary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : CircularButton(),
              ],
            ),
          );
        });
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.cancel_outlined,
                      size: 30, color: black)),
              const Center(
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: appBarColor,
                    child: Center(
                        child:
                            Image(image: AssetImage(Assets.imagesRupeesBlue)))),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Insufficient balance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Please add money to register for the selected tournament.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: CustomContainer(
                  onTap: () async {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.depositScreen);
                  },
                  alignment: Alignment.center,
                  height: height * 0.07,
                  widths: width * 0.8,
                  color: secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                  child: Text(
                    "Add Cash".tr,
                    style: const TextStyle(
                        fontSize: 16,
                        color: tertiary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
