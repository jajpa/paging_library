library paging;

import 'package:flutter/material.dart';

class Pagination<T> extends StatefulWidget {
  Pagination({
    Key key,
    @required this.pageBuilder,
    @required this.itemBuilder,
    this.progress,
    this.onError,
  })  : assert(pageBuilder != null),
        assert(itemBuilder != null),
        super(key: key);

  final PaginationBuilder<T> pageBuilder;
  final ItemWidgetBuilder<T> itemBuilder;
  final Widget progress;
  final Function(dynamic error) onError;

  @override
  _PaginationState<T> createState() => _PaginationState<T>();
}

class _PaginationState<T> extends State<Pagination<T>> {
  final List<T> _list = List();
  bool _isLoading = false;
  bool _isEndOfList = false;

  void fetchMore() {
    if (!_isLoading) {
      _isLoading = true;
      widget.pageBuilder(_list.length).then((list) {
        _isLoading = false;
        if (list.isEmpty) {
          _isEndOfList = true;
        }
        setState(() {
          _list.addAll(list);
        });
      }).catchError((error) {
        print(error);
        if (widget.onError != null) {
          widget.onError(error);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMore();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        if (position < _list.length) {
          return widget.itemBuilder(_list[position]);
        } else if (position == _list.length && !_isEndOfList) {
          fetchMore();
          return widget.progress ??
              Align(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
        }
        return null;
      },
    );
  }
}

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);
typedef ItemWidgetBuilder<T> = Widget Function(T item);
