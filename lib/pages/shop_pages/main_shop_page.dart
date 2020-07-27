import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
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

    print('this shit is : ${shop.user}');

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
            ListTile(
              title:
                  Text(shop.user == null ? 'Waiting...' : 'Products Numbers'),
              subtitle: Text(shop.user.products.length.toString()),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductsPage(
                              shop: shop.user,
                            )));
              },
            ),
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
