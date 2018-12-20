import 'dart:convert' show json;

class GirlBeanModel {

  int code;
  String msg;
  List<GirlBean> data;

  GirlBeanModel.fromParams({this.code, this.msg, this.data});

  factory GirlBeanModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GirlBeanModel.fromJson(json.decode(jsonStr)) : new GirlBeanModel.fromJson(jsonStr);

  GirlBeanModel.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new GirlBean.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class GirlBean {

  String createdAt;
  String publishedAt;
  String type;
  String url;

  GirlBean.fromParams({this.createdAt, this.publishedAt, this.type, this.url});

  GirlBean.fromJson(jsonRes) {
    createdAt = jsonRes['createdAt'];
    publishedAt = jsonRes['publishedAt'];
    type = jsonRes['type'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"createdAt": ${createdAt != null?'${json.encode(createdAt)}':'null'},"publishedAt": ${publishedAt != null?'${json.encode(publishedAt)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

