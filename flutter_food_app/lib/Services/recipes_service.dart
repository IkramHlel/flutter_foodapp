import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/recipes_model.dart';
class RecipesService{
  final _apiKey = '5a69cf1ea96f413b8b6099b2a9a04e45';

    Future<RecipesModel> fetchRecipes() async {

    final http.Response response = await http.get(
        'https://api.spoonacular.com/recipes/search?number=20&apiKey=$_apiKey');
        //print(response.body.toString());
    json.decode(response.body);
     if (response.statusCode == 200){
        return RecipesModel.fromJson( json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }  
    
  }

}