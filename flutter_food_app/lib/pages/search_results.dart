import 'package:flutter/material.dart';

import '../pages/recipe_details.dart';
import '../widgets/slide_drawer.dart';
import '../models/recipes_complex_model.dart';
import '../models/recipes_complex_model.dart';

class SearchResultsPage extends StatefulWidget {
  String title;
  List<Recipe> _results = [];
  SearchResultsPage(this.title, List<Recipe> results) {
    for (int i = 0; i < results.length; i++) {
      _results.add(results[i]);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _SearchResultsState();
  }
}

class _SearchResultsState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    print('**${widget._results}');
    print(widget._results != []);
    if (widget._results != null) {
      return Scaffold(
        drawer: SlideDrawer(context),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: widget._results.length,
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
                                image:
                                    NetworkImage(widget._results[index].image),
                                placeholder:
                                    AssetImage('assets/food_backgrnd.jpg'),
                                height: 312.0,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 410.0,
                                height: 55.0,
                                color: Colors.black.withOpacity(0.6),
                                child: Center(
                                  child: Text(
                                    widget._results[index].title,
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
                      builder: (BuildContext context) => RecipeDetailsPage(
                          widget._results[index].id,
                          widget._results[index].title)));
                },
              );
            }),
      );
    } else {
      print('else');
      return Scaffold(
        drawer: SlideDrawer(context),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: Text('There is no recipes with those limits')),
      );
    }
  }
}
