import 'package:customclaimsapp/pages/admin_pages/add_admin_or_shop/add_user_page.dart';
import 'package:customclaimsapp/pages/admin_pages/stats_page.dart';
import 'package:flutter/material.dart';

class MainAdminPage extends StatefulWidget {

  @override
  _MainAdminPageState createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {
  int index = 0;

  List<Widget> page = [StatsPage(), AddUserPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Admin Page'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i){
          setState(() {
            index = i;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Add'),
          ),
        ],
      ),
      body: page[index],
    );
  }
}







