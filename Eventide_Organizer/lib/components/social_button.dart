import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.onTap,
    required this.iconPath,
    required this.color,
  }) : super(key: key);

  final Function() onTap;
  final String iconPath;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap;
      },
      child: Container(
        width: 170,
        height: 54,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Image.asset(iconPath),
      ),
    );
  }
}
