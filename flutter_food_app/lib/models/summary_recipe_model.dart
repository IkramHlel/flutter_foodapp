class SummaryRecipeModel{
  int _id;
  String _summary;
  String _title;
  SummaryRecipeModel.fromJson(Map<String,dynamic> parsedJson){
    _id = parsedJson['id'];
    _summary = parsedJson['summary'];
    _title = parsedJson['title'];
  }
  String get summary => _summary;
}