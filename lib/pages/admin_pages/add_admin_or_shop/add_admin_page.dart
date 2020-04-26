import 'package:customclaimsapp/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAdminPage extends StatelessWidget {
  TextEditingController _emailText = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final adminService = Provider.of<AdminService>(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _fullName,
              decoration: InputDecoration(
                hintText: 'Admin Full Name',
              ),
            ),
            TextField(
              controller: _emailText,
              decoration: InputDecoration(
                hintText: 'Admin Email',
              ),
            ),
            TextField(
              controller: _phoneNumber,
              decoration: InputDecoration(
                hintText: 'Admin Phone Number',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              child: Text('Add The Admin'),
              onPressed: () async {
                await adminService.addAdmin(
                    _fullName.text, _emailText.text, _phoneNumber.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
