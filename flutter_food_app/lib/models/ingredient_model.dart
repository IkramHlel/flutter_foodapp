class IngredientModel {
  List<_Ingredient> _ingredientList = [];
  IngredientModel.fromJson(Map<String, dynamic> parsedJson) {
    List<_Ingredient> tempList = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Ingredient result = _Ingredient(parsedJson[i]);
      tempList.add(result);
    }
    _ingredientList = tempList;
  }
  List<_Ingredient> get ingredientList => _ingredientList;
}

class _Ingredient {
  Map<String, dynamic> _amount;
  String _image;
  String _name;
  _Ingredient(result) {
    _image = result['image'];
    _name = result['name'];
    _amount = {
      'metric': {
        'unit': result['amount']['unit'],
        'value': result['amount']['value'],
      },
      'us': {
        'unit': result['us']['unit'],
        'value': result['us']['value'],
      },
    };
  }

  String get name => _name;
  String get unit => _amount['metric']['unit'];
  double get value => _amount['metric']['value'];
  String get image => _image;
}
