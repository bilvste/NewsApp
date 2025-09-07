import 'dart:developer';

import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/networking/api_endpoints.dart';
import 'package:news_app/core/networking/dio_helper.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

class HomeScreenServices {
  getTopHeadlinesArticles() async {
    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiEndpoints.topHeadlinesEndpoint,
        query: {"apiKey": AppConstants.newApiKey, "country": "us"},
      );
      if (response.statusCode == 200) {
        ArticlesModel topHeadLinesModel = ArticlesModel.fromJson(response.data);
        log(topHeadLinesModel.totalResults.toString());
        return topHeadLinesModel;
      } else {
        log('Error: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e.toString());
    }
  }
}
