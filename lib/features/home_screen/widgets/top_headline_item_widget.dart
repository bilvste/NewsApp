import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widget.dart';

class TopHeadlineItemWidget extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String authorName;
  final String date;
  final Function()? onTap;
  const TopHeadlineItemWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.authorName,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8.r),
            child: CachedNetworkImage(
              imageUrl:
                  imageUrl ??
                  'https://ichef.bbci.co.uk/images/ic/1200x675/p0gdcnjt.jpg',
              height: 206.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          HeightSpace(16),
          Text(title, style: AppTextStyles.black18Medium),
          HeightSpace(12),
          Text("$authorName  .  $date", style: AppTextStyles.black14w400),
        ],
      ),
    );
  }
}
