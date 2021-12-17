import 'package:bit_flutter/data/datas.dart';
import 'package:flutter/material.dart';

class FlutterWidgets extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          title: Text('Widgests'),
        ),
        body: ListView(children: [
          RichText(
            text: TextSpan(
              text: 'Hello ',
              style: TextStyle(fontSize: 50, color: Colors.green),
              children: <TextSpan>[
                TextSpan(
                    text: 'bold',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                TextSpan(
                    text: ' world!',
                    style: TextStyle(
                        color:
                            isDark ? Colors.yellow.shade200 : Colors.black12)),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(
                    backgroundColor: Colors.green.shade200,
                    content: Text('Yay! A SnackBar!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Click Me ')),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 200,
              color: Colors.grey,
              child: Row(
                children: [
                  ...[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2].map(
                    (e) => Image.asset('image/download.jpeg'),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Issue ',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: TAB_BAR_DATA.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber,
                  child: Center(child: Text('Entry')),
                );
              }),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber[colorCodes[index]],
                child: Center(child: Text('Entry ${entries[index]}')),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 20,
              color: Colors.green,
            ),
          )
        ]));
  }
}
