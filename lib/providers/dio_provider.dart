import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  //get token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post('http://192.168.0.112:8000/api/login',
          data: {'email': email, 'password': password});
      //if request sucessfully then return token
      if (response.statusCode == 200 && response.data != '') {
        //store returned token into share preferences
        //for get other data later
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  //get user data
  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get('http://192.168.0.112:8000/api/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      //if request successfuly then return user data
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

  //get user data
  Future<dynamic> registerUser(
      String username, String email, String password) async {
    try {
      var user = await Dio().post('http://192.168.0.112:8000/api/register',
          data: {'name': username, 'email': email, 'password': password});

      //if request successfuly then return user data
      if (user.statusCode == 201 && user.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

//store booking details
  Future<dynamic> bookAppointment(
      String date, String day, String time, int doctor, String token) async {
    try {
      var response = await Dio().post('http://192.168.0.112:8000/api/book',
          data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctor},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        print(response.statusCode);
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //retrieve booking details
  Future<dynamic> getAppointments(String token) async {
    try {
      var response = await Dio().get(
          'http://192.168.0.112:8000/api/appointments',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      } else {
        print(response.statusCode);
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

//store rating details
  Future<dynamic> storeReviews(
      String reviews, double ratings, int id, int doctor, String token) async {
    try {
      var response = await Dio().post('http://192.168.0.112:8000/api/reviews',
          data: {
            'ratings': ratings,
            'reviews': reviews,
            'appointment_id': id,
            'doctor_id': doctor
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200 && response.data != '') {
        print(reviews);
        return response.statusCode;
      } else {
        print(response.statusCode);
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }
}
