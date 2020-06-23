import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customclaimsapp/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class ShopOwnerServices extends ChangeNotifier {

  Future<void> addProduct(
      {@required String shopName,
      @required String productName,
      @required double price,
      @required List<Asset> assets}) async {
    assert(shopName != null && productName != null && price != null,
        'can not accept a null value');

    try {
      List<String> imagesUrls = await _uploadImages(assets, shopName, productName);

      DocumentSnapshot shopDocument =
          await Firestore.instance.collection('Shops').document(shopName).get();
      if (shopDocument.exists) {
        print('Adding Document');
        return shopDocument.reference
            .collection('Products')
            .document()
            .setData({
          'productName': productName,
          'price': price,
          'imagesUrls': imagesUrls
        });
      }
    } catch (e) {
      print('data_managment.dart 37: $e');
    }
  }

  Future<List<Product>> fetchAllProducts({@required String shopName}) async {
    print('shop_owner_services 36 => fetchAllProducts function is fired');
    List<Product> products = [];
    try {
      QuerySnapshot docs = await Firestore.instance.collection('Shops')?.document(shopName)?.collection('Products')?.getDocuments();
      //ToDo: fetch all products
      docs.documents.forEach((element) {
        products.add(Product(uid: element.documentID, productName: element.data['productName'], productPrice: element.data['price'], urls: element.data['imagesUrls'].cast<String>().toList()));
      });
      return products;
    } catch (e) {
      print('shop_owner_services 55 => $e');
    }
  }
  

  Future<void> deleteImageFromProduct(String shopName, Product product, String imgUrl) async{

    if(product.urls.remove(imgUrl)){


      try{
        DocumentSnapshot doc = await Firestore.instance.collection('Shops').document('shop name').collection('Products').document(product.uid).get();
        Product updatedProduct = Product(uid: doc.documentID, productName: doc.data['productName'], productPrice: doc.data['price'], urls: doc.data['imagesUrls'].cast<String>().toList());

        print('Orginal Product product uid : ${product.uid}, product name: ${product.productName}, product price ${product.productPrice}, product urls: ${product.urls}');
        print('Fetched Product product uid : ${updatedProduct.uid}, product name: ${updatedProduct.productName}, product price ${updatedProduct.productPrice}, product urls: ${updatedProduct.urls}');


        //ToDo: delete the image from the firebase storage
        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        StorageReference ref = await firebaseStorage.getReferenceFromUrl(imgUrl);
        await ref.delete();
        print('img was deleted from firebase storage');

        //ToDo: delete the image url from firebase database
        updatedProduct.urls.forEach((element) async{

          if(updatedProduct.urls.remove(element)){
            await doc.reference.setData({
              'productName': updatedProduct.productName,
              'price': updatedProduct.productPrice,
              'imagesUrls': updatedProduct.urls,
            });

          }else{
            print('error in shop_owner_services file line 84: there is not image with this url');
          }
          print(element);
          print(imgUrl);
          print(imgUrl == element);
        });
      }catch(e){
        print(e);
      }
      print('shop_owner_services file line 82: the url was removed successfuly from the class and the database');
      notifyListeners();
    }else{
      print('error in shop_owner_services file line 84: there is not image with this url');
    }
  }

  Future<List<String>> _uploadImages(List<Asset> assets, String shopName, String productName) async {
    print('Uploading Images');
    List<String> urls = [];
    await Future.forEach(assets, (asset) async {
      try {
        ByteData byteData = await asset.requestOriginal();
        List<int> imageData = byteData.buffer.asUint8List();
        StorageReference ref = FirebaseStorage.instance.ref().child('shops/$shopName/$productName/${asset.name}');
        StorageUploadTask uploadTask = ref.putData(imageData);

        String url = await (await uploadTask.onComplete).ref.getDownloadURL();
        urls.add(url.toString());
        print('Done Uploading Images');
      } catch (e) {
        print('--------------Error while uploading------ ($e)');
      }
    });
    print(urls);
    return urls;
  }
}
