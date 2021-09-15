import 'dart:convert';

import 'package:news_block_implementation/api_string/all_api_string.dart';
import 'package:news_block_implementation/models/top_headline_response_model.dart';
import 'package:http/http.dart' as http;
class ApiManager{
  Future<TopHeadline> fetchAlbum() async {
    final response = await http
        .get(Uri.parse(ApiStrings.TOP_HEADLINES));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("status is ok");
      return TopHeadline.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("status is not ok");
      throw Exception('Failed to load album');
    }
  }
}