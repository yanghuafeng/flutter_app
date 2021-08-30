import 'package:json_annotation/json_annotation.dart';


/**
 * Created by YHF at 16:35 on 2021-05-20.
 */
part 'DynamicButton.g.dart';


@JsonSerializable()
class DynamicButton {
  String? time;
  List<Common?>? common;

  DynamicButton();

  factory DynamicButton.fromJson(Map<String, dynamic> json) => _$DynamicButtonFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicButtonToJson(this);
}

@JsonSerializable()
class Common{
  String? ip;
  List<ImgIcon?>? icon;

  Common();

  factory Common.fromJson(Map<String, dynamic> json) => _$CommonFromJson(json);
  Map<String, dynamic> toJson() => _$CommonToJson(this);
}

@JsonSerializable()
class ImgIcon{
  String? h_src;
  String? v_src;
  String? h_online_src;
  String? v_online_src;
  String? h_high_src;
  String? v_high_src;
  String? h_high_online_src;
  String? v_high_online_src;
  String? href;
  String? online_href;
  String? text;
  String? begin;
  String? end;

  ImgIcon();

  factory ImgIcon.fromJson(Map<String, dynamic> json) => _$ImgIconFromJson(json);
  Map<String, dynamic> toJson() => _$ImgIconToJson(this);
}
