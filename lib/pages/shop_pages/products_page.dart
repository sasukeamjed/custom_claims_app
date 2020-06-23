import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/pages/shop_pages/product_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Products'),
      ),
      body: GridView.builder(
        itemCount: products.length,
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
                      child: Image.network(
                        products[index].urls[0],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(products[index].productName),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: Text(products[index].productPrice.toString()),
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
                            ProductEditPage(product: products[index],),
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

