import 'package:customclaimsapp/pages/customer_pages/dummy_page.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:customclaimsapp/services/customer_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCustomerPage extends StatefulWidget {

  @override
  _MainCustomerPageState createState() => _MainCustomerPageState();
}

class _MainCustomerPageState extends State<MainCustomerPage> {
  CustomerServices customerServices;
//  @override
//  void initState() {
////    customerServices = Provider.of<Object>(context);
//    print('initState in main Customer page (customerServices) value: $customerServices');
//
//    super.initState();
//  }
//
//  @override
//  void didChangeDependencies() {
//    customerServices = Provider.of<Object>(context);
//    print('didChangeDependencies in main Customer page (customerServices) value: $customerServices');
//
//    print('customer main page, ${customerServices.user}');
//    super.didChangeDependencies();
//  }

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context);
    final CustomerServices customerServices = Provider.of<Object>(context);
    print('build method in main Customer page (customerServices) value: $customerServices');
//    print('customer main page, ${customerServices.user}');
//    print('customer main page, ${customerServices.user}');

    if(CustomerServices == null){
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Customer Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async{
                await _authService.logout();
              },
            ),
          ],
        ),
        body: Center(
          child: Text("waiting....."),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Customer Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await _authService.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Main Customer Page"),
            RaisedButton(
              child: Text('Go to dummy page'),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DummyPage()));
              },
            ),
          ],
        ),
      ),
    );
  }


}
