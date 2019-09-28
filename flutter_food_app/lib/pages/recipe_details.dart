import 'package:flutter/material.dart';

import '../pages/recipe_details/recipe_ingredients.dart';
import '../pages/recipe_details/recipe_steps.dart';
import '../pages/recipe_details/recipe_overview.dart';

class RecipeDetailsPage extends StatefulWidget {
  int id;
  String title;
  RecipeDetailsPage(this.id,this.title);
  @override
  State<StatefulWidget> createState() {
    return _RecipeDetailsPageState();
  }
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.folder),
                  text: 'OVERVIEW',
                ),
                Tab(
                  icon: Icon(Icons.shopping_cart),
                  text: 'INGREDIENTS',
                ),
                Tab(
                  icon: Icon(Icons.format_list_numbered),
                  text: 'STEPS',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              RecipeOverviewPage(widget.id),
              RecipeIngredientsPage(widget.id),
              RecipeStepsPage(widget.id)
            ],
          ),
        ),
      ),
    );
  }
}
