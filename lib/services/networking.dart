import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utilities/constants.dart';

class NetworkHelper {
  final Uri url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
    // print(response.statusCode == 200);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
