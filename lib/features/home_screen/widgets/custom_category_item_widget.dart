import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_colors.dart';
import 'package:news_app/core/styles/app_text_styles.dart';

class CustomCategoryItemWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const CustomCategoryItemWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.thirdColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
          backgroundColor: Colors.transparent,
        ),
        child: Text(title, style: AppTextStyles.black14Regular),
      ),
    );
  }
}
