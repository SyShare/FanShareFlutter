import 'package:flutter/material.dart';

class ProgressLoadingHelper {
  static Widget _loadingWidget;

  ProgressLoadingHelper._internal() {
    _loadingWidget = getProgressDialog();
  }

  static ProgressLoadingHelper _instance =
      new ProgressLoadingHelper._internal();

  factory ProgressLoadingHelper() => _instance;

  showLoading() {
    if (_loadingWidget == null) {
      _loadingWidget = getProgressDialog();
    }
    return _loadingWidget;
  }

  void dismiss() {
    _loadingWidget = null;
  }

  Widget getProgressDialog() {
    return new Center(
        child: new CircularProgressIndicator(
      backgroundColor: Colors.indigo,
      strokeWidth: 2.0,
    ));
  }
}

var progress = new ProgressLoadingHelper();
