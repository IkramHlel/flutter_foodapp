import 'dart:async';

import 'package:flutter_food_app/models/instruction_model.dart';
import 'package:rxdart/rxdart.dart';

import '../Services/recipe_service.dart';
import 'package:flutter_food_app/models/recipe_model.dart';
import 'package:flutter_food_app/models/product_model.dart';
import 'package:flutter_food_app/models/summary_recipe_model.dart';
import '../models/ingredient_model.dart';

class RecipeBloc {
  int recipeId;
  RecipeService recipeService = RecipeService();
  RecipeBloc(this.recipeId);

  final _recipe = PublishSubject<RecipeModel>();
  Observable<RecipeModel> get recipeStream => _recipe.stream;
  StreamSink<RecipeModel> get recipeSink => _recipe.sink;

  fetchRecipeInfo() async {
    RecipeModel recipeModel = await recipeService.fetchRecipeInfo(recipeId);
    recipeSink.add(recipeModel);
  }

  final _recipeInfo = PublishSubject<ProductModel>();
  Observable<ProductModel> get recipeInfoStream => _recipeInfo.stream;
  StreamSink<ProductModel> get recipeInfoSink => _recipeInfo.sink;

  fetchproductInfo() async {
    ProductModel productModel = await recipeService.fetchproductInfo(recipeId);
    recipeInfoSink.add(productModel);
  }

  final _recipeSummary = PublishSubject<SummaryRecipeModel>();
  Observable<SummaryRecipeModel> get recipeSummaryStream =>
      _recipeSummary.stream;
  StreamSink<SummaryRecipeModel> get recipeSummarySink => _recipeSummary.sink;

  fetchRecipeSummary() async {
    SummaryRecipeModel summaryRecipeModel =
        await recipeService.fetchRecipeSummary(recipeId);
    recipeSummarySink.add(summaryRecipeModel);
  }

  final _ingredients = PublishSubject<IngredientModel>();
  Observable<IngredientModel> get ingredientStream => _ingredients.stream;
  StreamSink<IngredientModel> get ingredientSink => _ingredients.sink;

  fetchRecipeIngredients(recipeId) async {
    IngredientModel ingredientModel =
        await recipeService.fetchRecipeIngredients(recipeId);
    ingredientSink.add(ingredientModel);
  }

  final _instructions = StreamController<InstructionModel>();
  Stream<InstructionModel> get instructionStream => _instructions.stream;
  StreamSink<InstructionModel> get instructionSink => _instructions.sink;

  fetchRecipeInstructions(recipeId) async {
    InstructionModel instructionModel =
        await recipeService.fetchRecipeInstructions(recipeId);
    instructionSink.add(instructionModel);
  }

  void dispose() {
    _recipe.close();
    _recipeInfo.close();
    _recipeSummary.close();
    _ingredients.close();
    _instructions.close();
  }
}
