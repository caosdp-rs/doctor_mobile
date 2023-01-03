import 'dart:convert';

import 'package:dio/dio.dart';

class DioProvider {
  //get token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post('http://192.168.0.109:8000/api/login',
          data: {'email': email, 'password': password});
      //if request sucessfully then return token
      if (response.statusCode == 200 && response.data != '') {
        return response.data;
      }
    } catch (error) {
      return error;
    }
  }

  //get user data
  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get('http://192.168.0.109:8000/api/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      //if request successfuly then return user data
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }
}