import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
import 'package:customclaimsapp/pages/shop_pages/add_product_page.dart';
import 'package:customclaimsapp/pages/shop_pages/products_page.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainShopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('Main shop page is build');
    final _auth = Provider.of<AuthService>(context);
    final shop = Provider.of<ShopOwner>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Shop Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await _auth.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<ShopOwner>(
          builder: (BuildContext context, shop, widget){
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Shop Name'),
                  subtitle: Text(shop.shopName),
                ),
                ListTile(
                  title: Text('Shop Owner Name'),
                  subtitle: Text(shop.shopOwnerName),
                ),
                ListTile(
                  title: Text('Shop Email'),
                  subtitle: Text(shop.email),
                ),
                ListTile(
                  title: Text('Shop Phone Number'),
                  subtitle: Text(shop.phoneNumber),
                ),
                ListTile(
                  title: Text('Products Numbers'),
                  subtitle: Text(shop.products.length.toString()),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsPage(products: shop.products,)));
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddProductPage(shopName: shop.shopName,)));
        },
      ),
    );
  }
}
