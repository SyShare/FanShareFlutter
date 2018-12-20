import 'package:flutter_study/mvp/presenter/novel_contract.dart';
import 'package:flutter_study/mvp/repository/novel_rep_iml.dart';
import 'package:flutter_study/utils/constants.dart';


class NovelImp implements NovelPresenter {

  NovelView _novelView;
  NovelRepositoryIml novelRepository;
  int pageNow = 1;
  bool canLoad = true;

  NovelImp(this._novelView){
    _novelView.setPresenter(this);
  }


  @override
  void init() {
    novelRepository = new NovelRepositoryIml();
  }

  @override
  void loadData(int page) {
    if (!canLoad) {
      return;
    }
    assert(_novelView != null);

    _novelView.showLoading();
    novelRepository.fetch(1,page).then((data) {
      _novelView.loadSuccess(data.data,page == 1);
      if (data.data.length >= Constants.PAGE_SIZE) {
        pageNow++;
        canLoad = true;
      } else {
        canLoad = false;
      }
    }).catchError((error) {
      _novelView.loadFail();
    }).whenComplete(() {
      _novelView.dismissLoading();
    });
  }

  @override
  getPageNow() {
    return pageNow;
  }

  @override
  void refreshData() {
    pageNow = 1;
    loadData(pageNow);
  }

}