import 'package:customclaimsapp/services/shop_owner_services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  final String shopName;

  const AddProductPage({Key key, this.shopName}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<Asset> images = List<Asset>();
  String _error;
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (resultList == null) {
        images = [];
        return;
      }
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ShopOwnerServices shopServices = Provider.of<Object>(context);
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          children: <Widget>[
            Container(
              height: 300,
              width: 300,
              child: buildGridView(),
            ),
            SizedBox(
              height: 25.0,
            ),
            RaisedButton(
              child: Text('Pick Product Images'),
              onPressed: (){
                FocusScopeNode currentFocus = FocusScope.of(context);
                if(!currentFocus.hasPrimaryFocus){
                  currentFocus.unfocus();
                }
                loadAssets();
              },
            ),
            SizedBox(
              height: 25.0,
            ),
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                hintText: 'Product Name',
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(
                hintText: 'Product Price',
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            StreamBuilder<bool>(
              stream: shopServices.fetchingData,
              builder: (context, snapshot) {
                if(snapshot.data){
                  print('add product page 135 => ${snapshot.data}');
                  return CircularProgressIndicator();
                }
                return RaisedButton(
                  child: Text('Add The Product To Firebase'),
                  onPressed: (){
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus){
                      currentFocus.unfocus();
                    }
                    shopServices.addProduct(productName: _productNameController.text, price: double.parse(_productPriceController.text), assets: images);
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
