import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ChannelPageState();
  }
}

class _ChannelPageState extends State<ChannelPage> {

  //获取到插件与原生的交互通道
  static const jumpPlugin = const MethodChannel('com.syshare.act/plugin');

  static const perimissionsPlugin = const MethodChannel('com.syshare.permissions/plugin');


  _showDialog() {
    showDialog<Null>(
      context: context,
      child: new AlertDialog(content: new Text('是否前去设置未开通权限'), actions: <Widget>[
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
              _goSetting();
            },
            child: new Text('确定'))
      ]),
    );
  }



  Future<bool> _askPermission (List perimissions) async {

    bool result = await perimissionsPlugin.invokeMethod('askPermissions', perimissions);

    return result;

  }

  Future<Null> _goSetting () async {

    await perimissionsPlugin.invokeMethod('openSetting');

    return null;
  }


  Future<Null> _jumpToNative() async {
    String result = await jumpPlugin.invokeMethod('actVideo');
    print(result);
  }


  Future<Null> _jumpToNativeWithValue() async {
    String result = await jumpPlugin.invokeMethod('actVideo', "");
    print(result);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Channel"),
        centerTitle: true,
      ),
      body: new Center(
          child: new ListView(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('跳转到原生界面'),
                    onPressed: () {
                      _jumpToNative();
                    }),
              ),
              new Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10.0, right: 10.0),
                child: new RaisedButton(
                    textColor: Colors.black,
                    child: new Text('跳转到原生界面(带参数)'),
                    onPressed: () {
                      _jumpToNativeWithValue();
                    }),
              ),
              new Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10.0, right: 10.0),
                child: RaisedButton(onPressed: (){
                  _askPermission([]);
                },
                child: Text("请求权限"),),
              ),

              Padding(padding: EdgeInsets.only(
                left: 10.0,top: 10.0,right: 10.0
              ),
              child: RaisedButton(onPressed: (){
                _showDialog();
              },
              child: Text("跳转设置页面"),),)
            ],
          )
      ),
    );
  }
}
