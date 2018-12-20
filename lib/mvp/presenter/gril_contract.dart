import 'package:flutter_study/mvp/mvp.dart';
import 'package:flutter_study/model/fl_model.dart';

abstract class GrilPresenter implements IPresenter {
  void loadData(int page);
  void refreshData();

   getPageNow();
}

abstract class GrilView implements IView<GrilPresenter> {


  void showLoading();

  void loadSuccess(List<FLModel> datas,bool isRefresh);

  void loadFail();

  void dismissLoading();
}
