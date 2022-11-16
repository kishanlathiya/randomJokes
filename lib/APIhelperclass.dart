import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Jsonmodelclass.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();
  String API_LINK = "https://api.chucknorris.io/jokes/random";

  Future<RandomJokes?> fetchJokes() async {
    Uri API = Uri.parse(API_LINK);
    http.Response response = await http.get(API);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      RandomJokes resumeData = RandomJokes.fromJson(data);
      return resumeData;
    } else {
      return null;
    }
  }
}
