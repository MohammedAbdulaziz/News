import 'dart:convert';

import 'package:http/http.dart';
import 'package:news/model/article_model.dart';

class NewsRepo {
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=996d3b9978704683a3e411713be12dee";

  Future<List<ArticleModel>> fetchNews() async {
    var response = await get(Uri.parse(endPointUrl));
    var data = jsonDecode(response.body);
    List<ArticleModel> _articleModelList = [];
    if (response.statusCode == 200) {
      for (var item in data['articles']) {
        ArticleModel _articleModel = ArticleModel.fromJson(item);
        _articleModelList.add(_articleModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList;
    }
  }
}
