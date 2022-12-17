import 'package:flutter/material.dart';
import 'package:news/pages/newsPage.dart';

import 'model/article_model.dart';

Widget NewsCard(ArticleModel article, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 40.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsPage()),
        );
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: SizedBox(
                      height: 100,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                article.title!,
                                style: Theme.of(context).textTheme.headline2,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                getTimeAgo(article.publishedAt),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(20, -10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  article.urlToImage ??
                      "https://media.istockphoto.com/id/1390033645/photo/world-news-background-which-can-be-used-for-broadcast-news.jpg?b=1&s=170667a&w=0&k=20&c=glqFWZtWU4Zqyxd8CRu5_Or81zqwe7cyhturXaIFEOA=",
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    "https://media.istockphoto.com/id/1390033645/photo/world-news-background-which-can-be-used-for-broadcast-news.jpg?b=1&s=170667a&w=0&k=20&c=glqFWZtWU4Zqyxd8CRu5_Or81zqwe7cyhturXaIFEOA=",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String getTimeAgo(String? publishedAt) {
  DateTime publishedDate = DateTime.parse(publishedAt!);
  Duration timeDifference = DateTime.now().difference(publishedDate);

  if (timeDifference.inSeconds <= 0 ||
      (timeDifference.inSeconds > 0 && timeDifference.inMinutes == 0) ||
      (timeDifference.inMinutes > 0 && timeDifference.inHours == 0)) {
    return '${timeDifference.inMinutes} minutes ago';
  } else if (timeDifference.inHours > 0 && timeDifference.inDays == 0) {
    return '${timeDifference.inHours} hours ago';
  } else if (timeDifference.inDays > 0 && timeDifference.inDays < 7) {
    return '${timeDifference.inDays} days ago';
  } else {
    return '${timeDifference.inDays ~/ 7} weeks ago';
  }
}
