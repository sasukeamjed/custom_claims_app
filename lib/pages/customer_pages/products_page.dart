import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/services/customer_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  CustomerServices customerServices;
  Stream<List<Product>> productsStream;
  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    customerServices = Provider.of<Object>(context);
    print('go to dummy page $customerServices');
    // customerServices.products().listen((shopEvents) {
    //   print('products_page 19 shopEvents => $shopEvents');
    //   productsStream = shopEvents[0];
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: StreamBuilder<List<Product>>(
        stream: productsStream,
        builder: (context, snapshot) {
          print(snapshot.data);
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          print(snapshot.data);
          return Center(
            child: Text("Products Page"),
          );
        }
      ),
    );
  }
}
