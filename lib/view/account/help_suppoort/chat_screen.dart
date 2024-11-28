import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/view_model/get_chat_view_model.dart';
import 'package:zupee/view_model/send_chat_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    _fetchUserId();
    Future.delayed(const Duration(milliseconds: 50), _scrollToBottom);
    Provider.of<GetChatViewModel>(context, listen: false).getChatApi(context);
    // _scrollToBottom();
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  String? userID;
  Future<void> _fetchUserId() async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setState(() {
      userID = userId; // Store the userID in the state
    });
  }

  @override
  Widget build(BuildContext context) {
    final sendMsg = Provider.of<SendChatViewModel>(context);
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 2,
        title: const Text("Chat Page"),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Consumer<GetChatViewModel>(
              builder: (context, chatValue, _){
                switch (chatValue.getChatList.status) {
                  // case Status.LOADING:
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  case Status.ERROR:
                    return Container();
                  case Status.COMPLETED:
                    final chatData = chatValue.getChatList.data!.data;
                    if (chatData != null && chatData.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: chatData.length,
                          itemBuilder: (context, index) {
                            final message = chatData[index];
                            return Align(
                              alignment: message.sernderId.toString()==userID.toString()
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color:message.sernderId.toString()==userID.toString() ? secondary : tertiary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  message.message!,
                                  style: TextStyle(
                                      color:message.sernderId.toString()==userID.toString()? Colors.black : white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "No  Found!",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      );
                    }
                  default:
                    return const Center(
                      child: Text(
                        "No Tournament Found!",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    controller: _controller,

                    contentPadding: const EdgeInsets.only(bottom: 10, left: 15),
                    label: " message...",
                    hintColor: black,
                    // border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                    fieldRadius: BorderRadius.circular(25),
                  )),
                  IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        sendMsg.sendChatApi(_controller.text, context).then((_){
                          Provider.of<GetChatViewModel>(context, listen: false).getChatApi(context);
                          Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
                        });
                        _controller.clear();
                        // _sendMessage(_controller.text);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
