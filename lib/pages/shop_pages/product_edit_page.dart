import 'package:customclaimsapp/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductEditPage extends StatelessWidget {
  final Product product;

  const ProductEditPage({Key key, @required this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Edit Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ListView(
          children: <Widget>[
            GridView(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: product.urls.map((e) => image(e)).toList(),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: TextEditingController()..text = product.productName,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: TextEditingController()
                ..text = product.productPrice.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget image(String url) {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    return Center(
      child: Stack(
        children: <Widget>[
          Image.network(url),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                print(url);
                print(firebaseStorage.storageBucket);
              },
            ),
          ),
        ],
      ),
    );
  }
}
