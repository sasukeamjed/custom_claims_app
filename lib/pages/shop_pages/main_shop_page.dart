import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/pages/shop_pages/add_product_page.dart';
import 'package:customclaimsapp/pages/shop_pages/products_page.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Main shop page is build');
    final _auth = Provider.of<AuthService>(context);
    final ShopOwnerServices shop = Provider.of<Object>(context);

    print('this shit is : ${shop}');

    if (shop == null) {
      return Scaffold(
        body: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Shop Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Shop Name'),
              subtitle: Text(shop == null ? 'Waiting...' : shop.user.shopName),
            ),
            ListTile(
              title: Text('Shop Owner Name'),
              subtitle: Text(
                  shop.user == null ? 'Waiting...' : shop.user.shopOwnerName),
            ),
            ListTile(
              title: Text('Shop Email'),
              subtitle:
                  Text(shop.user == null ? 'Waiting...' : shop.user.email),
            ),
            ListTile(
              title: Text('Shop Phone Number'),
              subtitle: Text(
                  shop.user == null ? 'Waiting...' : shop.user.phoneNumber),
            ),
            StreamBuilder<List<Product>>(
                stream: shop.products,
                builder: (context, snapshot) {
                  print('62 main shop page connection state => ${snapshot.connectionState}');
                  print('63 main shop page snapshot data => ${snapshot.data}');
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListTile(
                    title: Text(
                        shop.user == null ? 'Waiting...' : 'Products Numbers'),
                    subtitle: Text(snapshot.data.length.toString()),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsPage(
                            products: snapshot.data,
                          ),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProductPage(
                        shopName: shop.user.shopName,
                      )));
        },
      ),
    );
  }
}
