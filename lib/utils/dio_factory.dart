import 'package:dio/dio.dart';

//单利模式【static + 工厂模式 】
class DioFactory {
  static Dio _dio;

  DioFactory._internal() {
    _dio = Dio();
  }

  static DioFactory _instance = new DioFactory._internal();

  factory DioFactory() => _instance;

  Dio getDio() {
    return _dio;
  }


}
var dioFactory = new DioFactory();
//测试是否是单例
void main() {
  print(dioFactory.getDio() == dioFactory.getDio());
}
