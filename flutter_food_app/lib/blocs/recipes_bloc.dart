import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import '../models/recipes_model.dart';
import '../Services/recipes_service.dart';
import '../models/recipes_complex_model.dart';

class RecipesBloc {
  RecipesService recipesService = RecipesService();

  final _recipes = PublishSubject<RecipesModel>();
  Observable<RecipesModel> get recipesStream => _recipes.stream;
  StreamSink<RecipesModel> get recipesSink => _recipes.sink;

  fetchRecipes() async {
    RecipesModel recipeModel = await recipesService.fetchRecipes();
    recipesSink.add(recipeModel);
  }

    final _recipesByQuery = PublishSubject<RecipesComplexModel>();
  Observable<RecipesComplexModel> get recipesByQueryStream => _recipesByQuery.stream;
  StreamSink<RecipesComplexModel> get recipesByQuerySink => _recipesByQuery.sink;

  fetchRecipesByQuery ( String title)async {
    RecipesComplexModel recipesComplexModel = await recipesService.fetchRecipesByQuery(title);
 recipesByQuerySink.add(recipesComplexModel);
  }

  void dispose() {
    _recipes.close();
  }
}

final recipesBloc = RecipesBloc();
