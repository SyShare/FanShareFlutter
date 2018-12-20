import 'package:flutter_study/model/gril_entity.dart';

abstract class GirlRepository {
  Future<List<GirlBean>> fetch(int page);
}
