import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/customSlider.dart';
import 'package:news/model/article_model.dart';
import 'package:news/newsCard.dart';
import 'package:news/repositories/news_repo.dart';
import 'package:news/repositories/egypt_news_repo.dart';
import 'newsPage.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final NewsRepo _newsRepo = NewsRepo();
  final EgyptNewsRepo _egyptNewsRepo = EgyptNewsRepo();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _newsFuture = HomePage()._newsRepo.fetchNews();
  final _egyptNewsFuture = HomePage()._egyptNewsRepo.fetchEgyptNews();
  List<ArticleModel> _articleModelList = [];
  List<ArticleModel> _articleModelEgyptList = [];
  var itemCount = 0;

  @override
  void initState() {
    super.initState();
    fetchNews();
    fetchEgyptNews();
  }

  fetchNews() async {
    var articleModelList = await HomePage()._newsRepo.fetchNews();
    setState(() {
      _articleModelList = articleModelList;
    });
  }

  fetchEgyptNews() async {
    var articleModelEgyptList =
        await HomePage()._egyptNewsRepo.fetchEgyptNews();
    setState(() {
      _articleModelEgyptList = articleModelEgyptList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20, left: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('News',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: FutureBuilder(
            future: _egyptNewsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 0.9,
                      enlargeFactor: 0.5,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: _articleModelEgyptList.map((article) {
                    return CustomSlider(
                      title: article.title!,
                      urlToImage: article.urlToImage ??
                          "https://media.istockphoto.com/id/1390033645/photo/world-news-background-which-can-be-used-for-broadcast-news.jpg?b=1&s=170667a&w=0&k=20&c=glqFWZtWU4Zqyxd8CRu5_Or81zqwe7cyhturXaIFEOA=",
                      publishedAt: getTimeAgo(article.publishedAt!),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Latest news',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30, color: Colors.black)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<List<ArticleModel>>(
            future: _newsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "An error occurred: ${snapshot.error.toString() == "Failed host lookup: 'newsapi.org'" ? "No internet connection" : "API error"}",
                      style: Theme.of(context).textTheme.headline1),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification) {
                      if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent) {
                        setState(() {
                          if (_articleModelList.length > itemCount) {
                            itemCount += 10;
                          }
                        });
                      }
                    }
                    return false;
                  },
                  child: ListView.separated(
                    itemCount: itemCount,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0),
                    itemBuilder: (context, index) {
                      if (index == itemCount) {
                        if (itemCount < _articleModelList.length) {
                          // Return the progress indicator if we are still loading new items
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          // Return the "No more news" message if we have reached the end of the list
                          return const Center(
                            child: Text("No more news"),
                          );
                        }
                      }
                      return NewsCard(_articleModelList[index], context);
                    },
                  ),
                ),
              );
            }),
        Divider(
          height: 50,
          color: Colors.grey[200],
        )
      ]),
    );
  }
}
