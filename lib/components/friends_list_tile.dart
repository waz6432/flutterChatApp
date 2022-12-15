import 'dart:math';

import 'package:flutter/material.dart';

class FriendsListTile extends StatelessWidget {
  const FriendsListTile({
    required this.width,
    required this.height,
    this.lastName,
    this.fullName,
    this.lastMessage,
    this.onTap,
    this.trailing,
  });

  final double width;
  final double height;
  final String? lastName;
  final String? fullName;
  final String? lastMessage;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: Text(
          lastName!,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      title: Text(
        fullName!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        lastMessage!,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: trailing,
      horizontalTitleGap: 0.02 * width,
    );
  }
}
