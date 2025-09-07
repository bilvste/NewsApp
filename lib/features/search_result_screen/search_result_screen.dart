import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_colors.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widget.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/home_screen/widgets/article_card_widget.dart';
import 'package:news_app/features/search_result_screen/services/search_result_services.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("search_result".tr(), style: AppTextStyles.black18Medium),
        backgroundColor: AppColors.white,
        toolbarHeight: 90.h,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 24.h),
          color: AppColors.primaryColor,
        ),
      ),
      body: FutureBuilder(
        future: SearchResultServices().searchItemByName(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            ArticlesModel topHeadLinesModel = snapshot.data as ArticlesModel;
            if (topHeadLinesModel.totalResults == 0) {
              return Center(child: Text("no_results".tr()));
            }
            return Column(
              children: [
                const HeightSpace(27),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: topHeadLinesModel.articles!.length - 1,
                      itemBuilder: (context, index) {
                        Articles article =
                            topHeadLinesModel.articles![index + 1];
                        return ArticleCardWidget(articles: article);
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
