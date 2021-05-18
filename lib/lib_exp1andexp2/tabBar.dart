import 'package:flutter/material.dart';
import 'package:flutterappex3/dictQuery.dart';
import 'helpPage.dart';
import 'package:flutterappex3/newsByAPI.dart';
//void main() {
//  runApp(MyApp());
//}
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: '新闻浏览器'),
//    );
//  }
//}
class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
      initialIndex: 0,
      child:
      Scaffold(
        appBar: AppBar(
            leading:IconButton(
              icon: Icon(Icons.announcement),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>helpPage()));//跳转到帮助页面
              },
            ) ,
            title: Text('数据接口测试'),
            bottom: TabBar(//分页信息
              tabs: [
                Tab(text: '新闻界面',),
                Tab(text: '字典界面',),
              ],
            )
        ),
        body: TabBarView(
          children: [//各自页面的类，用于显示
            newsByApi(),
            querPage(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}