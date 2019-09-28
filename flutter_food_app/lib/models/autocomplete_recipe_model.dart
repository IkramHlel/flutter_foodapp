class AutocomleteRecipeModel{
  List<_Recipe> _recipeList = [];

  AutocomleteRecipeModel.fromJson(List parsedJson){
      List<_Recipe> tempList = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _Recipe result = _Recipe(parsedJson[i]);
      tempList.add(result);
    }
    _recipeList = tempList;
  }
List<_Recipe> get recipeList => _recipeList;

}

class _Recipe{
  int _id;
  String _title;
  _Recipe(result){
    _id = result['id'];
    _title = result['title'];
  }

  String get title => _title;
}