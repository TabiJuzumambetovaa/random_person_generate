import 'package:flutter/material.dart';
import 'package:flutter_person_practice/theme/app_colors.dart';
import 'package:flutter_person_practice/theme/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFields extends StatelessWidget {
  const TextFields(
      {super.key, required this.hintText, required this.labelText,required this.controller});
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328.w,
      height: 56.h,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            fillColor: AppColors.white,
            filled: true,
            labelText: labelText,
            labelStyle: AppFonts.w400s12,
            hintText: hintText,
            hintStyle: AppFonts.w400s16),
      ),
    );
  }
}
