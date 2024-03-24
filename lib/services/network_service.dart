import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NetworkService {
  static Future<List<Map<String, dynamic>>> getResponse(String findRecipe)async {
    String id = '3dfa5807';
    String key = '44f039b00b23d75750305743ae2a2cf7';
    String api = 'https://api.edamam.com/search?q=$findRecipe&app_id=$id&app_key=$key&from=0&to=17&calories=591-722&health=alcohol-free';
    final response = await http.get(Uri.parse(api));
    List<Map<String, dynamic>> recipe=[];
    if(response.statusCode==200) {
      var data = jsonDecode(response.body);
      if (data['hits'] != null) {
        for (var hit in data['hits']) {
          recipe.add(hit['recipe']);
        }
      }
      return recipe;
    }
    return recipe;
  }

  static Future<void> startCooking(String url) async{
    final recipe = Uri.parse(url);
    if (!await launchUrl(recipe)) {
      throw Exception('could not launch');
    }
  }
}