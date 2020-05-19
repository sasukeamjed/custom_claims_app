import 'package:flutter/material.dart';

class AddShopPage extends StatelessWidget {
  double width = 150;
  double height = 150;

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
                        padding: EdgeInsets.only(right: 0.0, bottom: 0),
                        child: IconButton(
                          iconSize: width / 3,
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {},
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

//    return LayoutBuilder(
//      builder: (BuildContext context, BoxConstraints viewportConstraints) {
//        print(viewportConstraints.maxHeight);
//        return Padding(
//          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//          child: SingleChildScrollView(
//            child: ConstrainedBox(
//              constraints: BoxConstraints(
//                minHeight: viewportConstraints.maxHeight,
//              ),
//              child: IntrinsicHeight(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Container(
//                      width: width,
//                      height: height,
//                      child: Stack(
//                        alignment: Alignment.bottomRight,
//                        children: <Widget>[
//                          Container(
//                            width: width,
//                            height: height,
//                            decoration: BoxDecoration(
//                                color: Colors.green, shape: BoxShape.circle),
//                            child: Center(
//                              child: Image.asset('assets/shop.png'),
//                            ),
//                          ),
//                          Positioned(
//                            bottom: -10,
//                            right: -10,
//                            child: Align(
//                              alignment: Alignment.bottomRight,
//                              child: Padding(
//                                padding: EdgeInsets.only(right: 0.0, bottom: 0),
//                                child: IconButton(
//                                  iconSize: width / 3,
//                                  icon: Icon(Icons.add_a_photo),
//                                  onPressed: () {},
//                                ),
//                              ),
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                    TextField(
//                      decoration: InputDecoration(
//                          fillColor: Colors.white, hintText: 'Shop Name'),
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    TextField(
//                      decoration: InputDecoration(hintText: 'Shop Owner Name'),
//                    ),
//                    Spacer(),
//                    RaisedButton(
//                      child: Text("Add Shop"),
//                      onPressed: () {},
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
  }
}
