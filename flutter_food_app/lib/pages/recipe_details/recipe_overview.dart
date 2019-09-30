import 'package:flutter/material.dart';
import 'package:flutter_food_app/blocs/recipe_bloc.dart';
import 'package:flutter_food_app/models/product_model.dart';
import '../../models/recipe_model.dart';

class RecipeOverviewPage extends StatefulWidget {
  int id;
  RecipeBloc recipeBloc;
  RecipeOverviewPage(this.id) {
    recipeBloc = RecipeBloc(id);
  }

  @override
  State<StatefulWidget> createState() {
    return _RecipeOverviewPageState();
  }
}

class _RecipeOverviewPageState extends State<RecipeOverviewPage> {
  @override
  Widget build(BuildContext context) {
    widget.recipeBloc.fetchRecipeInfo();
    widget.recipeBloc.fetchproductInfo();
    return StreamBuilder<RecipeModel>(
        stream: widget.recipeBloc.recipeStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: ListView(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: snapshot.data.title != null ||
                                  snapshot.data.title != ''
                              ? Text(
                                  snapshot.data.title,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                )
                              : '',
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        snapshot.data.image != null || snapshot.data.image != ''
                            ? FadeInImage(
                                image: NetworkImage(snapshot.data.image),
                                placeholder:
                                    AssetImage('assets/food_backgrnd.jpg'),
                                height: 312.0,
                                fit: BoxFit.cover,
                              )
                            : '',
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 180.0,
                                child: Chip(
                                  avatar: Icon(Icons.person),
                                  label: snapshot.data.servings != null ||
                                          snapshot.data.servings != ''
                                      ? Text(
                                          ' Serves ${snapshot.data.servings.toString()}',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : '',
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Container(
                                width: 180.0,
                                child: Chip(
                                  avatar: Icon(Icons.access_time),
                                  label: snapshot.data.readyInMinutes != null ||
                                          snapshot.data.readyInMinutes != ''
                                      ? Text(
                                          ' Ready in ${snapshot.data.readyInMinutes.toString()} Min',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : '',
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 180.0,
                                child: Chip(
                                  avatar: Icon(Icons.restaurant),
                                  label: snapshot.data.healthScore != null ||
                                          snapshot.data.healthScore != ''
                                      ? Text(
                                          '${snapshot.data.healthScore.toString()}% Health Score',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : '',
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Container(
                                width: 180.0,
                                child: Chip(
                                  avatar: Icon(Icons.monetization_on),
                                  label: snapshot.data.pricePerServing !=
                                              null ||
                                          snapshot.data.pricePerServing != ''
                                      ? Text(
                                          '${snapshot.data.pricePerServing.toString()} Per serving',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      : '',
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<ProductModel>(
                            stream: widget.recipeBloc.recipeInfoStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, top: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Chip(
                                            label: snapshot.data.calories !=
                                                        null ||
                                                    snapshot.data.calories != ''
                                                ? Text(
                                                    '${snapshot.data.calories} Calories',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : '',
                                            backgroundColor: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Chip(
                                            label: snapshot.data.carbs !=
                                                        null ||
                                                    snapshot.data.carbs != ''
                                                ? Text(
                                                    '${snapshot.data.carbs} g Carbs ',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : '',
                                            backgroundColor: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Chip(
                                            label: snapshot.data.fat != null ||
                                                    snapshot.data.fat != ''
                                                ? Text(
                                                    '${snapshot.data.fat} g fat',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : '',
                                            backgroundColor: Colors.green,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Chip(
                                      label: snapshot.data.protein != null ||
                                              snapshot.data.protein != ''
                                          ? Text(
                                              '${snapshot.data.protein} g Protein',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          : '',
                                      backgroundColor: Colors.green,
                                    ),
                                  ],
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            })
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
