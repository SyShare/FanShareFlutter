import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study/localizations/examle_local.dart';
import 'package:flutter_study/model/gril_entity.dart';
import 'package:flutter_study/mvp/presenter/gril_contract.dart';
import 'package:flutter_study/mvp/presenter/gril_iml.dart';
import 'package:flutter_study/notification_demo/custom_notification.dart';
import 'package:flutter_study/ui/multi_touch_page.dart';
import 'package:flutter_study/utils/constants.dart';
import 'package:flutter_study/utils/event_bus.dart';
import 'package:transparent_image/transparent_image.dart';

class GrilPage extends StatefulWidget {
  GrilPage({Key key}) : super(key: key);

  @override
  _GrilPageState createState() {
    _GrilPageState _view = new _GrilPageState();
    GrilPresenter grilPresenter = new GrilImp(_view);
    grilPresenter.init();
    return _view;
  }
}

class _GrilPageState extends State<GrilPage> implements GrilView {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  GrilPresenter grilPresenter;
  List<GirlBean> items = new List(); //数据集合
  int pageNow = 1; //当前夜index
  ScrollController _scrollController; //滚动控制器
  bool showBar = false; //是否显示Bar

  @override
  void initState() {
    super.initState();
    _refreshData();
    _scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      grilPresenter.loadData(grilPresenter.getPageNow());
    }

    print(_scrollController.offset); //打印滚动位置
    if (_scrollController.offset > 500 && !showBar) {
      setState(() {
        showBar = true;
        CustomNotification(ScrollNotificationType.hide).dispatch(context);
      });
    } else if (_scrollController.offset < 300 && showBar) {
      setState(() {
        showBar = false;
        CustomNotification(ScrollNotificationType.show).dispatch(context);
      });
    }
  }

  Future<Null> _refreshData() {
    assert(grilPresenter != null);
    final Completer<Null> completer = new Completer<Null>();
    grilPresenter.refreshData();
    setState(() {});
    completer.complete(null);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    var content;
//    if (items.isEmpty) {
//      content = progress.showLoading();
//    } else {
    content = new ListView.builder(
      //设置physics属性总是可滚动
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: items.length,
      itemBuilder: buildCard,
      itemExtent: 400.0,
    );
//    }

    var _refreshIndicator = new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: content,
    );

    return _refreshIndicator;
  }

  void _goPhotoView(String url) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return new MultiTouchPage(url);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new RotationTransition(
              turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }

  Widget buildCard(BuildContext context, int index) {
    print("index----$index");

    final String item = items.isEmpty ? null : items[index].url;
    return new GestureDetector(
      onTap: () {
        _goPhotoView(item);
      },
      child: new Card(
        child: FadeInImage.memoryNetwork(
          image: item,
          fit: BoxFit.cover,
          placeholder: kTransparentImage,
        ),
      ),
    );
  }

  @override
  void dismissLoading() {
    bus.emit(Constants.EVENT_LOADING_NAME, EventLoading.hide);
  }

  @override
  void loadFail() {
    bus.emit(Constants.EVENT_LOADING_NAME, EventLoading.empty);
  }

  @override
  void loadSuccess(List<GirlBean> datas, bool isRefresh) {
    setState(() {
      if (isRefresh) {
        items.clear();
        items.addAll(datas);
      } else {
        items.addAll(datas);
      }
    });
  }

  @override
  void setPresenter(GrilPresenter presenter) {
    this.grilPresenter = presenter;
  }

  @override
  void showLoading() {
    bus.emit(Constants.EVENT_LOADING_NAME, EventLoading.show);
  }
}

class GrilRoutePage extends StatefulWidget {
  GrilRoutePage({Key key}) : super(key: key);

  @override
  _GrilRoutePageState createState() => _GrilRoutePageState();
}

class _GrilRoutePageState extends State<GrilRoutePage>
    with SingleTickerProviderStateMixin {
  bool showBar = true; //是否显示toolbar

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //toolBar透明度
    animation = new Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _controllerAnimation(bool forward) {
    if (forward) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<CustomNotification>(
      child: Scaffold(
        appBar: showBar
            ? AppBar(
                title: Text(StudyLocalizations.of(context).getBarHomeTitle()),
                centerTitle: true,
//          toolbarOpacity: animation.value,
              )
            : null,
        body: GrilPage(),
      ),
      onNotification: (notification) {
        // _controllerAnimation(showBar);
        setState(() {
          showBar = notification.type == ScrollNotificationType.show;
        });
      },
    );
  }
}
