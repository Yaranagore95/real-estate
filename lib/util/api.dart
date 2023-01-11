import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bien.dart';

class NetWork {
  final String _url = "http://192.168.43.222:8000/api";
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  getBiens(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    var response = await http.get(fullUrl, headers: _setHeaders());

    if (response.statusCode == 200) {
      List<Bien> biens = [];
      print('success !!!');
      var body = jsonDecode(response.body);
      print('body = $body');
      for (var b in body) {
        biens.add(Bien.fromMap(b));
      }
      return biens;
    } else {
      return null;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
