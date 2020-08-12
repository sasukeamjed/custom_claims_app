import 'package:customclaimsapp/pages/admin_pages/add_admin_or_shop/add_admin_page.dart';
import 'package:customclaimsapp/pages/admin_pages/add_admin_or_shop/add_shop_page.dart';

import 'package:flutter/material.dart';

class AddUserPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print('Add User Page is Build');
    return Scaffold(
      backgroundColor: Colors.brown,
      body: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  color: Theme.of(context).accentColor,
                  child: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.supervised_user_circle)),
                      Tab(icon: Icon(Icons.shop)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AddAdminPage(),
                    AddShopPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

