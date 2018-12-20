import 'package:flutter_study/model/gril_entity.dart';
import 'package:flutter_study/mvp/mvp.dart';

abstract class GrilPresenter implements IPresenter {
  void loadData(int page);

  void refreshData();

  getPageNow();
}

abstract class GrilView implements IView<GrilPresenter> {
  void showLoading();

  void loadSuccess(List<GirlBean> datas, bool isRefresh);

  void loadFail();

  void dismissLoading();
}
