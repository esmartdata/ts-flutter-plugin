import 'dart:convert';

class UserInfo {
  /// 业务系统用户唯一标识
  String guid;

  /// 真实姓名
  String realName;

  /// 昵称
  String nickName;

  /// 年龄
  String age;

  /// 生日
  String birthday;

  /// 性别: 男/女
  String gender;

  /// 账号
  String account;

  /// 国家
  String country;

  /// 省份
  String province;

  /// 城市
  String city;

  UserInfo(
      {required this.guid,
      this.realName = "",
      this.nickName = "",
      this.age = "",
      this.birthday = "",
      this.gender = "",
      this.account = "",
      this.country = "",
      this.province = "",
      this.city = ""});

  @override
  String toString() {
    return jsonEncode({
      "guid": guid,
      "real_name": realName,
      "nick_name": nickName,
      "age": age,
      "birthday": birthday,
      "gender": gender,
      "account": account,
      "country": country,
      "province": province,
      "city": city,
    });
  }
}
