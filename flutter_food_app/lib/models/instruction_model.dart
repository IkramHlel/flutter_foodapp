class InstructionModel {
  List<_Instructions> _instructionList = [];

  InstructionModel.fromJson(List<dynamic> parsedJson) {
    List<_Instructions> tempList = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _Instructions result = _Instructions(parsedJson[i]);
      tempList.add(result);
    }
    _instructionList = tempList;
  }
  List<_Instructions> get instructionList => _instructionList;
}

class _Instructions {
  String _name;
  List<_Instruction> _steps;
  _Instructions(result) {
    _name = result['name'];
    List<_Instruction> tempList = [];
    for (int i = 0; i < result['steps'].length; i++) {
      _Instruction instruction = _Instruction(result['steps'][i]);
      tempList.add(instruction);
    }
    _steps = tempList;
  }
  List<_Instruction> get steps => _steps;
}

class _Instruction {
  List<_Equipment> _equipment = [];
  List<_Ingredient> _ingredients = [];
  int _number;
  String _step;
  _Instruction(instruction) {
    print(instruction[0]);
    _step = instruction[0];
    _number = instruction['number'];

    List<_Equipment> equipmentList = [];
    for (int i = 0; i < instruction['equipment'].length; i++) {
      _Equipment equipment = _Equipment(instruction['equipment'][i]);
      equipmentList.add(equipment);
    }
    _equipment = equipmentList;

    List<_Ingredient> ingredientList = [];
    for (int i = 0; i < instruction['ingredients'].length; i++) {
      _Ingredient ingredient = _Ingredient(instruction['ingredients'][i]);
      ingredientList.add(ingredient);
    }
    _ingredients = ingredientList;
  }

  int get number => _number;
  String get step => _step;
}

class _Equipment {
  int _id;
  String _image;
  String _name;
  _Equipment(equipment) {
    _id = equipment['id'];
    _image = equipment['image'];
    _name = equipment['name'];
    
  }
}

class _Ingredient {
  int _id;
  String _image;
  String _name;
  _Ingredient(ingredient) {
    _id = ingredient['id'];
    _image = ingredient['image'];
    _name = ingredient['name'];
  }
}
