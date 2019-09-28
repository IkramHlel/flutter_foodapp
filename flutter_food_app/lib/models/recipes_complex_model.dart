class RecipesComplexModel {
  int _offset;
  int _number;
  int _totalResults;
  List<_Recipe> _results = [];

  RecipesComplexModel.fromJson(Map<String, dynamic> parsedJson) {
    _offset = parsedJson['offset'];
    _number = parsedJson['number'];
    _totalResults = parsedJson['totalResults'];
    List<_Recipe> tempList = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Recipe result = _Recipe(parsedJson['results'][i]);
      tempList.add(result);
    }
    _results = tempList;
  }

  List<_Recipe> get results => _results;

}

class _Recipe {
  int _id;
  int _calories;
  String _carbs;
  String _fat;
  String _image;
  String _imageType;
  String _protein;
  String _title;
  _Recipe(result) {
    _id = result['id'];
    _calories = result['calories'];
    _carbs = result['carbs'];
    _fat = result['fat'];
    _image = result['image'];
    _imageType = result['imageType'];
    _protein = result['protein'];
    _title = result['title'];
  }

  String get image => _image;
  String get title => _title;
  int get id => _id;
}
