import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/common_widget/common_webview.dart';

class RouteUtil {
  //获取到插件与原生的交互通道
  static const jumpPlugin = const MethodChannel('com.syshare.act/plugin');
  static const String EXTRA_URL = "extra_url";
  static const String EXTRA_THUMB = "extra_thumb";

  static route2Web(BuildContext context, String title, String url) {
    if (null == url) {
      return;
    }
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          print('$url');
          return new CommonWebView(title, url);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new FadeTransition(
              opacity:
                  new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }

  static Future<Null> _jumpToNative(String video, String thump) async {
    Map<String, String> map = {EXTRA_URL: video, EXTRA_THUMB: thump};
    String result = await jumpPlugin.invokeMethod('actVideo', map);
    print(result);
  }

  static routeVideoPage(BuildContext context, String url,String thump) {
    _jumpToNative(url, thump);
  }
}
