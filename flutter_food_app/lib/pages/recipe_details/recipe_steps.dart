import 'package:flutter/material.dart';
import 'package:flutter_food_app/models/instruction_model.dart';
import '../../blocs/recipe_bloc.dart';

class RecipeStepsPage extends StatefulWidget {
  int id;
  RecipeBloc recipeBloc;
  RecipeStepsPage(this.id) {
    recipeBloc = RecipeBloc(id);
  }
  @override
  State<StatefulWidget> createState() {
    return _RecipeStepsPageState();
  }
}

class _RecipeStepsPageState extends State<RecipeStepsPage> {
  @override
  Widget build(BuildContext context) {
    widget.recipeBloc.fetchRecipeInstructions(widget.id);
    return StreamBuilder<InstructionModel>(
      stream: widget.recipeBloc.instructionStream,
      builder: (context, snapshot) {
        print('has data: ${snapshot.hasData}');
        if (snapshot.hasData) {
          return Scaffold(
            body: ListView.builder(
                itemCount: snapshot.data.instructionList.length,
                itemBuilder: (BuildContext context, int index) {
                  print('**${snapshot.data.instructionList.length}');
                  if (snapshot.data.instructionList.length != 0) {
                    return ListView.builder(
                      itemCount:
                          snapshot.data.instructionList[index].steps.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Chip(
                            label: Text(
                                '${snapshot.data.instructionList[index].steps[index].number}) ${snapshot.data.instructionList[index].steps[index].step}'),
                          ),
                        );
                      },
                    );
                  } else {
                    return Scaffold(
                        body: Container(child: Text('No steps Found')));
                  }
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
