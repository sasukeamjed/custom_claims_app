import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/pages/shop_pages/product_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage({Key key, this.products}) : super(key: key);

  UniqueKey uniqueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    print(uniqueKey);
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
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => ProductEditPage(product: products[index],),
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



//  Widget vericRow(){
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Expanded(
//          child: Image.network(
//            p.urls[0],
//          ),
//        ),
//        SizedBox(
//          height: 10,
//        ),
//        Text(p.productName),
//        SizedBox(
//          height: 10,
//        ),
//        Row(
//          children: <Widget>[
//            Align(
//              child: Text(p.productPrice.toString()),
//              alignment: Alignment.center,
//            ),
//          ],
//        ),
//        SizedBox(
//          height: 10,
//        ),
//      ],
//    );
//  }
}

//products
//    .map(
//(p) => Card(
//child: Stack(
//children: <Widget>[
//Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Expanded(
//child: Image.network(
//p.urls[0],
//),
//),
//SizedBox(
//height: 10,
//),
//Text(p.productName),
//SizedBox(
//height: 10,
//),
//Align(
//child: Text(p.productPrice.toString()),
//alignment: Alignment.center,
//),
//SizedBox(
//height: 10,
//),
//],
//),
//Align(
//child: IconButton(
//icon: Icon(Icons.edit),
//onPressed: (){},
//),
//alignment: Alignment.bottomLeft,
//),
//],
//),
//),
//)
//    .toList(),
