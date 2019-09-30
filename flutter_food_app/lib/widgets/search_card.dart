import 'package:flutter/material.dart';

import 'package:flutter_food_app/blocs/search_recipe_bloc.dart';

class SearchCard extends StatefulWidget {
  final String title;
  final List list;
  SearchRecipeBloc searchRecipeBloc;

  SearchCard(this.title, this.list, this.searchRecipeBloc);

  @override
  State<StatefulWidget> createState() {
    return _SearchCardState();
  }
}

class _SearchCardState extends State<SearchCard> {
  int _selectedIndex;
  bool _active = false;
  double _opacity = 0.3;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  Stream<Map<String, String>> _stream;
  Sink<Map<String, String>> _sink;

  @override
  Widget build(BuildContext context) {
    if (widget.title == 'Cuisine') {
      _stream = widget.searchRecipeBloc.searchCuisineStream;
      _sink = widget.searchRecipeBloc.searchCuisineSink;
    } else if (widget.title == 'Diet') {
      _stream = widget.searchRecipeBloc.searchDietStream;
      _sink = widget.searchRecipeBloc.searchDietSink;
    } else if (widget.title == 'Intolerances') {
      _stream = widget.searchRecipeBloc.searchIntoleranceStream;
      _sink = widget.searchRecipeBloc.searchIntoleranceSink;
    }
    return StreamBuilder<Map<String, String>>(
        stream: _stream,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.all(6.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  SwitchListTile(
                    value: _active,
                    onChanged: (bool value) {
                      setState(() {
                        _active = value;
                        if (_active) {
                          _opacity = 1;
                        } else if(!_active){
                          _opacity = 0.3;
                        }
                      });
                    },
                    title: Text(
                      widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Opacity(
                            opacity: _opacity,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 50.0,
                                  child: Chip(
                                    backgroundColor: _selectedIndex != null &&
                                            _selectedIndex == index &&
                                            _active != false
                                        ? Colors.green
                                        : Colors.black,
                                    label: Text(
                                      widget.list[index],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            if (_active) {
                              _onSelected(index);
                              _sink.add({widget.title: widget.list[index]});
                            }
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
