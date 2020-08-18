import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/models/users/shop_owner_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ShopOwnerServices extends ChangeNotifier {
  final ShopOwner user;

  final BehaviorSubject<bool> _fetchingData = BehaviorSubject<bool>();

  Stream<bool> get fetchingData => _fetchingData.stream;

  Stream<List<Product>> get products => _fetchAllProductsByShopName();

  CollectionReference _db = Firestore.instance
      .collection('Custom_claims_app')
      .document('users')
      .collection('shops');

  ShopOwnerServices({@required this.user})
      : assert(user != null, 'user in shopservice is null');

  Future<void> addProduct(
      {@required String productName,
      @required double price,
      @required List<Asset> assets}) async {

    assert(user != null && productName != null && price != null,
        'can not accept a null value');

    _fetchingData.sink.add(true);

    try {
      print('39 shop owner services shop name value is => ${user.shopName}');
      DocumentSnapshot shopDoc = await _db.document('shop_name').get();
      print('41 shop owner services shop doc  => ${shopDoc.data}');
      if (shopDoc.exists) {
        List<String> imagesUrls = await _uploadImages(assets, user.shopName, productName);
        await shopDoc.reference.collection('products').document().setData({
          'productName': productName,
          'price': price,
          'imagesUrls': imagesUrls
        });
      } else {
        _fetchingData.sink.add(false);
        throw "error: shop do not exits";
      }

      _fetchingData.sink.add(false);
    } catch (e) {
      _fetchingData.sink.add(false);
      print('58 shop owner services : $e');
    }
  }

  Stream<List<Product>> _fetchAllProductsByShopName() {
    return _db
        .document(user.shopName)
        .collection('products')
        .snapshots()
        .map((query) => query.documents)
        .map((snapshots) => snapshots
            .map((document) => Product(
                uid: document.documentID,
                productName: document.data['productName'],
                productPrice: document.data['price'],
                urls: document.data['imagesUrls']))
            .toList());

//    return Firestore.instance
//        .collection('Shops')
//        .document(user.shopName)
//        .collection('products')
//        .snapshots()
//        .map((query) => query.documents)
//        .map((snapshots) {
//      return snapshots
//          .map((document){
//            print('71 shop owner services snapshot data => ${document.data}');
//            return Product(
//                uid: document.documentID,
//                productName: document.data['productName'],
//                productPrice: document.data['price'],
//                urls: document.data['imagesUrls']);
//      })
//          .toList();
//    });
  }

//  Future<List<Product>> fetchAllProducts({@required String shopName}) async {
//    print('shop_owner_services 36 => fetchAllProducts function is fired');
//    List<Product> products = [];
//    try {
//      Stream<QuerySnapshot> streamOfProducts = await Firestore.instance.collection('Shops')?.document(shopName)?.collection('Products')?.getDocuments().asStream();
//      //ToDo: fetch all products
////      streamOfProducts.documents.forEach((element) {
////        products.add(Product(uid: element.documentID, productName: element.data['productName'], productPrice: element.data['price'], urls: element.data['imagesUrls'].cast<String>().toList()));
////      });
//      return products;
//    } catch (e) {
//      print('shop_owner_services 55 => $e');
//    }
//  }

  Future<void> deleteImageFromProduct(
      String shopName, Product product, String imgUrl) async {
    if (product.urls.remove(imgUrl)) {
      try {
        DocumentSnapshot doc = await Firestore.instance
            .collection('Shops')
            .document('shop name')
            .collection('Products')
            .document(product.uid)
            .get();
        Product updatedProduct = Product(
            uid: doc.documentID,
            productName: doc.data['productName'],
            productPrice: doc.data['price'],
            urls: doc.data['imagesUrls'].cast<String>().toList());

        print(
            'Orginal Product product uid : ${product.uid}, product name: ${product.productName}, product price ${product.productPrice}, product urls: ${product.urls}');
        print(
            'Fetched Product product uid : ${updatedProduct.uid}, product name: ${updatedProduct.productName}, product price ${updatedProduct.productPrice}, product urls: ${updatedProduct.urls}');

        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        StorageReference ref =
            await firebaseStorage.getReferenceFromUrl(imgUrl);
        await ref.delete();
        print('img was deleted from firebase storage');

        updatedProduct.urls.forEach((element) async {
          if (updatedProduct.urls.remove(element)) {
            await doc.reference.setData({
              'productName': updatedProduct.productName,
              'price': updatedProduct.productPrice,
              'imagesUrls': updatedProduct.urls,
            });
          } else {
            print(
                'error in shop_owner_services file line 84: there is not image with this url');
          }
          print(element);
          print(imgUrl);
          print(imgUrl == element);
        });
      } catch (e) {
        print(e);
      }
      print(
          'shop_owner_services file line 82: the url was removed successfuly from the class and the database');
      notifyListeners();
    } else {
      print(
          'error in shop_owner_services file line 84: there is not image with this url');
    }
  }

  Future<List<String>> _uploadImages(
      List<Asset> assets, String shopName, String productName) async {
    print('Uploading Images');
    List<String> urls = [];
    await Future.forEach(assets, (asset) async {
      try {
        ByteData byteData = await asset.requestOriginal();
        List<int> imageData = byteData.buffer.asUint8List();
        StorageReference ref = FirebaseStorage.instance
            .ref()
            .child('shops/$shopName/$productName/${asset.name}');
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
