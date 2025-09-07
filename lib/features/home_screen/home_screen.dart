import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_colors.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widget.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/home_screen/services/home_screen_services.dart';
import 'package:news_app/features/home_screen/widgets/article_card_widget.dart';
import 'package:news_app/features/home_screen/widgets/custom_category_item_widget.dart';
import 'package:news_app/features/home_screen/widgets/search_text_field_widget.dart';
import 'package:news_app/features/home_screen/widgets/top_headline_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("explore".tr(), style: AppTextStyles.exploreTextStyle),
        titleSpacing: 16.0.w,
        backgroundColor: AppColors.thirdColor,
        toolbarHeight: 90.h,
        actions: [
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == "en") {
                context.setLocale(const Locale("ar"));
              } else {
                context.setLocale(const Locale("en"));
              }
              AppConstants.lang = context.locale.languageCode;
            },
            icon: Icon(Icons.language),
            color: AppColors.primaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SearchTextFieldWidget(),
          ),
        ],
      ),
      body: FutureBuilder(
        future: HomeScreenServices().getTopHeadlinesArticles(),
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
                const HeightSpace(16),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 32),
                  child: SizedBox(
                    height: 32,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        CustomCategoryItemWidget(
                          title: "travel".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: "travel".tr(),
                            );
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "technology".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: "technology".tr(),
                            );
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "business".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: "business".tr(),
                            );
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "entertainment".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: "entertainment".tr(),
                            );
                          },
                        ),
                        CustomCategoryItemWidget(
                          title: "culture".tr(),
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoutes.searchResultScreen,
                              extra: "culture".tr(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const HeightSpace(24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      TopHeadlineItemWidget(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            AppRoutes.articleDetailsScreen,
                            extra: topHeadLinesModel.articles![0],
                          );
                        },
                        title: topHeadLinesModel.articles![0].title ?? "",
                        imageUrl: topHeadLinesModel.articles![0].urlToImage,
                        authorName:
                            topHeadLinesModel.articles![0].author ?? "Unknown",
                        date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(
                            topHeadLinesModel.articles![0].publishedAt ??
                                DateTime.now().toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const HeightSpace(50),
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
