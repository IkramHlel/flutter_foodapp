class ProductModel {
  int _id;
  String _title;
  List<String> _breadcrumbs;
  List<String> _images = [];
  List<String> _badges = [];
  List<String> _important_badges = [];
  double _ingredientCount;
  String _generatedText = null;
  String _ingredientList;
  List<_Ingredient> _ingredients = [];
  double _likes;
  double _number_of_servings;
  Map<String, dynamic> _nutrition;
  double _price;
  String _serving_size;
  double _spoonacular_score;
  ProductModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _title = parsedJson['title'];
    List<String> tempList = [];
      for (int i = 0; i < parsedJson['breadcrumbs'].length; i++) {
        tempList.add(parsedJson['breadcrumbs'][i]);
      }
      _breadcrumbs = tempList;
    for (int i = 0; i < parsedJson['images'].length; i++) {
      _images.add(parsedJson['images'][i]);
    }
    for (int i = 0; i < parsedJson['badges'].length; i++) {
      _badges.add(parsedJson['badges'][i]);
    }
    for (int i = 0; i < parsedJson['important_badges'].length; i++) {
      _important_badges.add(parsedJson['important_badges'][i]);
    }
    _ingredientCount = parsedJson['ingredientCount'];
    _ingredientList = parsedJson['ingredientList '];

    List<_Ingredient> tempListIng = [];
    for (int i = 0; i < parsedJson['ingredients'].length; i++) {
      _Ingredient result = _Ingredient(parsedJson['ingredients'][i]);
      tempListIng.add(result);
    }
    _ingredients = tempListIng;

    _likes = parsedJson['likes '];
    _number_of_servings = parsedJson['number_of_servings'];
    _nutrition = {
      'calories': parsedJson['nutrition']['calories'],
      'carbs': parsedJson['nutrition']['carbs'],
      'fat': parsedJson['nutrition']['fat'],
      'protein': parsedJson['nutrition']['protein'],
    };
    _price = parsedJson['price'];
    _serving_size = parsedJson['serving_size'];
    _spoonacular_score = parsedJson['spoonacular_score'];
  }

  double get calories => _nutrition['calories'];
  String get carbs => _nutrition['carbs'];
  String get fat => _nutrition['fat'];
  String get protein => _nutrition['protein'];
}

class _Ingredient {
  String _discription;
  String _name;
  String _safety_level;
  _Ingredient(result) {
    _discription = result['description'];
    _name = result['name'];
    _safety_level = result['safety_level'];
  }
}
