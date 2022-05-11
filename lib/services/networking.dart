import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  static final Map<String, String> httpHeaders = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.userAgentHeader: "JCMP/1.0.0",
    HttpHeaders.acceptEncodingHeader: "gzip",
    HttpHeaders.connectionHeader: "Keep-Alive",
    HttpHeaders.authorizationHeader : "Basic d2M5WGdiSjhCNjEzVkIzZGdMQ046bG5qMTZOM2w1UW9JeTRHdTQzSEU=",
  };

  Future getData() async {
    Uri url = Uri.parse(this.url);
    http.Response response = await http.get(url, headers: NetworkHelper.httpHeaders);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data)["data"];
    }
  }
}
