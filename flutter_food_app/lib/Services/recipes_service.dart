import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/recipes_model.dart';
class RecipesService{
  final _apiKey = '226be7def33241d68846ca9aca2b046d';

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