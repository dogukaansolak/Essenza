import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final IconData icon;

  const ImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.icon = Icons.image_not_supported_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF3ECE6),
            Color(0xFFE9DED4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 42,
          color: const Color(0xFF8E6E53),
        ),
      ),
    );
  }
}