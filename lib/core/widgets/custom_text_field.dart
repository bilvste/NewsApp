import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final double? width;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    this.hintText,
    this.width,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines,
    this.onFieldSubmitted,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 331.w,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        autofocus: false,
        maxLines: widget.maxLines ?? 1,
        obscureText: widget.isPassword ? _obscureText : false,
        cursorColor: AppColors.primaryColor,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          hintText: widget.hintText ?? "",
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: const Color(0xff8391A1),
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 18.w,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: const Color(0xffE8ECF4), width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    // اذا كانت كلمة المرور مخفية تظهر أيقونة العين مع خط، وإذا ظاهرة تظهر فقط العين
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xff8391A1),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
        ),
      ),
    );
  }
}
