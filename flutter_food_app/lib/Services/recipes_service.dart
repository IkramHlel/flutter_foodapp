import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/recipes_model.dart';
import '../models/recipes_complex_model.dart';
class RecipesService{
  final _apiKey = 'dd9e54f7a2f848d0b8b4c979a88e2a05';

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

  Future<RecipesComplexModel> fetchRecipesByQuery(String title) async {

    final http.Response response = await http.get(
        'https://api.spoonacular.com/recipes/complexSearch?query=$title&apiKey=$_apiKey');
        //print(response.body.toString());
    json.decode(response.body);
     if (response.statusCode == 200){
        return RecipesComplexModel.fromJson( json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }  
  }

  

}