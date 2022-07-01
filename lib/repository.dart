import 'dart:convert';

import 'package:flutter_crudapi/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://628dd69ca339dfef87a14d88.mockapi.io/api/flutter';

  Future getData() async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      final response = await http.get(Uri.parse(_baseUrl + '/blog'));

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(response.body);
        Iterable it = jsonDecode(response.body);
        // ignore: unused_local_variable
        List<Blog> blog = it.map((e) => Blog.fromJson(e)).toList();
        return blog;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future postData(String title, String content) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings, unused_local_variable
      final response = await http.post(Uri.parse(_baseUrl + '/blog'),
          body: {"title": title, "content": content});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future putData(int id, String tittel, String content) async {
    try {
      final response =
          // ignore: prefer_interpolation_to_compose_strings
          await http.put(Uri.parse(_baseUrl + '/blog' + id.toString()), body: {
        "tittel": tittel,
        "content": content,
      });
      if (response.statusCode == 200) {
        // ignore: avoid_print
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(
          // ignore: prefer_interpolation_to_compose_strings
          Uri.parse(_baseUrl + '/blog' + id));
      if (response.statusCode == 200) {
        // ignore: avoid_print
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
