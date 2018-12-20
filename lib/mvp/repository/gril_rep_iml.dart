import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_study/model/fl_model.dart';
import 'package:flutter_study/mvp/repository/gril_repository.dart';
import 'package:flutter_study/utils/dio_factory.dart';

class GrilRepositoryIml implements GirlRepository {
  @override
  Future<List<FLModel>> fetch(int page) {
    return getGrilList(page);
  }

  Future<List<FLModel>> getGrilList(int page) async {
    var url = "http://gank.io/api/data/" + '福利/20/$page';

    print(url);
    List flModels;
    Response response = await dioFactory.getDio().get(url);

    try {
      if (response.statusCode == HttpStatus.ok) {
        var json = response.data;
        flModels = json['results'];
      }
    } catch (exception) {}
    return flModels.map((model) {
      return new FLModel.fromJson(model);
    }).toList();

//    try {
//      var request = await httpClient.getUrl(Uri.parse(url));
//      var response = await request.close();
//      if (response.statusCode == HttpStatus.ok) {
//        var json = await response.transform(Utf8Decoder()).join();
//        flModels = jsonDecode(json)['results'];
//      } else {
//        //todo
//      }
//    } catch (exception) {
//      //todo
//    }
//
//    return flModels.map((model) {
//      return new FLModel.fromJson(model);
//    }).toList();
  }
}
