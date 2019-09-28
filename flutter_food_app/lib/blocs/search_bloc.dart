import 'dart:async';

import 'package:flutter_food_app/Services/search_service.dart';
import 'package:flutter_food_app/models/autocomplete_recipe_model.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  SearchService searchService = SearchService();
  
  final _autocompleteRecipe = BehaviorSubject<String>();
  Stream<String> get autocompleteRecipeStream => _autocompleteRecipe.stream;
  StreamSink<String> get autocompleteRecipeSink => _autocompleteRecipe.sink;

  final _searchRecipe = PublishSubject<AutocomleteRecipeModel>();
  Observable<AutocomleteRecipeModel> get searchRecipeStream => _searchRecipe.stream;
  StreamSink<AutocomleteRecipeModel> get searchRecipeSink => _searchRecipe.sink;

  void fetch(String s)  async {
    AutocomleteRecipeModel autocompleteRecipeModel = await searchService.autocompleteRecipeSearch(s);
    searchRecipeSink.add(autocompleteRecipeModel);
  }

  SearchBloc() {
    _autocompleteRecipe.stream.listen(fetch);
  }

  void dispose() {
    _autocompleteRecipe.close();
    _searchRecipe.close();
  }
}
