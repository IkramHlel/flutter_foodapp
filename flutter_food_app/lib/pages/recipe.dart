import 'package:flutter/material.dart';
import 'package:flutter_food_app/models/summary_recipe_model.dart';

import '../blocs/recipe_bloc.dart';
import '../models/recipe_model.dart';

class RecipePage extends StatefulWidget {
  final int recipeId;
  RecipeBloc recipeBloc;

  RecipePage(this.recipeId) {
    recipeBloc = RecipeBloc(recipeId);
  }
  @override
  State<StatefulWidget> createState() {
    return _RecipePageState();
  }
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    widget.recipeBloc.fetchRecipeInfo();
    widget.recipeBloc.fetchRecipeSummary();
    return StreamBuilder<RecipeModel>(
      stream: widget.recipeBloc.recipeStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WillPopScope(
            onWillPop: () {
              Navigator.pop(context, false);
              return Future.value(false);
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.title),
                ),
                body: ListView(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          FadeInImage(
                            image: NetworkImage(snapshot.data.image),
                            placeholder: AssetImage('assets/food_backgrnd.jpg'),
                            height: 312.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            snapshot.data.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.person),
                                Text(
                                  ' Serves ${snapshot.data.servings.toString()}',
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text('|'),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.access_time),
                                Text(
                                    ' Ready in ${snapshot.data.readyInMinutes.toString()} Min'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: 20.0,
                                right: 20.0,
                                bottom: 10.0),
                            child: Text(
                              'DESCRIPTION',
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                          ),
                          StreamBuilder<SummaryRecipeModel>(
                              stream: widget.recipeBloc.recipeSummaryStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    width: 380.0,
                                    padding: EdgeInsets.only(
                                        top: 10.0, left: 20.0, right: 20.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text(
                                      '${snapshot.data.summary}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: 380.0,
                                    padding: EdgeInsets.only(
                                        top: 10.0, left: 20.0, right: 20.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        } else {
          return Scaffold(
              appBar: AppBar(
                title: Text('Loading'),
              ),
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
