import 'package:flutter/material.dart';

import 'package:flutter_food_app/blocs/search_recipe_bloc.dart';

import '../pages/recipe_details.dart';
import '../widgets/slide_drawer.dart';
import '../models/recipes_complex_model.dart';

class SearchResultsPage extends StatefulWidget {
  String title;
  SearchRecipeBloc searchRecipeBloc;
  SearchResultsPage(this.title) {
    searchRecipeBloc = SearchRecipeBloc(title);
  }
  @override
  State<StatefulWidget> createState() {
    return _SearchResultsState();
  }
}

class _SearchResultsState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    widget.searchRecipeBloc.recipeSearch();
    return StreamBuilder<RecipesComplexModel>(
        stream: widget.searchRecipeBloc.searchResultStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != []) {
              return Scaffold(
                drawer: SlideDrawer(context),
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: ListView.builder(
                    itemCount: snapshot.data.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      FadeInImage(
                                        image: NetworkImage(
                                            snapshot.data.results[index].image),
                                        placeholder: AssetImage(
                                            'assets/food_backgrnd.jpg'),
                                        height: 312.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        width: 410.0,
                                        height: 55.0,
                                        color: Colors.black.withOpacity(0.6),
                                        child: Center(
                                          child: Text(
                                            snapshot.data.results[index].title,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RecipeDetailsPage(
                                      snapshot.data.results[index].id,snapshot.data.results[index].title)));
                        },
                      );
                    }),
              );
            } else {
              return Scaffold(
                drawer: SlideDrawer(context),
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Center(
                    child: Text('There is no recipes with those limits')),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
