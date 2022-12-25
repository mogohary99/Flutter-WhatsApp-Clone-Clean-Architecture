import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';


class FirstMessageSmallCurvedBubble extends StatelessWidget {
  final bool isMe;

  const FirstMessageSmallCurvedBubble({
    super.key,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(isMe),
      child: Container(
        width: 10,
        height: 15,
        decoration: BoxDecoration(
          color: isMe ? context.colorScheme.surface : Colors.white,
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final bool isMe;

  MyCustomClipper(this.isMe);

  @override
  Path getClip(Size size) {
    Path path = Path();
    return isMe
        ? myCustomRightPath(path, size)
        : senderCustomLeftPath(path, size);
  }

  Path myCustomRightPath(Path path, Size size) {
    double w = size.width;
    double h = size.height;
    path.lineTo(w - 2.5, 0);
    path.quadraticBezierTo(w, 2.5, w - 2.5, 5);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  Path senderCustomLeftPath(Path path, Size size) {
    double w = size.width;
    double h = size.height;
    path.lineTo(2.5, 0);
    path.quadraticBezierTo(0, 2.5, 2.5, 5);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
