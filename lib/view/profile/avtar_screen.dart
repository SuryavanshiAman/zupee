import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/view/Game/ludo_provider.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({super.key});

  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  final List<String> image = [
    'assets/images/zupee.png',
    'assets/images/winner.png',
    'assets/images/bonus.png',
    'assets/images/borrowed.png',
    'assets/images/cashback.png',
    'assets/images/celebration.png',
    'assets/images/deposit.png',
    'assets/images/dice.png',
    'assets/images/downword.png',
    'assets/images/facebook.png',
    'assets/images/few_game.png',
    'assets/images/firsrt.png',
  ];
  late List<String> avatars;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    avatars = List.generate(12, (index) => image[index]);
  }

  int selectedAvatarIndex = 0;
  String selectedAvatar="";
  @override
  Widget build(BuildContext context) {
    final ludoProvider = Provider.of<LudoProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: blue,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Close the screen or go back
          },
        ),
        actions: [
          GestureDetector(
            onTap: (){
              ludoProvider.setAvatar(selectedAvatarIndex, selectedAvatar);
              Navigator.pop(context);
            },
            child: const Text('DONE',
                style: TextStyle(
                    color: blue, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            width: width * 0.03,
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: tertiary,
            child: CircleAvatar(
              radius: 97,
              backgroundImage: AssetImage(avatars[selectedAvatarIndex]),
              backgroundColor: Colors.greenAccent,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatarIndex = index;
                      selectedAvatar=avatars[index];
                      // ludoProvider.setAvatar(index, avatars[index]);
                    });
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                          height: height * 0.15,
                          width: width * 0.28,
                          child: Image.asset(avatars[index])),
                      selectedAvatarIndex == index
                          ? Container(
                              alignment: Alignment.topRight,
                              height: height * 0.15,
                              width: width * 0.28,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedAvatarIndex == index
                                        ? tertiary
                                        : Colors.transparent,
                                    width: 4,
                                  ),
                                  color: black.withOpacity(0.2)),
                              child: const Icon(
                                Icons.check_circle,
                                color: white,
                              ))
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
