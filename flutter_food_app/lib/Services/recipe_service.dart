import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_food_app/models/ingredient_model.dart';
import 'package:flutter_food_app/models/instruction_model.dart';
import '../models/recipe_model.dart';
import '../models/product_model.dart';
import 'package:flutter_food_app/models/summary_recipe_model.dart';

class RecipeService {
  final _apiKey = 'dd9e54f7a2f848d0b8b4c979a88e2a05';
  Map<String, dynamic> recipeData = {};

  Future<RecipeModel> fetchRecipeInfo(int recipeId) async {
    final http.Response response = await http.get(
        'https://api.spoonacular.com/recipes/${recipeId.toString()}/information?apiKey=$_apiKey');
    //print(response.body.toString());
    if (response.statusCode == 200) {
      return RecipeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ProductModel> fetchproductInfo(int recipeId) async {
    final http.Response response = await http.get(
        'https://api.spoonacular.com/food/products/${recipeId.toString()}?apiKey=$_apiKey');
    //print(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<SummaryRecipeModel> fetchRecipeSummary(int recipeId) async {
    final http.Response response = await http.get(
        'https://api.spoonacular.com/recipes/${recipeId.toString()}/summary?apiKey=$_apiKey');
    //print(response.body.toString());
    if (response.statusCode == 200) {
      return SummaryRecipeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<IngredientModel> fetchRecipeIngredients(int recipeId) async {
    final http.Response response = await http.get(
        'https://api.spoonacular.com/recipes/${recipeId.toString()}//ingredientWidget.json?apiKey=$_apiKey');
    if (response.statusCode == 200) {
      return IngredientModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<InstructionModel> fetchRecipeInstructions(int recipeId) async {
    final http.Response response = await http.get(
        'https://api.spoonacular.com/recipes/${recipeId.toString()}/analyzedInstructions?apiKey=$_apiKey');
    
    print('steps: ${json.decode(response.body)}');
    if (response.statusCode == 200) {
      return InstructionModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
