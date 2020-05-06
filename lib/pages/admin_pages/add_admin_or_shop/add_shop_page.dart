import 'package:flutter/material.dart';

class AddShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Add Shop Page is Build');
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red
              ),
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'Shop Name'
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Shop Owner Name'
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
