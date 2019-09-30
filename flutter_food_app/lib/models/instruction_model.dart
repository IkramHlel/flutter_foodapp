class InstructionModel{
 List<_Instructions> _instructionList = [];

 InstructionModel.fromJson(List<dynamic> parsedJson){
 List<_Instructions> tempList = [];
 print('length');
 print(parsedJson.length);
    for (int i = 0; i < parsedJson.length; i++) {
      _Instructions result = _Instructions(parsedJson[0][i]);
      tempList.add(result);
    }
    _instructionList = tempList;
  }
  List<_Instructions> get instructionList => _instructionList;
}

class _Instructions{
  String _name;
  List<_Instruction> _steps;
  _Instructions(result){
    _name = result['name'];
     List<_Instruction> tempList = [];
    for (int i = 0; i < result['steps'].length; i++) {
      _Instruction instruction = _Instruction(result['steps']);
      tempList.add(instruction);
    }
    _steps = tempList;
  }
  List<_Instruction> get steps => _steps;

  }

class _Instruction {
  List<_Equipment> _equipment= [];
    List<_Ingredient> _ingredients = [];
    int _number;
    String _step;
  _Instruction(instruction){
    _step = instruction['step'];
    _number = instruction['number'];

     List<_Equipment> equipmentList = [];
    for (int i = 0; i < instruction['equipment'].length; i++) {
      _Equipment equipment = _Equipment(instruction['equipment']);
      equipmentList .add(equipment);
    }
    _equipment = equipmentList ;

         List<_Ingredient> ingredientList = [];
    for (int i = 0; i < instruction['steps'].length; i++) {
      _Ingredient ingredient = _Ingredient (instruction['steps']);
      ingredientList .add(ingredient);
    }
    _ingredients = ingredientList ;
  }

  int get number => _number;
  String get step => _step;

}

class _Equipment{
  int _id;
  String _image;
  String _name;
  _Equipment(equipment){
    _id = equipment['id'];
    _image = equipment['image'];
    _name = equipment['name'];
  }
}
class _Ingredient{
    int _id;
  String _image;
  String _name;
  _Ingredient(ingredient){
    _id = ingredient['id'];
    _image = ingredient['image'];
    _name = ingredient['name'];
  }
}