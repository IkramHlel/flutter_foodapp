import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import '../models/recipes_model.dart';
import '../Services/recipes_service.dart';

class RecipesBloc {
  RecipesService recipesService = RecipesService();

  final _recipes = PublishSubject<RecipesModel>();
  Observable<RecipesModel> get recipesStream => _recipes.stream;
  StreamSink<RecipesModel> get recipesSink => _recipes.sink;

  fetchRecipes() async {
    RecipesModel recipeModel = await recipesService.fetchRecipes();
    recipesSink.add(recipeModel);
  }

  void dispose() {
    _recipes.close();
  }
}

final recipesBloc = RecipesBloc();
