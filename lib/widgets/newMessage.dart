import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';


  void _sendMessage() async {
    if (_enteredMessage.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      FirebaseFirestore.instance.collection('chat').add({
        'chatImage': null,
        'message': _enteredMessage,
        'createdAt': Timestamp.now(),
        'userid': user.uid,
        'username': userData['username'],
        'userimage': userData['image_url'],
      });
      _enteredMessage = '';
      _controller.clear();
    }
    null;
  }
  late XFile _pickedImage;
  String? url;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 300,
    );
    setState(() {
      _pickedImage = pickedImage!;
    });
    final ref = FirebaseStorage.instance.ref().child('chat_images').child('${DateTime.now()}.jpg');
    await ref.putFile(File(_pickedImage!.path));
    url = await ref.getDownloadURL();
  }

  void _sendImage() async {
    if(url != ''){
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      FirebaseFirestore.instance.collection('chat').add({
        'chatImage': url,
        'message': null,
        'createdAt': Timestamp.now(),
        'userid': user.uid,
        'username': userData['username'],
        'userimage': userData['image_url'],
      });
      url = '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.isNotEmpty ? _sendMessage : _sendImage,
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: _pickImage,
            icon: Icon(
              Icons.photo_camera,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
