import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
import 'package:customclaimsapp/pages/shop_pages/product_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final ShopOwner shop;

  ProductsPage({Key key, this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Products'),
      ),
      body: GridView.builder(
        itemCount: shop.products.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: shop.products[index].urls.isEmpty ? Image.asset('assets/shop.png') : Image.network(
                        shop.products[index].urls[0],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(shop.products[index].productName),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: Text(shop.products[index].productPrice.toString()),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Align(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            ProductEditPage(product: shop.products[index],),
                      ));
                    },
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

