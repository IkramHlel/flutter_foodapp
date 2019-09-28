import 'package:flutter/material.dart';

import 'package:flutter_food_app/blocs/recipes_bloc.dart';

import './recipe.dart';
import '../models/recipes_model.dart';
import '../widgets/slide_drawer.dart';

class RecipesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecipesPageState();
  }
}

class _RecipesPageState extends State<RecipesPage> {

  @override
  Widget build(BuildContext context) {
    recipesBloc.fetchRecipes();
    return StreamBuilder<RecipesModel>(
        stream: recipesBloc.recipesStream,
        builder: (context, snapshot) {
          return Scaffold(
            drawer: SlideDrawer(context),
            appBar: AppBar(title: Text('Recipes To Try')),
            body: ListView.builder(
              itemCount: (snapshot.data == null) ? 0 : snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        FadeInImage(
                          image: NetworkImage(
                              'https://spoonacular.com/recipeImages/${snapshot.data.results[index].id}-312x231.jpg'),
                          placeholder: AssetImage('assets/food_backgrnd.jpg'),
                          height: 312.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          snapshot.data.results[index].title,
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
                                  ' Serves ${snapshot.data.results[index].servings.toString()}'),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text('|', style: TextStyle(color: Colors.green),),
                              SizedBox(
                                width: 8.0,
                              ),
                              Icon(Icons.access_time),
                              Text(
                                  ' Ready in ${snapshot.data.results[index].readyInMinutes.toString()} Min'),
                            ],
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.info),
                              color: Theme.of(context).accentColor,
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RecipePage(snapshot.data.results[index].id)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
