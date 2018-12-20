import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_study/model/joke_entity.dart';
import 'package:flutter_study/mvp/repository/novel_repository.dart';
import 'package:flutter_study/utils/constants.dart';
import 'package:flutter_study/utils/dio_factory.dart';

class NovelRepositoryIml implements NovelRepository {
  @override
  Future<RegionResp> fetch(int type,int page) {
    return getNovelList(type,page);
  }

  Future<RegionResp> getNovelList(int type,int page) async {
    String url = Constants.baseUrl + "/satinApi";

    Response response = await dioFactory.getDio().get(url,data: {"type":type,"page": page});

    if (response.statusCode == Constants.SUCCESS_CODE) {
      return RegionResp.fromJson(response.data);
    }

    return null;
  }
}
