import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/profile_view_model.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).profileResponse?.data;
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 200,
        leading: Row(
          children: [
            const CustomBackButton(),
            Text(
              "Wallet".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(18),
              height: height * 0.65,
              width: width * 0.9,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  RichText(
                    // textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Total Balance".tr,
                      style: const TextStyle(fontSize: 16, color: black),
                      children: [
                        TextSpan(
                          text: "    ⓘ",
                          style: const TextStyle(
                            color: black,
                            fontWeight: FontWeight.w900,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _showBottomSheet(context);
                            },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    profileViewModel?.wallet.toString() ?? "",
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.w700),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deposits".tr,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: labelColor),
                          ),
                          Text(
                            "₹${profileViewModel?.depositWallet.toString() ?? ""}",
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.depositScreen);
                        },
                        child: CustomContainer(
                            height: height * 0.06,
                            widths: width * 0.35,
                            color: green,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: white,
                                ),
                                Text(
                                  "Add Cash".tr,
                                  style: const TextStyle(
                                      color: white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  Divider(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Winnings".tr,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: labelColor),
                          ),
                          Text(
                            "₹${profileViewModel?.winningAmountWallet.toString() ?? ""}",
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      CustomContainer(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.withdrawScreen);
                          },
                          height: height * 0.06,
                          widths: width * 0.35,
                          color: secondary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                color: tertiary,
                              ),
                              Text(
                                "Withdraw".tr,
                                style: const TextStyle(
                                    color: tertiary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ))
                    ],
                  ),
                  Divider(
                    height: height * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cashback Reward".tr,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: labelColor),
                      ),
                       Text(
                        "₹${profileViewModel?.cashback.toString()??""}",
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.cashbackDetailsScreen);
                            },
                            child: Text(
                              "CASHBACK DETAILS".tr,
                              style: const TextStyle(
                                  // color: tertiary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    height: height * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bonus Reward".tr,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: labelColor),
                      ),
                       Text(
                        profileViewModel!.bonus.toString(),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.bonusDetailsScreen);
                            },
                            child: Text(
                              "BONUS DETAILS".tr,
                              style: const TextStyle(
                                  // color: tertiary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomContainer(
                padding: const EdgeInsets.all(15),
                height: height * 0.1,
                widths: width,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: white,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.transactionScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction History".tr,
                        style: const TextStyle(
                            // color: tertiary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 22,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
                  child: const Icon(Icons.cancel_outlined)),
              _buildListItem(
                image: Assets.imagesDeposit,
                title: 'Deposits',
                description: 'This money can be used to play tournaments.',
              ),
              _buildListItem(
                image: Assets.imagesRupeesWhite,
                title: 'Winnings',
                description:
                    'The money you have won by playing tournaments. You can withdraw this money.',
              ),
              _buildListItem(
                image: Assets.imagesCashback,
                title: 'Cashback',
                description:
                    'Earn Cashback by performing certain actions such as adding money to your wallet, completing KYC etc.',
              ),
              _buildListItem(
                image: Assets.imagesBonus,
                title: 'Bonus',
                description:
                    'Bonus can be used to unlock rewards or new features.',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(
      {required String image,
      required String title,
      required String description}) {
    return Center(
      child: ListTile(
        leading: CircleAvatar(
            radius: 30, backgroundColor: lightBlue, child: Image.asset(image)),
        // Icon(icon, color: Colors.purple),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(description,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: labelColor)),
      ),
    );
  }
}
