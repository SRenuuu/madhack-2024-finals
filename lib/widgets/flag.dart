import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart';

class Flag extends StatelessWidget {
  final Color backgroundColor;
  final Color triangleColor;
  final String textValue;
  final String textLabel;
  final double size;

  const Flag({
    super.key,
    this.backgroundColor = WorkWiseColors.secondaryColor,
    required this.triangleColor,
    required this.textValue,
    required this.textLabel,
    this.size = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _FlagClipper(triangleHeight: size),
      child: Container(
        width: 48,
        height: 60,
        color: backgroundColor,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 4.0),
              Text(
                textValue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                textLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlagClipper extends CustomClipper<Path> {
  final double triangleHeight;

  _FlagClipper({required this.triangleHeight});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height); // Bottom right corner (square)
    // path.lineTo(0, size.height); // Bottom left corner (square)

    path.lineTo(size.width / 2, size.height - 8); // Upward diagonal
    path.lineTo(0, size.height); // Close the path at bottom right corner

    return path;
  }

  @override
  bool shouldReclip(_FlagClipper oldClipper) =>
      oldClipper.triangleHeight != triangleHeight;
}
