import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_colors.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widget.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class ArticleCardWidget extends StatelessWidget {
  final Articles articles;
  const ArticleCardWidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(
          context,
        ).pushNamed(AppRoutes.articleDetailsScreen, extra: articles);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 238.w,
                    child: Text(
                      articles.title ?? "",
                      style: AppTextStyles.black18Medium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const HeightSpace(8),
                  SizedBox(
                    width: 238.w,
                    child: Text(
                      "${articles.author}  .  ${DateFormat('yyyy-MM-dd').format(DateTime.parse(articles.publishedAt ?? DateTime.now().toString()))}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl:
                    articles.urlToImage ??
                    'https://ichef.bbci.co.uk/images/ic/1200x675/p0gdcnjt.jpg',
                height: 80,
                width: 112,
                fit: BoxFit.cover,

                // أثناء التحميل
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                // لو التحميل انتهى وفشل (404 / bad url)
                errorWidget: (context, url, error) => Image.network(
                  'https://ichef.bbci.co.uk/images/ic/1200x675/p0gdcnjt.jpg', // صورة بديلة من الـ assets
                  height: 80,
                  width: 112,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
