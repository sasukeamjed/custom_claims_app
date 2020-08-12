import 'package:customclaimsapp/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAdminPage extends StatelessWidget {
  TextEditingController _emailText = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Add Admin Page is Build');
    final AdminService adminService = Provider.of<Object>(context);

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
                FocusScopeNode currentFocus = FocusScope.of(context);
                if(!currentFocus.hasPrimaryFocus){
                  currentFocus.unfocus();
                }
                await adminService.registerNewAdmin(idToken: adminService.user.token,
                   fullName: _fullName.text, email: _emailText.text, phoneNumber: _phoneNumber.text);
              },
            ),
            StreamBuilder<bool>(
              stream: adminService.registeringUser,
              builder: (BuildContext context, snapshot){
                return snapshot.data == true ? CircularProgressIndicator() : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
