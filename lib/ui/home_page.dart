import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/common_widget/custom_toast.dart';
import 'package:flutter_study/common_widget/progress_widget.dart';
import 'package:flutter_study/localizations/examle_local.dart';
import 'package:flutter_study/utils/constants.dart';
import 'package:flutter_study/utils/event_bus.dart';
import 'package:flutter_study/ui/router_grle_page.dart';
import 'package:flutter_study/ui/router_novel_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _key = new GlobalKey<ScaffoldState>();

  //选中位置
  int _selectedIndex = 0;

  //上次点击时间
  DateTime _lastPressedAt;

  bool showLoading = false;
  bool empty = false;

  //更新选中位置
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var _body;

  void _initBody() {
    _body = IndexedStack(
      children: <Widget>[
        GrilRoutePage(),
        NovelRoutePage(),
        Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Text('Index 0: Home'),
              RaisedButton(
                onPressed: () {
                  bus.emit(Constants.EVENT_LOADING_NAME, EventLoading.show);
                },
                child: Text("showLoading"),
              ),
              RaisedButton(
                onPressed: () {
                  bus.emit(Constants.EVENT_LOADING_NAME, EventLoading.hide);
                },
                child: Text("hidingLoading"),
              ),
              RaisedButton(
                onPressed: () {
                  bus.emit(Constants.EVENT_LOADING_NAME, EventLoading.empty);
                },
                child: Text("empty"),
              ),
            ],
          ),
          alignment: Alignment.center,
        ),
      ],
      index: _selectedIndex,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bus.on(Constants.EVENT_LOADING_NAME, (arg) {
      new Future.delayed(
          Duration.zero,
          () => setState(() {
                if (arg == EventLoading.show) {
                  showLoading = true;
                  empty = false;
                } else if (arg == EventLoading.empty) {
                  showLoading = false;
                  empty = true;
                }else{
                  showLoading = false;
                  empty = false;
                }
              }));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bus.off(Constants.EVENT_LOADING_NAME, (arg) {
      showLoading = false;
      empty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _initBody();
    return WillPopScope(
      key: _key,
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          ToastUtils.showToast('再点击一次既退出程序');
          return false;
        }
        Navigator.pop(context);
        SystemNavigator.pop();
        return true;
      },
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              _body,
              Center(
                child: showLoading
                    ? progress.showLoading()
                    : (empty ? Text("暂无数据，稍后刷新") : null),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title:
                      Text(StudyLocalizations.of(context).getBarHomeTitle())),
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera),
                  title:
                      Text(StudyLocalizations.of(context).getBarNovelTitle())),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title:
                      Text(StudyLocalizations.of(context).getBarMineTitle())),
            ],
            currentIndex: _selectedIndex,
            fixedColor: Colors.deepPurple,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
