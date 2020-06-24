import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class ProductEditPage extends StatefulWidget {
  final Product product;

  const ProductEditPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {

  List<Asset> chosedImages = List<Asset>();
  String _error;

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(chosedImages.length, (index) {
        Asset asset = chosedImages[index];
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
      chosedImages = List<Asset>();
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
        chosedImages = [];
        return;
      }
      chosedImages = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    print('product edit page is rebuild');
    print(widget.product.urls.length);
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
                itemCount: widget.product.urls.length + chosedImages.length,
                shrinkWrap: true,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index){
                  List<dynamic> images = [...widget.product.urls, ...chosedImages];
                  return image(images[index], context);
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text('Pick Images'),
              onPressed: loadAssets,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: TextEditingController()..text = widget.product.productName,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: TextEditingController()
                ..text = widget.product.productPrice.toString(),
            ),
            RaisedButton(
              child: Text('Update Product'),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }

  Widget image(image,BuildContext context) {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final services = Provider.of<ShopOwnerServices>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            image is String ? Image.network(image, height: 300, width: 300,) : AssetThumb(asset: image, height: 300, width: 300,),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                child: Icon(Icons.delete),
                onTap: ()async {
                  await services.deleteImageFromProduct('fish', widget.product, image);
                  setState(() {

                  });

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
