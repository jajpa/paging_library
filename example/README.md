# example

Example for paging library

```dart
import 'package:flutter/material.dart';
import 'package:paging/paging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Paging Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int _COUNT = 10;

  // mocking a network call
  Future<List<String>> pageData(int previousCount) async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    List<String> dummyList = List();
    if (previousCount < 30) {
      // stop loading after 30 items
      for (int i = previousCount; i < previousCount + _COUNT; i++) {
        dummyList.add('Item $i');
      }
    }
    return dummyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Pagination(
        pageBuilder: (currentListSize) => pageData(currentSize),
        itemBuilder: (index, currentListSize, item) => ListTile(title: Text(item)),
      ),
    );
  }
}
```
