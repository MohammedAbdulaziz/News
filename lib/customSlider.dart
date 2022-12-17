import 'package:flutter/material.dart';
import 'package:news/pages/newsPage.dart';

class CustomSlider extends StatelessWidget {
  final String title;
  final String urlToImage;
  final String publishedAt;

  const CustomSlider({
    Key? key,
    required this.title,
    required this.urlToImage,
    required this.publishedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  urlToImage,
                  fit: BoxFit.cover,
                  width: 1000.0,
                  height: 250,
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
                      title,
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
                      publishedAt,
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
    ));
  }
}
