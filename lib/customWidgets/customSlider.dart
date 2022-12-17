import 'package:flutter/material.dart';
import 'package:news/model/article_model.dart';
import 'package:news/customWidgets/newsCard.dart';

class CustomSlider extends StatelessWidget {
  final ArticleModel article;

  const CustomSlider({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  article.urlToImage ??
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
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Text(
                      article.title!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Text(
                      getTimeAgo(article.publishedAt),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
