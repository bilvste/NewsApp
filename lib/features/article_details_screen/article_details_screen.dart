import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_colors.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widget.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Articles article;
  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.pop(context);
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Icon(Icons.arrow_back, color: AppColors.white, size: 32.h),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: AppColors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: Stack(
          children: [
            SizedBox(
              width: 430.w,
              height: 316.h,
              child: CachedNetworkImage(
                imageUrl:
                    article.urlToImage ??
                    'https://ichef.bbci.co.uk/images/ic/1200x675/p0gdcnjt.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 290.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? "",
                      style: AppTextStyles.black18Medium,
                    ),
                    HeightSpace(12),
                    Text(
                      "${article.author}  .  ${DateFormat('yyyy-MM-dd').format(DateTime.parse(article.publishedAt ?? DateTime.now().toString()))}",
                      style: AppTextStyles.black14w400,
                    ),
                    HeightSpace(24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          article.description ?? "",
                          style: AppTextStyles.black16w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
