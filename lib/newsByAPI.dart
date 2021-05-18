
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'News.dart';
import 'dart:convert';
import 'NewsDetail.dart';


class newsByApi extends StatefulWidget {
  @override
  _newsByApiState createState() => _newsByApiState();
}
int pageIndex=1;//翻页数，用于刷新
Future<List<News>>getDatas()async{
  final response=await http.get(Uri.parse(
      "http://api.tianapi.com/generalnews/index?key=2d356e7ab83513e2f8654cc8dcc60b79&num=10&page=${pageIndex}"));
  pageIndex+=1;
  Utf8Decoder decode=new Utf8Decoder();
  Map<String, dynamic> result=jsonDecode(decode.convert(response.bodyBytes));
  print(result);
  List<News> datas;
  datas= result['newslist'].map<News>((item)=> News.fromJson(item)).toList();
  return datas;
}
class _newsByApiState extends State<newsByApi> {
  List<News> _datas=[];
  bool _cancelConnect=false;
  void initState()
  {
    getDatas().then((List<News> datas) {
      if(!_cancelConnect)

        {
          setState(() {
            _datas=datas;
          });
        }
    }).catchError((e){
      print('获取数据出错！${e}');
    }).whenComplete((){
      print('新闻获取完毕');
    }).timeout(Duration(seconds: 5)).catchError((timeOut){
      print('超时:${timeOut}');
      _cancelConnect=true;
    });
  }
  Future _pullrefresh() async{
    _datas.clear();
    getDatas().then((List<News> datas) {
      if(!_cancelConnect)

      {
        setState(() {
          _datas=datas;
        });
      }
    }).catchError((e){
      print('获取数据出错！${e}');
    }).whenComplete((){
      print('新闻获取完毕');
    }).timeout(Duration(seconds: 5)).catchError((timeOut){
      print('超时:${timeOut}');
      _cancelConnect=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('综合新闻'),
      ),
      body:
      RefreshIndicator(
        onRefresh: _pullrefresh,
          child:Container(
            child: ListView.builder(
              itemCount: _datas.length,
              itemBuilder: (BuildContext context,int index){
                return Card(
                  color:Colors.grey[250],
                  elevation: 5.0,
                  child: Builder(
                    builder: (context)=>InkWell(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(_datas[index].picUrl as String,fit:BoxFit.fitWidth),
                          Padding(padding: const EdgeInsets.all(10.0),
                            child: Text(
                              _datas[index].title.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                            child: Text('时间:${_datas[index].ctime}',
                              style: TextStyle(fontSize: 12.0),),

                          ),
                        ],
                      ),
                      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetail(url: _datas[index].url.toString(), title: _datas[index].title.toString()))),
                    ),
                  ),
                );
              },
            ),
          ),

      ),
      floatingActionButton: FloatingActionButton(

        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}













