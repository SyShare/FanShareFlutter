import 'package:flutter_study/mvp/presenter/gril_contract.dart';
import 'package:flutter_study/mvp/repository/gril_rep_iml.dart';
import 'package:flutter_study/utils/constants.dart';

class GrilImp implements GrilPresenter {
  GrilView _grilView;

  GrilRepositoryIml grilRepositoryIml;
  int pageNow = 2;
  bool canLoad = true;

  GrilImp(this._grilView) {
    _grilView.setPresenter(this);
  }

  @override
  void init() {
    grilRepositoryIml = new GrilRepositoryIml();
  }

  @override
  void loadData(int page) {
    if (!canLoad) {
      return;
    }
    assert(_grilView != null);

    //在子widget没有build时候调用上层setState()出错
    _grilView.showLoading();
    grilRepositoryIml.fetch(page).then((data) {
      _grilView.loadSuccess(data, pageNow == 2);
      if (data.length >= Constants.PAGE_SIZE) {
        pageNow++;
        canLoad = true;
      } else {
        canLoad = false;
      }
    }).catchError((error) {
      _grilView.loadFail();
    }).whenComplete(() {
      _grilView.dismissLoading();
    });
  }

  @override
  getPageNow() {
    return pageNow;
  }

  @override
  void refreshData() {
    pageNow = 2;
    loadData(pageNow);
  }
}
