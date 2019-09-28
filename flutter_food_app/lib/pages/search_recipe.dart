import 'package:flutter/material.dart';

import 'package:flutter_food_app/blocs/search_recipe_bloc.dart';

import 'package:flutter_food_app/pages/search_admin.dart';
import '../widgets/search_card.dart';
import '../pages/search_results.dart';

class SearchRecipePage extends StatefulWidget {
  final String title;
  SearchRecipePage(this.title);
  @override
  State<StatefulWidget> createState() {
    return _SearchRecipePageState();
  }
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  List<String> _cuisine = [
    'African',
    'American',
    'British',
    'Cajun',
    'Caribbean',
    'Chinese',
    'Eastern European',
    'European',
    'French',
    'German',
    'Greek',
    'Indian',
    'Irish',
    'Italian',
    'Japanese',
    'Jewish',
    'Korean',
    'Latin American',
    'Mediterranean',
    'Mexican',
    'Middle Eastern',
    'Nordic',
    'Southern',
    'Spanish',
    'Thai',
    'Vietnamese'
  ];
  List<String> _diet = [
    'Gluten Free',
    'Ketogenic',
    'Vegetarian',
    'Lacto-Vegetarian',
    'Ovo-Vegetarian',
    'Vegan',
    'Pescetarian',
    'Paleo',
    'Primal',
    'Whole30'
  ];
  List<String> _intolerances = [
    'Dairy Free',
    'Egg Free',
    'Gluten Free',
    'Grain Free',
    'Peanut Free',
    'Seafood Free',
    'Sesame Free',
    'Shellfish Free',
    'Soy Free',
    'Sulfite Free',
    'Tree Nut Free',
    'Wheat Free'
  ];

  @override
  Widget build(BuildContext context) {
    double minValue = 0.1;
    double maxValue = 0.8;
    RangeValues _values = RangeValues(minValue, maxValue);
    SearchRecipeBloc searchRecipeBloc = SearchRecipeBloc(widget.title);

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SearchAdminPage()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Search Recipes:  ${widget.title}')),
        body: ListView(children: <Widget>[
            SearchCard('Cuisine', _cuisine, searchRecipeBloc),
            SearchCard('Diet', _diet, searchRecipeBloc),
            SearchCard('Intolerances', _intolerances, searchRecipeBloc),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Calorific value',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 120.0,
                        ),
                        Chip(
                          label: Text(
                            minValue.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'To',
                          style: TextStyle(color: Colors.green, fontSize: 16.0),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Chip(
                          label: Text(
                            maxValue.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: _values,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _values = values;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: FlatButton(
                      textColor: Colors.green,
                      child: Text(
                        'Go!',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                        //searchRecipeBloc.recipeSearch();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SearchResultsPage(widget.title)));
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
