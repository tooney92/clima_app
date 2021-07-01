import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final Uri url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
    // print(response.statusCode == 200);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      // decodedData['temperature']
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
