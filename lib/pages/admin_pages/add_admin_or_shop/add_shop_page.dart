import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    print('Add Shop Page is Build');

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
              decoration: InputDecoration(
                  fillColor: Colors.white, hintText: 'Shop Name'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Shop Owner Name'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Shop Owner Email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Phone Number'),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              child: Text("Add Shop"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );


  }
}
