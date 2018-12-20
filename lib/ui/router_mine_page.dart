import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/utils/routes_util.dart';

class MineRoutePage extends StatefulWidget {
  MineRoutePage({Key key}) : super(key: key);

  @override
  _MineRoutePageState createState() => _MineRoutePageState();
}

class _MineRoutePageState extends State<MineRoutePage> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.indigo[700]]), //背景渐变
                color: Colors.indigo,
                boxShadow: [
                  BoxShadow(
                      color: Colors.indigo[300],
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ],
              ),
              padding: EdgeInsets.only(top: 80.0),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      "images/avastar.jpg",
                      width: 100.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      "SyShare",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        height: 1.2,
                        fontFamily: "Courier",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.all(10.0),
              //容器外补白
              constraints: BoxConstraints.tightFor(
                  width: double.infinity, height: 350.0),
              //卡片大小
              decoration: BoxDecoration(
                  //背景装饰
                  gradient: RadialGradient(
                      //背景径向渐变
                      colors: [Colors.white, Colors.white],
                      center: Alignment.topLeft,
                      radius: .98),
                  boxShadow: [
                    //卡片阴影
                    BoxShadow(
                        color: Colors.indigo[300],
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0)
                  ]),
              alignment: Alignment.center,
              //卡片内文字居中
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text("应用介绍"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text("作者:SyShare"),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "CSDN主页: "),
                    TextSpan(
                        text: "https://blog.csdn.net/syb001chen",
                        style: TextStyle(color: Colors.blue),
                        recognizer: _tapGestureRecognizer..onTap = () {
                          RouteUtil.route2Web(context, "CSDN主页", "https://blog.csdn.net/syb001chen");
                        }),
                  ])),
                  Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "GitHub主页: "),
                    TextSpan(
                        text: "https://github.com/SyShare",
                        style: TextStyle(color: Colors.blue),
                        recognizer: _tapGestureRecognizer..onTap = () {
                          RouteUtil.route2Web(context, "GitHub主页:", "https://github.com/SyShare");
                        }),
                  ])),
                ],
              ),
            ),

//            Expanded(
//              child: DecoratedBox(
//                decoration: BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                        color: Colors.white,
//                        offset: Offset(2.0, 2.0),
//                        blurRadius: 4.0)
//                  ],
//                ),
//
//                child: Column(
//                  mainAxisSize: MainAxisSize.max,
//                  children: <Widget>[
//                    Text("应用介绍"),
//                    Padding(
//                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                      child: Text("作者:SyShare"),
//                    ),
//                    Text.rich(TextSpan(children: [
//                      TextSpan(text: "CSDN主页: "),
//                      TextSpan(
//                          text: "https://blog.csdn.net/syb001chen",
//                          style: TextStyle(color: Colors.blue),
//                          recognizer: _tapGestureRecognizer..onTap = () {}),
//                    ])),
//                    Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
//                    Text.rich(TextSpan(children: [
//                      TextSpan(text: "GitHub主页: "),
//                      TextSpan(
//                          text: "https://github.com/SyShare",
//                          style: TextStyle(color: Colors.blue),
//                          recognizer: _tapGestureRecognizer..onTap = () {}),
//                    ])),
//                  ],
//                ),
//              ),
//            ),
          ],
        ));
  }
}
