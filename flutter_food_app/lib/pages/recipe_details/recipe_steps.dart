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
  List<String> listSteps = [];
  @override
  Widget build(BuildContext context) {
    widget.recipeBloc.fetchRecipeInstructions(widget.id);
    return StreamBuilder<InstructionModel>(
        stream: widget.recipeBloc.instructionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.instructionList.length);
            for (int i = 0; i < snapshot.data.instructionList.length; i++) {
              for (int j = 0;
                  j < snapshot.data.instructionList[i].steps.length;
                  j++) {
                listSteps.add(snapshot.data.instructionList[i].steps[j].step);
              }
            }
            return Scaffold(
                body: ListView.builder(
              itemCount: listSteps.length,
              itemBuilder: (BuildContext context, int index) {
                if (listSteps.length != 0) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      child: Chip(
                        label: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '${index}) ${listSteps[index]}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                      body: Container(child: Text('No steps Found')));
                }
              },
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
