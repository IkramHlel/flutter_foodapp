class RecipesModel{
   int _offset;
  int _number;
  int _totalResults;
  List<_Recipe> _results = [];

  RecipesModel.fromJson(Map<String, dynamic> parsedJson) {
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
  int get offset => _offset;
  int get number => _number;
  int get totalResults => _totalResults;
}

class _Recipe {
  int _id;
  String _image;
  List<String> _imageUrls=[];
  int _readyInMinutes;
  int _servings;
  String _title;

  _Recipe(Map<String,dynamic> result){
    _id = result['id'];
    _image = result['image'];
    for (int i = 0; i < result['imageUrls'].length; i++) {
      _imageUrls.add(result['imageUrls'][i]);
    }
    _readyInMinutes = result['readyInMinutes'];
    _servings = result['servings'];
    _title = result['title'];
  }

  int get id => _id;
  String get image => _image;
  List<String> get imageUrls => _imageUrls;
  int get readyInMinutes => _readyInMinutes;
  int get servings => _servings;
  String get title => _title;
}

