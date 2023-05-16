import 'dart:convert';

class UserInfo {
  String guid;
  String realName;
  String nickName;
  String age;
  String birthday;
  String gender;
  String account;
  String country;
  String province;
  String city;

  UserInfo(
    this.guid,
    this.realName,
    this.nickName,
    this.age,
    this.birthday,
    this.gender,
    this.account,
    this.country,
    this.province,
    this.city
  );

  @override
  String toString() {
    return jsonEncode({
    "guid": guid,
    "real_name":realName,
    "nick_name":nickName,
    "age":age,
    "birthday":birthday,
    "gender":gender,
    "account":account,
    "country":country,
    "province":province,
    "city":city,
    });
  }
}
