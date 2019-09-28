import 'dart:async';

import 'package:flutter_food_app/models/recipes_complex_model.dart';
import 'package:rxdart/rxdart.dart';
import '../Services/search_service.dart';

class SearchRecipeBloc {
  String title;
  List selectedList = [null, null, null];
  SearchService searchService = SearchService();

  final _cuisineSearch = BehaviorSubject<Map<String, String>>();
  Stream<Map<String, String>> get searchCuisineStream => _cuisineSearch.stream;
  StreamSink<Map<String, String>> get searchCuisineSink => _cuisineSearch.sink;

  final _dietSearch = BehaviorSubject<Map<String, String>>();
  Stream<Map<String, String>> get searchDietStream => _dietSearch.stream;
  StreamSink<Map<String, String>> get searchDietSink => _dietSearch.sink;

  final _intoleranceSearch = BehaviorSubject<Map<String, String>>();
  Stream<Map<String, String>> get searchIntoleranceStream =>
      _intoleranceSearch.stream;
  StreamSink<Map<String, String>> get searchIntoleranceSink =>
      _intoleranceSearch.sink;

  final _searchResults = PublishSubject<RecipesComplexModel>();
  Observable<RecipesComplexModel> get searchResultStream =>
      _searchResults.stream;
  StreamSink<RecipesComplexModel> get searchResultSink => _searchResults.sink;


  void search(Map<String, String> s) async {
    if (s.keys.elementAt(0) == 'Cuisine') {
      selectedList[0] = s['Cuisine'];
    } else if (s.keys.elementAt(0) == 'Diet') {
      selectedList[1] = s['Diet'];
    } else if (s.keys.elementAt(0) == 'Intolerances') {
      selectedList[2] = s['Intolerances'];
    }
    //donne le resultat correcte mais il ne l'affiche pas dans la page
    /*RecipesComplexModel recipesComplexModel =
        await searchService.recipeSearch(selectedList, title);
    searchResultSink.add(recipesComplexModel);*/
  }

//affiche le premier recherche avec cuisine seulement
  recipeSearch() async {
    RecipesComplexModel recipesComplexModel =
        await searchService.recipeSearch(selectedList, title);
    searchResultSink.add(recipesComplexModel);
  }

  SearchRecipeBloc(this.title) {
    _cuisineSearch.stream.listen(search);
    _dietSearch.stream.listen(search);
    _intoleranceSearch.stream.listen(search);
  }

  void dispose() {
    _cuisineSearch.close();
    _dietSearch.close();
    _intoleranceSearch.close();
  }
}
