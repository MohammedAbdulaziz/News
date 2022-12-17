import 'dart:convert';
import 'dart:collection';
import 'package:quiver/iterables.dart';
import 'package:http/http.dart';
import 'package:news/model/article_model.dart';

class NewsRepo {
  final endPointUrl1 =
      "https://newsapi.org/v2/everything?sources=bbc-news&apiKey=ed33b5facac3452da9c2e416b19c44d8";
  final endPointUrl2 =
      "https://newsapi.org/v2/everything?sources=the-next-web&apiKey=ed33b5facac3452da9c2e416b19c44d8";

  Future<List<ArticleModel>> fetchNews() async {
    // Make HTTP request to first endpoint
    var response1 = await get(Uri.parse(endPointUrl1));
    var data1 = jsonDecode(response1.body);
    List<ArticleModel> _articleModelList1 = [];
    if (response1.statusCode == 200) {
      for (var item in data1['articles']) {
        ArticleModel _articleModel = ArticleModel.fromJson(item);
        _articleModelList1.add(_articleModel);
      }
    }

    // Make HTTP request to second endpoint
    var response2 = await get(Uri.parse(endPointUrl2));
    var data2 = jsonDecode(response2.body);
    List<ArticleModel> _articleModelList2 = [];
    if (response2.statusCode == 200) {
      for (var item in data2['articles']) {
        ArticleModel _articleModel = ArticleModel.fromJson(item);
        _articleModelList2.add(_articleModel);
      }
    }

    // Combine the results from both endpoints in the desired order
    List<ArticleModel> combinedResults = [];
    for (var pair in zip([_articleModelList1, _articleModelList2])) {
      combinedResults.addAll(pair);
    }
    return combinedResults;
  }
}
