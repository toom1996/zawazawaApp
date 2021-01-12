import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:z/base/zawazawa_api.dart';
import 'package:z/base/zawazawa_base.dart';
import 'package:dio/dio.dart';
import 'package:z/common/app_scroll_list_attach.dart';

class ScrollList extends StatefulWidget {

  @override
  _ScrollListState createState() => _ScrollListState();
}

class _ScrollListState extends State<ScrollList> with ZawazawaBase {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
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
          ZawazawaApi.baseHost + ZawazawaApi.index;
      Response response = await Dio().get(url);
      List list = response.data['data']['list'];
      print(list);
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


  void _onRefresh() async{
    print("refresh");
    _getData();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
//                  enablePullUp: true,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Text("上拉加载");
          }
          else if(mode==LoadStatus.loading){
//                        body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("加载失败！点击重试！");
          }
          else if(mode == LoadStatus.canLoading){
            body = Text("松手,加载更多!");
          }
          else{
            body = Text("没有更多数据了!");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount:_newList.length,  //- 要生成的条数
          itemBuilder: (context, index){
            return Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
                      child: CircleAvatar(
                        radius: dp(20),
                        backgroundImage:NetworkImage(_newList[index]['avatar_url']) ,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width:dp(200),
                                            child: Text(
                                              this._newList[index]
                                              ['created_by'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey.shade500,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '1天前',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade500),
                                      ),
                                      Text(this._newList[index]['content']),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(child: ScrollListAttach(this._newList[index]['image']))

                                        ],
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          '999个查看',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.chat_bubble,
                                            color: Colors.grey.shade500,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '99',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.rotate_right,
                                            color: Colors.grey.shade500,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '99',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.grey.shade500,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '99',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.share,
                                            color: Colors.grey.shade500,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '99',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade500),
                                          ),
                                          SizedBox(width: 30)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }
      ),
    );
  }

}
