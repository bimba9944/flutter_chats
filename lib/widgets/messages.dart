import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chats/widgets/messageBubble.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatImage: chatDocs?[index]['chatImage'],
            message: chatDocs?[index]['message'],
            isMe: chatDocs![index]['userid'] == user?.uid,
            username: chatDocs![index]['username'],
            userImage: chatDocs![index]['userimage'],
            dateOfMessage: chatDocs![index]['createdAt'],

          ),
        );
      },
    );
  }
}
