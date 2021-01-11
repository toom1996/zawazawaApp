import 'package:flutter/material.dart';
import 'package:z/common/app_scroll_list_attach.dart';
import 'package:dio/dio.dart';

class ScrollList extends StatefulWidget {
  List content;

  ScrollList(this.content);

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
    //上拉刷新监听器
    _scrollController.addListener(() {
      //print(_scrollController.position.pixels); //当前距离值
      //print(_scrollController.position.maxScrollExtent); //最大距离值
      //当 当前距离值>最大距离值-20的时候 进行上拉加载数据并分页
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        _getData();
        setState(() {
          _pageNum = _pageNum + 20;
          _pageSize = _pageSize + 20;
        });
      }
    });
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

  //下拉刷新->转一秒的圈 回调刷新的方法
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _newList.length > 0
            ? RefreshIndicator(
          child: ListView.builder(
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
          ),
          onRefresh: _onRefresh,
        )
            : _getMoreWidget());
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
