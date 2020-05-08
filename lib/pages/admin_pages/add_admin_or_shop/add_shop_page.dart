import 'package:flutter/material.dart';

class AddShopPage extends StatelessWidget {
  double width = 200;
  double height = 200;

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
                      shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Image.asset('assets/shop.png'),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right:0.0, bottom: 0),
                        child: IconButton(
                          iconSize: width / 3,
                          icon: Icon(Icons.add_a_photo),
                          onPressed: (){},
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
          ],
        ),
      ),
    );
  }
}
