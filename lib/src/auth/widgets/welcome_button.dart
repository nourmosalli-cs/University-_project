import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.color,
    required this.textColor,
  });
  final String? buttonText;
  final Function()? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
          ),
        ),
        child: Text(
          buttonText!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: textColor!,
          ),
        ),
      ),
    );
  }
}
