import 'package:customclaimsapp/pages/admin_pages/add_admin_or_shop/add_user_page.dart';
import 'package:customclaimsapp/pages/admin_pages/stats_page.dart';
import 'package:customclaimsapp/services/admin_services.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAdminPage extends StatefulWidget {

  @override
  _MainAdminPageState createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {


  AdminService adminService;


  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    final providerService = Provider.of<Object>(context);
    if(providerService is AdminService){
      adminService = providerService;
    }
    super.didChangeDependencies();
  }

  int index = 0;

  List<Widget> page = [StatsPage(), AddUserPage()];

  @override
  Widget build(BuildContext context) {
    print('Main Admin Page is Build');
    final _authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Admin Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await _authService.logout();
            },
          ),
        ],
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







