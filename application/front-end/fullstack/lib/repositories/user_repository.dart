import 'dart:io';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstack/models/users.dart';
import 'package:http/http.dart' as http;

abstract class IUserRepository {
  Future<UserListResponse> fetchUsersList();
  Future<UserResponse> createNewUser(User user);
  Future<UserResponse> getUserById(int userId);
}

class UserRepository implements IUserRepository {
  final _host = "https://192.168.202.172:5001/api/User/";

  /*
    - Mobile Emulator + Desktop
      final _host = "https://192.000.000.000:44371/api/User/";
    - WEB
      final _host = "https://localhost:44371/api/User/";
  */

  final Map<String, String> _headers = {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
    "Charset": "utf-8",
  };

  @override
  Future<UserListResponse> fetchUsersList() async {
    var getAllUsersUrl = _host + "GetAll";
    var results = await http.get(Uri.parse(getAllUsersUrl), headers: _headers);
    final jsonObject = json.decode(results.body);
    var response = UserListResponse.fromJson(jsonObject);
    return response;
  }

  @override
  Future<UserResponse> createNewUser(User user) async {
    var url = _host + "Create";
    var _body = json.encode(user);

    var results = await http.post(Uri.parse(url),
        body: _body, headers: _headers, encoding: Encoding.getByName("utf-8"));

    final jsonObject = json.decode(results.body);

    var response = UserResponse.fromJson(jsonObject);

    return response;
  }

  @override
  Future<UserResponse> getUserById(int userId) async {
    var url = _host + userId.toString();
    var results = await http.get(Uri.parse(url), headers: _headers);
    final jsonObject = json.decode(results.body);
    var response = UserResponse.fromJson(jsonObject);
    return response;
  }
}
