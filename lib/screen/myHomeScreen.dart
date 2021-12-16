import 'dart:convert';

import 'package:bit_flutter/data/datas.dart';
import 'package:bit_flutter/model/news.dart';
import 'package:bit_flutter/screen/newsListUI.dart';
import 'package:bit_flutter/widgets/newsCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<News> news = [];
  bool isLoading = true;

  onGetNewsData(String catogery) async {
    news = [];
    isLoading = true;
    setState(() {});
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=$catogery&apiKey=9b017d9c85e140f58bd094de3f1b99d3');
    var response = await http.get(url);
    print(response.body);

    jsonDecode(response.body)['articles']
        .forEach((item) => news.add(News.fromJson(item)));
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    onGetNewsData('business');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TAB_BAR_DATA.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text('API Call'),
            bottom: TabBar(
              isScrollable: true,
              onTap: (e) {
                if (e == 1) {
                  onGetNewsData('sports');
                } else if (e == 2) {
                  onGetNewsData('sports');
                } else {
                  onGetNewsData('business');
                }
              },
              tabs: [
                ...TAB_BAR_DATA.map((e) => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        e['name'].toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
              ],
            ),
          ),
          body: TabBarView(
            children: [...TAB_BAR_DATA.map((e) => NewsList(news, isLoading))],
          )),
    );
  }
}
