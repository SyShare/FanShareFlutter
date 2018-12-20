import 'package:flutter_study/model/joke_entity.dart';
import 'package:flutter_study/mvp/mvp.dart';

abstract class NovelPresenter implements IPresenter {
  void loadData(int page);

  void refreshData();

  getPageNow();
}

abstract class NovelView implements IView<NovelPresenter> {
  void showLoading();

  void loadSuccess(List<RegionRespModel> datas, bool isRefresh);

  void loadFail();

  void dismissLoading();
}
