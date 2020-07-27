import 'package:customclaimsapp/services/customer_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DummyPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    CustomerServices customerServices = Provider.of<Object>(context);
    print('dummy page data ${customerServices}');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('this is the dummy page'),
            Text(customerServices.user.email),
          ],
        ),
      ),
    );
  }
}
