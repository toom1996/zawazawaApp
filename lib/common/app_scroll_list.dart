import 'package:flutter/material.dart';
import 'package:z/common/app_scroll_list_attach.dart';
import 'package:dio/dio.dart';

class ScrollList extends StatefulWidget {

  @override
  _ScrollListState createState() => _ScrollListState();
}

class _ScrollListState extends State<ScrollList> {
  ScrollController _scrollController = new ScrollController();
  int _pageNum = 0;
  int _pageSize = 20;
  List _newList = [];
  bool flag = true; //默认可以请求

  @override
  void initState() {
    super.initState();
    //初始化数据
    _getData();
  }

  void _getData() async {
    if (flag) {
      String url =
          "http://c.m.163.com/nc/article/headline/T1348647909107/0-20.html";
      Response response = await Dio().get(url);
      List list = response.data['T1348647909107'];
      setState(() {
        _newList.addAll(list);
      });
      if (list.length < 20) {
        setState(() {
          flag = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView.builder(
          itemCount: _newList.length,
          itemBuilder: (context, index) {
            if (index == _newList.length - 1) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      _newList[index]['title'],
                      maxLines: 1,
                    ),
                    leading: Image.network(
                      _newList[index]['imgsrc'],
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                    subtitle: Text(_newList[index]['ltitle']),
                  ),
                  Divider(),
                  _getMoreWidget()
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      _newList[index]['title'],
                      maxLines: 1,
                    ),
                    leading: Image.network(
                      _newList[index]['imgsrc'],
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                    subtitle: Text(_newList[index]['ltitle']),
                  ),
                  Divider(),
                ],
              );
            }
          },
          controller: _scrollController,
        )
    );
  }

  //返回一个圈
  Widget _getMoreWidget() {
    if (flag) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '加载中...',
                style: TextStyle(fontSize: 16.0),
              ),
              CircularProgressIndicator(
                strokeWidth: 1.0,
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text("---已经到底啦---"),
      );
    }
  }
}
