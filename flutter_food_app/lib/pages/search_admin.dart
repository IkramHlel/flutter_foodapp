import 'package:flutter/material.dart';

import '../blocs/search_bloc.dart';

import '../widgets/slide_drawer.dart';
import '../pages/search_recipe.dart';
import '../models/autocomplete_recipe_model.dart';

class SearchAdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchAdminPageState();
  }
}

class _SearchAdminPageState extends State<SearchAdminPage> {
  final TextEditingController _editingController = TextEditingController();
  SearchBloc searchBloc = SearchBloc();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
      image: AssetImage('assets/food_backgrnd.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SlideDrawer(context),
      appBar: AppBar(title: Text('Search Recipes')),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        child: StreamBuilder<String>(
            stream: searchBloc.autocompleteRecipeStream,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _editingController,
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                      ),
                      onChanged: (String value) {
                        searchBloc.autocompleteRecipeSink.add(value);
                      },
                    ),
                  ),
                  StreamBuilder<AutocomleteRecipeModel>(
                      stream: searchBloc.searchRecipeStream,
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (snapshot.data == null)
                                ? 0
                                : snapshot.data.recipeList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SearchRecipePage(snapshot.data.recipeList[index].title)));
                                },
                                child: ListTile(
                                  title: Text(
                                    snapshot.data.recipeList[index].title,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ],
              );
            }),
      ),    
    );
  }
}
