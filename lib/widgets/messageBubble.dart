import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.username,
    required this.userImage,
  });

  final String message;
  final bool isMe;
  final String username;
  final String userImage;

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
                    message,
                    style: TextStyle(color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1?.color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe ? null :120,
          right: isMe ? 120: null,
          child: CircleAvatar(backgroundImage: NetworkImage(userImage),),
        ),
      ],
    );
  }
}
