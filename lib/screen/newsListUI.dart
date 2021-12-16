import 'package:bit_flutter/model/news.dart';
import 'package:bit_flutter/screen/newsDetails.dart';
import 'package:bit_flutter/widgets/newsCard.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  late List<News> news;
  bool isLoading = true;

  NewsList(this.news, this.isLoading);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView(
        children: [
          ...news.map((e) => InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewsDetails()));
              },
              child: NewsCard(e))),
        ],
      );
    }
  }
}
