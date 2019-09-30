import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_food_app/models/autocomplete_recipe_model.dart';
import 'package:flutter_food_app/models/recipes_complex_model.dart';

class SearchService{
  final _apiKey = '226be7def33241d68846ca9aca2b046d';

    Future<AutocomleteRecipeModel> autocompleteRecipeSearch(String s) async {
    final http.Response response = await http.get(
        'https://api.spoonacular.com/recipes/autocomplete?number=20&query=$s&apiKey=$_apiKey');
    //print(response.body.toString());
     if (response.statusCode == 200){
        return AutocomleteRecipeModel.fromJson( json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }  
  }

    Future<RecipesComplexModel> recipeSearch(List selectedList,title) async {
    final http.Response response = await http.get(
          'https://api.spoonacular.com/recipes/complexSearch?query=$title&cuisine=${selectedList[0]}&diet=${selectedList[1]}&intolerances=${selectedList[2]}&apiKey=$_apiKey');
        print('****************');
        print(response.body.toString());
        print('****************');
     if (response.statusCode == 200){
        return RecipesComplexModel.fromJson( json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }  
  }

}