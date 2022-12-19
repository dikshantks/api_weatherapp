import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getdata() async {
    http.Response response = await http.get(Uri.parse(url));

    // ignore: prefer_typing_uninitialized_variables

    if (response.statusCode == 200) {
      String data;
      data = response.body;
      return jsonDecode(data);
    } else {
      print("not worinkgn");
      print(response.statusCode);
    }
  }
}
