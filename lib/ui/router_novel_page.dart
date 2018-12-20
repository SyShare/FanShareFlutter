import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/localizations/examle_local.dart';
import 'package:flutter_study/model/joke_entity.dart';
import 'package:flutter_study/mvp/presenter/novel_contract.dart';
import 'package:flutter_study/mvp/presenter/novel_iml.dart';
import 'package:flutter_study/notification_demo/custom_notification.dart';
import 'package:flutter_study/utils/constants.dart';
import 'package:flutter_study/utils/event_bus.dart';
import 'package:flutter_study/utils/routes_util.dart';

class NovelPage extends StatefulWidget {
  NovelPage({Key key}) : super(key: key);

  @override
  _NovelPageState createState() {
    _NovelPageState _view = new _NovelPageState();
    NovelPresenter grilPresenter = new NovelImp(_view);
    grilPresenter.init();
    return _view;
  }
}

class _NovelPageState extends State<NovelPage> implements NovelView {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  NovelPresenter novelPresenter;
  List<RegionRespModel> items = new List();
  int pageNow = 1;
  ScrollController _scrollController;
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
      novelPresenter.loadData(novelPresenter.getPageNow());
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
    assert(novelPresenter != null);
    final Completer<Null> completer = new Completer<Null>();
    novelPresenter.refreshData();
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

  void _goPlayVideo(RegionRespModel item) {
    assert(item != null);
    bool isGif = item.videouri.endsWith(".gif");

    if (isGif) {
      RouteUtil.route2Web(context, item.theme_name, item.weixin_url);
    } else {
      RouteUtil.routeVideoPage(context, item.videouri, item.bimageuri);
      //这个播放器有点问题，先用原生代替
//      Navigator.push(context, PageRouteBuilder(
//          transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
//          pageBuilder: (BuildContext context, Animation animation,
//              Animation secondaryAnimation) {
//            return new FadeTransition( //使用渐隐渐入过渡,
//              opacity: animation,
//              child:VideoPlayPage(item.videouri), //路由B
//            );
//          }));
    }
  }

  Widget buildCard(BuildContext context, int index) {
    print("index----$index");

    final String item = items.isEmpty ? null : items[index].bimageuri;
    print("index----$item");
    return new GestureDetector(
      onTap: () {
        _goPlayVideo(items[index]);
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: item,
              fit: BoxFit.cover,
              placeholder: Padding(
                padding: EdgeInsets.all(160.0),
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              ),
              errorWidget: Image.asset("images/ic_place_holder.png"),
              alignment: Alignment.center,
            ),
            Center(
              child: item == null
                  ? null
                  : Image.asset(
                      "images/ic_play.png",
                      width: 50.0,
                      height: 50.0,
                    ),
            ),
          ],
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
  void loadSuccess(List<RegionRespModel> datas, bool isRefresh) {
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
  void setPresenter(NovelPresenter presenter) {
    this.novelPresenter = presenter;
  }

  @override
  void showLoading() {
    bus.emit(Constants.EVENT_LOADING_NAME, EventLoading.show);
  }
}

class NovelRoutePage extends StatefulWidget {
  NovelRoutePage({Key key}) : super(key: key);
  @override
  _NovelRoutePageState createState() => _NovelRoutePageState();
}

class _NovelRoutePageState extends State<NovelRoutePage>
    with SingleTickerProviderStateMixin {


  bool showBar = true; //是否显示toolbar

  @override
  Widget build(BuildContext context) {
    return NotificationListener<CustomNotification>(
      child: Scaffold(
        appBar: showBar
            ? AppBar(
                title: Text(StudyLocalizations.of(context).getBarNovelTitle()),
                centerTitle: true,
//          toolbarOpacity: animation.value,
              )
            : null,
        body: NovelPage(),
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
