// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DynamicButton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicButton _$DynamicButtonFromJson(Map<String, dynamic> json) {
  return DynamicButton()
    ..time = json['time'] as String?
    ..common = (json['common'] as List?)
        ?.map((e) =>
            e == null ? null : Common.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DynamicButtonToJson(DynamicButton instance) =>
    <String, dynamic>{
      'time': instance.time,
      'common': instance.common,
    };

Common _$CommonFromJson(Map<String, dynamic> json) {
  return Common()
    ..ip = json['ip'] as String?
    ..icon = (json['icon'] as List?)
        ?.map((e) =>
            e == null ? null : ImgIcon.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CommonToJson(Common instance) => <String, dynamic>{
      'ip': instance.ip,
      'icon': instance.icon,
    };

ImgIcon _$ImgIconFromJson(Map<String, dynamic> json) {
  return ImgIcon()
    ..h_src = json['h_src'] as String?
    ..v_src = json['v_src'] as String?
    ..h_online_src = json['h_online_src'] as String?
    ..v_online_src = json['v_online_src'] as String?
    ..h_high_src = json['h_high_src'] as String?
    ..v_high_src = json['v_high_src'] as String?
    ..h_high_online_src = json['h_high_online_src'] as String?
    ..v_high_online_src = json['v_high_online_src'] as String?
    ..href = json['href'] as String?
    ..online_href = json['online_href'] as String?
    ..text = json['text'] as String?
    ..begin = json['begin'] as String?
    ..end = json['end'] as String?;
}

Map<String, dynamic> _$ImgIconToJson(ImgIcon instance) => <String, dynamic>{
      'h_src': instance.h_src,
      'v_src': instance.v_src,
      'h_online_src': instance.h_online_src,
      'v_online_src': instance.v_online_src,
      'h_high_src': instance.h_high_src,
      'v_high_src': instance.v_high_src,
      'h_high_online_src': instance.h_high_online_src,
      'v_high_online_src': instance.v_high_online_src,
      'href': instance.href,
      'online_href': instance.online_href,
      'text': instance.text,
      'begin': instance.begin,
      'end': instance.end,
    };
