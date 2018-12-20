import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StudyLocalizations {
  StudyLocalizations(this.isZh);

  bool isZh = false;

//静态方法
  static StudyLocalizations of(BuildContext context) {
    return Localizations.of<StudyLocalizations>(context, StudyLocalizations);
  }

  String getTitle() {
    return isZh ? "FanShare" : "紫玉乐";
  }

  String getBarHomeTitle() {
    return isZh ? "Home" : "美女";
  }

  String getBarNovelTitle(){
    return isZh ? "Video" : "资讯";
  }

  String getBarMineTitle(){
    return isZh ? "Mine" : "我的";
  }

  static const LocalizationsDelegate<StudyLocalizations> delegate =
      StudyLocalizationsDelegate();
}

class StudyLocalizationsDelegate
    extends LocalizationsDelegate<StudyLocalizations> {
  const StudyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<StudyLocalizations> load(Locale locale) {
    return SynchronousFuture<StudyLocalizations>(
        StudyLocalizations(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(LocalizationsDelegate<StudyLocalizations> old) {
    return false;
  }
}
