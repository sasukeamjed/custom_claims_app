import 'package:flutter/material.dart';

class AddAdminPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Admin Full Name',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Admin Email',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Admin Phone Number',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              child: Text('Add The Admin'),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}