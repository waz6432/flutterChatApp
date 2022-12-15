import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mychat/constans.dart';
import 'package:mychat/services/database_service.dart';
import 'package:mychat/services/provider_service.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.userId, this.userName});
  final String? userId;
  final String? userName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DataBaseServices dataBaseServices = DataBaseServices();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderService>(builder: (context, providerData, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          titleSpacing: 0.0,
          title: Text(
            '${widget.userName}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore
              .collection('chats')
              .doc(widget.userId)
              .collection('messages')
              .orderBy('Time')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Unable to load chats'),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List? messages = snapshot.data!.docs;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.separated(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                          username: messages[index]['Username'],
                          message: messages[index]['Message'],
                          isMe: firebaseAuth.currentUser!.email ==
                              messages[index]['E-mail'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10.0);
                      },
                    ),
                  ),
                  Container(
                    decoration: kMessageContainerDecoration,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: kMessageTextFieldDecoration,
                            controller: messageController,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await dataBaseServices.addMessage(
                              id: widget.userId,
                              message: messageController.text,
                              time: DateFormat('yyyy MM dd, hh:mm:ss a MMM E')
                                  .format(DateTime.now()),
                              name: widget.userName,
                            );

                            messageController.clear();
                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.lightBlueAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Strat a conversation',
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: kMessageTextFieldDecoration,
                              controller: messageController,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await dataBaseServices.addMessage(
                                id: widget.userId,
                                message: messageController.text,
                                time: DateFormat('yyyy MM dd, hh:mm:ss a MMM E')
                                    .format(DateTime.now()),
                                name: widget.userName,
                              );

                              messageController.clear();
                            },
                            icon: Icon(
                              Icons.send_rounded,
                              color: Colors.lightBlueAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    });
  }
}

class MessageBubble extends StatelessWidget {
  final String? username;
  final String message;
  final bool isMe;
  const MessageBubble({
    Key? key,
    required this.username,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            minWidth: w * 0.01,
            maxWidth: w * 0.5,
          ),
          padding: EdgeInsets.only(
            left: isMe ? w * 0.03 : w * 0.02,
            right: isMe ? w * 0.02 : w * 0.03,
            top: h * 0.005,
            bottom: h * 0.01,
          ),
          decoration: BoxDecoration(
            color: isMe ? Colors.lightBlueAccent : Colors.lightBlue,
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(
                      w * 0.05,
                    ),
                  )
                : BorderRadius.only(
                    bottomRight: Radius.circular(
                      w * 0.05,
                    ),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: w * 0.01,
                  ),
                  Flexible(
                    child: Text(
                      username!,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.05,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: h * 0.012,
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: w * 0.04,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
