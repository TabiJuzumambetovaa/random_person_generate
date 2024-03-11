import 'package:flutter/material.dart';
import 'package:flutter_person_practice/theme/app_colors.dart';
import 'package:flutter_person_practice/theme/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElButton extends StatelessWidget {
  const ElButton({
    super.key,
    required this.onPressed
  });
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(328.w, 48.w),
          backgroundColor: AppColors.buttonColor
        ),
        onPressed: onPressed,
        child: Text(
          "Get location",
          style: AppFonts.w500s16.copyWith(color: AppColors.white),
        ));
  }
}

