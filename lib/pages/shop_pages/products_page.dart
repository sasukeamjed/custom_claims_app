import 'package:customclaimsapp/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  const ProductsPage({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Products'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: products
            .map(
              (p) => Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                        p.urls[0],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(p.productName),
                    SizedBox(
                      height: 10,
                    ),
                    Text(p.productPrice.toString()),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
