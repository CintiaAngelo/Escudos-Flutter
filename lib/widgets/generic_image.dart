import 'package:flutter/material.dart';

class GenericImage extends StatelessWidget {
  final String imagePath;
  final double size;
  final VoidCallback? onTap;

  const GenericImage({required this.imagePath, this.size = 150, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
      ),
    );
  }
}
