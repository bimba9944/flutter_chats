import 'package:flutter/material.dart';

class AvatarImageScreen extends StatefulWidget {
  final String image;

  const AvatarImageScreen(this.image, {super.key});

  @override
  State<AvatarImageScreen> createState() => _AvatarImageScreenState();
}

class _AvatarImageScreenState extends State<AvatarImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          color: Colors.black,
          child: Image.network(
            widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
