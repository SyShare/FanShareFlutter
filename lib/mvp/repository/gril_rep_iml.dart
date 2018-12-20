import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_study/model/gril_entity.dart';
import 'package:flutter_study/mvp/repository/gril_repository.dart';
import 'package:flutter_study/utils/constants.dart';
import 'package:flutter_study/utils/dio_factory.dart';

class GrilRepositoryIml implements GirlRepository {
  @override
  Future<List<GirlBean>> fetch(int page) {
    return getGrilList(page);
  }

  Future<List<GirlBean>> getGrilList(int page) async {
    String url = Constants.baseUrl + "/meituApi";

    print(url);
    List grils;
    Response response =
        await dioFactory.getDio().get(url, data: {"page": page});
    try {
      if (response.statusCode == HttpStatus.ok) {
        var json = response.data;
        grils = json['data'];
      }
    } catch (exception) {}
    return grils.map((model) {
      return new GirlBean.fromJson(model);
    }).toList();

//    try {
//      var request = await httpClient.getUrl(Uri.parse(url));
//      var response = await request.close();
//      if (response.statusCode == HttpStatus.ok) {
//        var json = await response.transform(Utf8Decoder()).join();
//        flModels = jsonDecode(json)['data'];
//      } else {
//        //todo
//      }
//    } catch (exception) {
//      //todo
//    }
//
//    return grils.map((model) {
//      return new GirlBean.fromJson(model);
//    }).toList();
  }
}
