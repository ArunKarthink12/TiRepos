import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ti/model/firstscreenmodel.dart';

class FirsCreenService {
  Future fetchData() async {
    try {
      // var data = {'page': "1"};
      var response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=1'),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var json = jsonDecode(response.body);
        return welcomeFromJson(response.body);
      } else {
        print("server Error");
      }
    } catch (e) {
      // client.close();
      print("catch" + e.toString());
    }
  }
}
