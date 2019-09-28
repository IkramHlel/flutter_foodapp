import 'package:flutter/material.dart';

import '../blocs/auth_bloc.dart';

import 'package:flutter_food_app/pages/auth.dart';
import '../pages/recipes.dart';
import '../pages/search_admin.dart';

class SlideDrawer extends StatelessWidget {
  BuildContext context;
  final bloc = AuthBloc();

  SlideDrawer(this.context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Choose'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All products'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => RecipesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search recipes'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => SearchAdminPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              bloc.logout();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => AuthPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
