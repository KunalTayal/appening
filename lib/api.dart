import 'dart:convert';
import 'package:http/http.dart' as http;

class GetRequestData{
  var url = 'https://reqres.in/';
  var header = <String, String>{
    'content-Type': 'application/json; charset=UTF-8',
  };

  storeUserData(String name, String designation) async {
    url = url + "api/users";
    var data = {
      "name": name,
      "job": designation,
    };
    try {
      var respone = await http.post(
        Uri.parse(url),
        headers: header,
        body: json.encode(data)
      );

      if (respone.statusCode == 201) {
        print(jsonDecode(respone.body));
        return jsonDecode(respone.body);
      } else {
        // ignore: avoid_print
        print(respone.statusCode);
        print(jsonDecode(respone.body));
        return Future.error('Server Error!');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return Future.error(e);
    }
  }

  fetchUserList() async {
    url = url + "api/users?page=2";
    try {
      var respone = await http.get(
        Uri.parse(url),
        headers: header,
      );

      if (respone.statusCode == 200) {
        print(jsonDecode(respone.body));
        return jsonDecode(respone.body)['data'];
      } else {
        // ignore: avoid_print
        print(respone.statusCode);
        print(jsonDecode(respone.body));
        return Future.error('Server Error!');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return Future.error(e);
    }
  }
}