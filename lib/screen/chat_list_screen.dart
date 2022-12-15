// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mychat/components/friends_list_tile.dart';
import 'package:mychat/screen/chat_screen.dart';
import 'package:mychat/services/auth_service.dart';
import 'package:mychat/services/database_service.dart';
import 'package:mychat/services/provider_service.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  static const String id = 'ChatList';

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  AuthServices authServices = AuthServices();
  DataBaseServices dataBaseServices = DataBaseServices();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController groupNameController = TextEditingController();
  User? loggedInUser;
  String currentUserEmail = '';

  void getLoginUser() async {
    loggedInUser = await FirebaseAuth.instance.currentUser;
    if (loggedInUser != null) {
      currentUserEmail = loggedInUser!.email!;
    }
  }

  @override
  void initState() {
    super.initState();
    getLoginUser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer<ProviderService>(
      builder: (context, providerData, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.8,
            titleSpacing: 0.06 * width,
            title: Text(
              'Chat List',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 0.07 * width,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  authServices.signOutUser(context);
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: height * 0.05,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: firebaseFirestore
                  .collection('chats')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Unable to load chats'),
                  );
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  providerData.chats = snapshot.data!.docs;

                  return Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: providerData.chats.length,
                        itemBuilder: (context, index) {
                          return FriendsListTile(
                            width: providerData.getScreenWidth(context),
                            height: providerData.getScreenWidth(context),
                            lastName: providerData.chats[index]['groupName']
                                .substring(0, 1),
                            fullName: providerData.chats[index]['groupName'],
                            lastMessage: providerData.chats[index]
                                        ['last user'] ==
                                    ''
                                ? ''
                                : providerData.chats[index]
                                            ['last user email'] ==
                                        currentUserEmail
                                    ? 'Me : ${providerData.chats[index]["last message"]}'
                                    : '${providerData.chats[index]["last user"]} : ${providerData.chats[index]["last message"]}',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    userId: providerData.chats[index]['id'],
                                    userName: providerData.chats[index]
                                        ['groupName'],
                                  ),
                                ),
                              );
                            },
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        '채팅방 나가기',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text('나가기를하면 모든 대화내용이 삭제됩니다.'),
                                      actions: [
                                        TextButton(
                                          child: Text('취소'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: Text('나가기'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            dataBaseServices.delete(
                                                context, index);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                )),
                          );
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  return Container(
                    height: providerData.getScreenHeight(context) - 130,
                    child: Center(
                      child: Text(
                        'Create a new chat',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.06,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: providerData.getScreenHeight(context) - 130,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showGroupAddAlert(context);
            },
            child: Icon(
              Icons.add,
              size: height * 0.06,
            ),
          ),
        );
      },
    );
  }

  showGroupAddAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () async {
        if (groupNameController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('제목을 입력해주세요'),
            duration: Duration(seconds: 1),
          ));
        } else if (groupNameController.text.isNotEmpty) {
          await dataBaseServices.addChatRoom(
              groupName: groupNameController.text,
              time: DateFormat('yyyy MM dd, hh:mm:ss a MMM E')
                  .format(DateTime.now()));

          Navigator.pop(context);
          groupNameController.clear();
        }
      },
      child: Text(
        'Add',
        style: TextStyle(
          color: Colors.lightBlueAccent,
        ),
      ),
    );
    AlertDialog alertDialog = AlertDialog(
      title: Text('New Community'),
      content: TextFormField(
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        controller: groupNameController,
        decoration: InputDecoration(
          isDense: true,
          focusColor: Colors.black,
          hintText: 'Enter new community name',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }
}
