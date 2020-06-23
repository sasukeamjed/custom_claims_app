import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductEditPage extends StatelessWidget {
  final Product product;

  const ProductEditPage({Key key, @required this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print('product edit page is rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Edit Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              width: 200,
              child: GridView.builder(
                itemCount: product.urls.length,
                shrinkWrap: true,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index){
                  return image(product.urls[index], context);
                },
              ),
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

  Widget image(String url, BuildContext context) {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final services = Provider.of<ShopOwnerServices>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Image.network(url),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                child: Icon(Icons.delete),
                onTap: ()async {
                  services.deleteImageFromProduct('fish', product, url);
//
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
