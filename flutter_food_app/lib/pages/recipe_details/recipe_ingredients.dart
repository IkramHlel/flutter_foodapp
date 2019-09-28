import 'package:flutter/material.dart';
import 'package:flutter_food_app/blocs/recipe_bloc.dart';
import 'dart:math';

import '../../models/ingredient_model.dart';
class RecipeIngredientsPage extends StatefulWidget {
  int id;
  RecipeBloc recipeBloc;
  RecipeIngredientsPage(this.id) {
    recipeBloc = RecipeBloc(id);
  }
  @override
  State<StatefulWidget> createState() {
    return _RecipeIngredientsPageState();
  }
}

class _RecipeIngredientsPageState extends State<RecipeIngredientsPage> {
  @override
  Widget build(BuildContext context) {
    widget.recipeBloc.fetchRecipeIngredients(widget.id);
    return StreamBuilder<IngredientModel>(
        stream: widget.recipeBloc.ingredientStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: ListView.builder(
                itemCount: snapshot.data.ingredientList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Chip(
                      label: Row(
                        children: <Widget>[
                          Image(
                              image: NetworkImage(
                            'https://spoonacular.com/cdn/ingredients_100x100/${snapshot.data.ingredientList[index].image}',
                          )),
                          Text(
                            '   ${snapshot.data.ingredientList[index].value} ${snapshot.data.ingredientList[index].unit} ${snapshot.data.ingredientList[index].name}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
