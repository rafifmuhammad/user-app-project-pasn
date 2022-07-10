import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_teori_app/model/user.dart';

class UserRepository {
  var baseURL = 'https://629ffa9d202ceef708637e89.mockapi.io/user-login';

  Future getAllUserData() async {
    try {
      final response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);

        print(response.body);

        List<User> user = it.map((e) => User.fromJSON(e)).toList();

        return user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postUserData(String nama, String alamat, String jenisKelamin,
      String kategori, String password) async {
    try {
      final response = await http.post(Uri.parse(baseURL), body: {
        'nama': nama,
        'alamat': alamat,
        'jenis_kelamin': jenisKelamin,
        'kategori': kategori,
        'password': password,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteUserData(String id) async {
    try {
      final response = await http.delete(Uri.parse(baseURL + '/$id'));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future loadUserSingleData(String id) async {
    try {
      final response = await http.get(Uri.parse(baseURL + '/$id'));

      if (response.statusCode == 200) {
        var user = jsonDecode(response.body);

        print(response.body);

        return user;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
