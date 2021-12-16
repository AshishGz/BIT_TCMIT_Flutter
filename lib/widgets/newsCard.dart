import 'package:bit_flutter/model/news.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  late News news;

  NewsCard(News new_news) {
    news = new_news;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.source.name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500),
              ),
              Text(
                news.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              Text(
                news.description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text('2 hrs ago',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500)),
            ],
          )),
          Expanded(
            child: Image.network(
              news.urlToImage,
            ),
          ),
        ],
      ),
    );
  }
}
