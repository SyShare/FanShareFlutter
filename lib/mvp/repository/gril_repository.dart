import 'package:flutter_study/model/fl_model.dart';

abstract class GirlRepository {
  Future<List<FLModel>> fetch(int page);
}
