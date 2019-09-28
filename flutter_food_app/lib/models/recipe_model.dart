class RecipeModel {
  int _id;
  String _title;
  String _image;
  String _imageType;
  int _servings;
  int _readyInMinutes;
  String _license;
  String _sourceName;
  String _sourceUrl;
  String _spoonacularSourceUrl;
  int _aggregateLikes;
  double _healthScore;
  double _spoonacularScore;
  double _pricePerServing;
  List _analyzedInstructions = [];
  bool _cheap;
  String _creditsText;
  List _cuisines = [];
  bool _dairyFree;
  List _diets = [];
  String _gaps;
  bool _glutenFree;
  String _instructions;
  bool _ketogenic;
  bool _lowFodmap;
  List _occasions = [];
  bool _sustainable;
  bool _vegan;
  bool _vegetarian;
  bool _veryHealthy;
  bool _veryPopular;
  bool _whole30;
  int _weightWatcherSmartPoints;
  List<String> _dishTypes = [];
  List<_Ingredient> _extendedIngredients = [];
  Map<String, dynamic> _winePairing;

  RecipeModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _title = parsedJson['title'];
    _image = parsedJson['image'];
    _imageType = parsedJson['imageType'];
    _servings = parsedJson['servings'];
    _readyInMinutes = parsedJson['readyInMinutes'];
    _license = parsedJson['license'];
    _sourceName = parsedJson['sourceName'];
    _sourceUrl = parsedJson['sourceUrl'];
    _spoonacularSourceUrl = parsedJson['spoonacularSourceUrl'];
    _aggregateLikes = parsedJson['aggregateLikes'];
    _healthScore = parsedJson['healthScore'];
    _spoonacularScore = parsedJson['spoonacularScore'];
    _pricePerServing = parsedJson['pricePerServing'];
    if (parsedJson['analyzedInstructions'] != []) {
      for (int i = 0; i < parsedJson['analyzedInstructions'].length; i++) {
        _analyzedInstructions.add(parsedJson['analyzedInstructions'][i]);
      }
    }

    _cheap = parsedJson['cheap'];
    _creditsText = parsedJson['creditsText'];
    if (parsedJson['cuisines'] != []) {
      for (int i = 0; i < parsedJson['cuisines'].length; i++) {
        _cuisines.add(parsedJson['cuisines'][i]);
      }
    }
    _dairyFree = parsedJson['dairyFree'];
    if (parsedJson['diets'] != []) {
      for (int i = 0; i < parsedJson['diets'].length; i++) {
        _diets.add(parsedJson['diets'][i]);
      }
    }
    _gaps = parsedJson['gaps'];
    _glutenFree = parsedJson['glutenFree'];
    _instructions = parsedJson['instructions'];
    _ketogenic = parsedJson['ketogenic '];
    _lowFodmap = parsedJson['lowFodmap'];
    if (parsedJson['occasions'] != []) {
      for (int i = 0; i < parsedJson['occasions'].length; i++) {
        _occasions.add(parsedJson['occasions'][i]);
      }
    }

    _sustainable = parsedJson['sustainable'];
    _vegan = parsedJson['vegan'];
    _vegetarian = parsedJson['vegetarian '];
    _veryHealthy = parsedJson['veryHealthy'];
    _veryPopular = parsedJson['veryPopular'];
    _whole30 = parsedJson['whole30'];
    _weightWatcherSmartPoints = parsedJson['weightWatcherSmartPoints'];
    
    if (parsedJson['dishTypes'] != []) {
      for (int i = 0; i < parsedJson['dishTypes'].length; i++) {
        _occasions.add(parsedJson['dishTypes'][i]);
      }
    }
    List<_Ingredient> tempList = [];
    for (int i = 0; i < parsedJson['extendedIngredients'].length; i++) {
      _Ingredient ingredients =
          _Ingredient(parsedJson['extendedIngredients'][i]);
      tempList.add(ingredients);
    }
    _extendedIngredients = tempList;

    _winePairing = {
      'pairedWines': [],
      'pairingText': parsedJson['winePairing']['pairingtext'],
      'productMatches': [],
    };
  }

  int get id => _id;
  String get title => _title;
  int get servings => _servings;
  int get readyInMinutes => _readyInMinutes;
  double get pricePerServing => _pricePerServing;
  double get healthScore => _healthScore;
  String get image => _image;
}

class _Ingredient {
  String _aisle;
  double _amount;
  String _consitency;
  int _id;
  String _image;
  Map<String, dynamic> _measures;
  List _meta = [];
  List _metaInformation = [];
  String _name;
  String _original;
  String _originaLName;
  String _originalString;
  String _unit;
  _Ingredient(ingredients) {
    _aisle = ingredients['aisle'];
    _amount = ingredients['amount'];
    _consitency = ingredients['consitency'];
    _id = ingredients['id'];
    _image = ingredients['image'];
    _measures = {
      'metric': {
        'amount': ingredients['measures']['metric']['amount'],
        'unitLong': ingredients['measures']['metric']['unitLong'],
        'unitShort': ingredients['measures']['metric']['unitShort']
      },
      'us': {
        'amount': ingredients['measures']['us']['amount'],
        'unitLong': ingredients['measures']['us']['unitLong'],
        'unitShort': ingredients['measures']['us']['unitShort']
      }
    };
    _name = ingredients['name'];
    _original = ingredients['original'];
    _originaLName = ingredients['originaLName'];
    _originalString = ingredients['originalString'];
    _unit = ingredients['unit'];
  }
}
