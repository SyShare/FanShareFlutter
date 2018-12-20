import 'dart:convert' show json;

class RegionResp {

  int code;
  String msg;
  List<RegionRespModel> data;

  RegionResp.fromParams({this.code, this.msg, this.data});

  factory RegionResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RegionResp.fromJson(json.decode(jsonStr)) : new RegionResp.fromJson(jsonStr);

  RegionResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new RegionRespModel.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class RegionRespModel {

  String create_time;
  String themes;
  String top_cmt;
  String voicelength;
  String voicetime;
  String voiceuri;
  String weixin_url;
  int cache_version;
  int t;
  int videotime;
  bool is_gif;
  String bimageuri;
  String bookmark;
  String cai;
  String cdn_img;
  String comment;
  String created_at;
  String ding;
  String favourite;
  String hate;
  String height;
  String image0;
  String image1;
  String image2;
  String image_small;
  String love;
  String name;
  String original_pid;
  String passtime;
  String playcount;
  String playfcount;
  String profile_image;
  String repost;
  String screen_name;
  String status;
  String tag;
  String text;
  String theme_id;
  String theme_name;
  String theme_type;
  String type;
  String user_id;
  String videouri;
  String width;

  RegionRespModel.fromParams({this.create_time, this.themes, this.top_cmt, this.voicelength, this.voicetime, this.voiceuri, this.weixin_url, this.cache_version, this.t, this.videotime, this.is_gif, this.bimageuri, this.bookmark, this.cai, this.cdn_img, this.comment, this.created_at, this.ding, this.favourite, this.hate, this.height, this.image0, this.image1, this.image2, this.image_small, this.love, this.name, this.original_pid, this.passtime, this.playcount, this.playfcount, this.profile_image, this.repost, this.screen_name, this.status, this.tag, this.text, this.theme_id, this.theme_name, this.theme_type, this.type, this.user_id, this.videouri, this.width});

  RegionRespModel.fromJson(jsonRes) {
    create_time = jsonRes['create_time'];
    themes = jsonRes['themes'];
    top_cmt = jsonRes['top_cmt'];
    voicelength = jsonRes['voicelength'];
    voicetime = jsonRes['voicetime'];
    voiceuri = jsonRes['voiceuri'];
    weixin_url = jsonRes['weixin_url'];
    cache_version = jsonRes['cache_version'];
    t = jsonRes['t'];
    videotime = jsonRes['videotime'];
    is_gif = jsonRes['is_gif'];
    bimageuri = jsonRes['bimageuri'];
    bookmark = jsonRes['bookmark'];
    cai = jsonRes['cai'];
    cdn_img = jsonRes['cdn_img'];
    comment = jsonRes['comment'];
    created_at = jsonRes['created_at'];
    ding = jsonRes['ding'];
    favourite = jsonRes['favourite'];
    hate = jsonRes['hate'];
    height = jsonRes['height'];
    image0 = jsonRes['image0'];
    image1 = jsonRes['image1'];
    image2 = jsonRes['image2'];
    image_small = jsonRes['image_small'];
    love = jsonRes['love'];
    name = jsonRes['name'];
    original_pid = jsonRes['original_pid'];
    passtime = jsonRes['passtime'];
    playcount = jsonRes['playcount'];
    playfcount = jsonRes['playfcount'];
    profile_image = jsonRes['profile_image'];
    repost = jsonRes['repost'];
    screen_name = jsonRes['screen_name'];
    status = jsonRes['status'];
    tag = jsonRes['tag'];
    text = jsonRes['text'];
    theme_id = jsonRes['theme_id'];
    theme_name = jsonRes['theme_name'];
    theme_type = jsonRes['theme_type'];
    type = jsonRes['type'];
    user_id = jsonRes['user_id'];
    videouri = jsonRes['videouri'];
    width = jsonRes['width'];
  }

  @override
  String toString() {
    return '{"create_time": ${create_time != null?'${json.encode(create_time)}':'null'},"themes": ${themes != null?'${json.encode(themes)}':'null'},"top_cmt": ${top_cmt != null?'${json.encode(top_cmt)}':'null'},"voicelength": ${voicelength != null?'${json.encode(voicelength)}':'null'},"voicetime": ${voicetime != null?'${json.encode(voicetime)}':'null'},"voiceuri": ${voiceuri != null?'${json.encode(voiceuri)}':'null'},"weixin_url": ${weixin_url != null?'${json.encode(weixin_url)}':'null'},"cache_version": $cache_version,"t": $t,"videotime": $videotime,"is_gif": $is_gif,"bimageuri": ${bimageuri != null?'${json.encode(bimageuri)}':'null'},"bookmark": ${bookmark != null?'${json.encode(bookmark)}':'null'},"cai": ${cai != null?'${json.encode(cai)}':'null'},"cdn_img": ${cdn_img != null?'${json.encode(cdn_img)}':'null'},"comment": ${comment != null?'${json.encode(comment)}':'null'},"created_at": ${created_at != null?'${json.encode(created_at)}':'null'},"ding": ${ding != null?'${json.encode(ding)}':'null'},"favourite": ${favourite != null?'${json.encode(favourite)}':'null'},"hate": ${hate != null?'${json.encode(hate)}':'null'},"height": ${height != null?'${json.encode(height)}':'null'},"image0": ${image0 != null?'${json.encode(image0)}':'null'},"image1": ${image1 != null?'${json.encode(image1)}':'null'},"image2": ${image2 != null?'${json.encode(image2)}':'null'},"image_small": ${image_small != null?'${json.encode(image_small)}':'null'},"love": ${love != null?'${json.encode(love)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"original_pid": ${original_pid != null?'${json.encode(original_pid)}':'null'},"passtime": ${passtime != null?'${json.encode(passtime)}':'null'},"playcount": ${playcount != null?'${json.encode(playcount)}':'null'},"playfcount": ${playfcount != null?'${json.encode(playfcount)}':'null'},"profile_image": ${profile_image != null?'${json.encode(profile_image)}':'null'},"repost": ${repost != null?'${json.encode(repost)}':'null'},"screen_name": ${screen_name != null?'${json.encode(screen_name)}':'null'},"status": ${status != null?'${json.encode(status)}':'null'},"tag": ${tag != null?'${json.encode(tag)}':'null'},"text": ${text != null?'${json.encode(text)}':'null'},"theme_id": ${theme_id != null?'${json.encode(theme_id)}':'null'},"theme_name": ${theme_name != null?'${json.encode(theme_name)}':'null'},"theme_type": ${theme_type != null?'${json.encode(theme_type)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"user_id": ${user_id != null?'${json.encode(user_id)}':'null'},"videouri": ${videouri != null?'${json.encode(videouri)}':'null'},"width": ${width != null?'${json.encode(width)}':'null'}}';
  }
}

