import 'dart:io';

import 'package:customclaimsapp/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddShopPage extends StatefulWidget {
  @override
  _AddShopPageState createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  double width = 150;
  double height = 150;

  File _shopImage;

  _pickAnImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _shopImage = image;
    });
  }

  TextEditingController _shopName = TextEditingController();
  TextEditingController _shopOwnerName = TextEditingController();
  TextEditingController _shopOwnerEmail = TextEditingController();
  TextEditingController _shopPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Add Shop Page is Build');
    final AdminService adminService = Provider.of<Object>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              height: height,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      child: _shopImage == null
                          ? Image.asset('assets/shop.png')
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.file(
                                _shopImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0.0, bottom: 0),
                        child: IconButton(
                          iconSize: width / 3,
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            _pickAnImage();
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            TextField(
              controller: _shopName,
              decoration: InputDecoration(
                  fillColor: Colors.white, hintText: 'Shop Name'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _shopOwnerName,
              decoration: InputDecoration(hintText: 'Shop Owner Name'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _shopOwnerEmail,
              decoration: InputDecoration(hintText: 'Shop Owner Email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _shopPhoneNumber,
              decoration: InputDecoration(hintText: 'Phone Number'),
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<bool>(
              stream: adminService.registeringUser,
              builder: (context, snapshot) {
                return snapshot.data != true ?
                RaisedButton(
                  child: Text("Add Shop"),
                  onPressed: ()async {

                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus){
                      currentFocus.unfocus();
                    }

                    await adminService.registerNewShop(
                        idToken: adminService.user.token,
                        shopName: _shopName.text,
                        shopOwnerName: _shopOwnerName.text,
                        shopOwnerEmail: _shopOwnerEmail.text,
                        shopOwnerPhoneNumber: _shopPhoneNumber.text);
                  },
                ) : CircularProgressIndicator();
              }
            ),
          ],
        ),
      ),
    );
  }
}
