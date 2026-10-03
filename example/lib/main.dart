import 'package:flutter/material.dart';
import 'package:paging/paging.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paging Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PagingExampleScreen(),
    );
  }
}

class PagingExampleScreen extends StatefulWidget {
  const PagingExampleScreen({super.key});

  @override
  State<PagingExampleScreen> createState() => _PagingExampleScreenState();
}

class _PagingExampleScreenState extends State<PagingExampleScreen> {
  static const int _count = 10;

  Future<List<String>> pageData(int previousCount) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    List<String> dummyList = [];
    if (previousCount < 30) {
      // stop loading after 30 items
      for (int i = previousCount; i < previousCount + _count; i++) {
        dummyList.add('Item $i');
      }
    }
    return dummyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination List')),
      body: Pagination<String>(
        pageBuilder: (currentSize) => pageData(currentSize),
        itemBuilder: (index, item) {
          return Container(
            color: Colors.yellow,
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 4),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(item),
          );
        },
      ),
    );
  }
}
