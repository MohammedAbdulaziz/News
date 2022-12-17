import 'dart:convert';

import 'package:http/http.dart';
import 'package:news/model/article_model.dart';

class EgyptNewsRepo {
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=eg&apiKey=ed33b5facac3452da9c2e416b19c44d8";

  Future<List<ArticleModel>> fetchEgyptNews() async {
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
