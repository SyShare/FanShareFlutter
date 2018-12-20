import 'package:flutter_study/model/joke_entity.dart';

abstract class NovelRepository {
  Future<RegionResp> fetch(int type, int page);
}
