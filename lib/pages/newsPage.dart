import 'package:flutter/material.dart';
import 'package:news/model/article_model.dart';
import 'package:news/newsCard.dart';

class NewsPage extends StatelessWidget {
  final ArticleModel? article;

  NewsPage(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    article!.urlToImage ??
                        "https://media.istockphoto.com/id/1390033645/photo/world-news-background-which-can-be-used-for-broadcast-news.jpg?b=1&s=170667a&w=0&k=20&c=glqFWZtWU4Zqyxd8CRu5_Or81zqwe7cyhturXaIFEOA=",
                    errorBuilder: (context, error, stackTrace) => Image.network(
                      "https://media.istockphoto.com/id/1390033645/photo/world-news-background-which-can-be-used-for-broadcast-news.jpg?b=1&s=170667a&w=0&k=20&c=glqFWZtWU4Zqyxd8CRu5_Or81zqwe7cyhturXaIFEOA=",
                      width: 1000,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    width: 1000,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 3.0,
                    left: 3.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Text(
                        getTimeAgo(article!.publishedAt),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      article!.title!,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      article!.description!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
