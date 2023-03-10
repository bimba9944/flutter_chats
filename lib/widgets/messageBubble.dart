import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats/screens/avatarImageScreen.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.username,
      required this.userImage,
      required this.chatImage,
      required this.dateOfMessage});

  final String? message;
  final bool isMe;
  final String username;
  final String userImage;
  final String? chatImage;
  final Timestamp dateOfMessage;


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[400] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(12),
                    topLeft: const Radius.circular(12),
                    bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(12),
                    bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12)),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1?.color),
                  ),
                  Text(
                    message ?? '',
                    style: TextStyle(color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1?.color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  InkWell(

                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AvatarImageScreen(chatImage!))),
                    child: Container(child: chatImage != null ? Image.network(chatImage!) : null),
                  ),
                  Text(
                    DateFormat('MM-dd-yy HH:mm').format(dateOfMessage.toDate()),
                    style: TextStyle(fontSize: 10),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AvatarImageScreen(userImage))),
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ),
          ),
        ),
      ],
    );
  }
}
