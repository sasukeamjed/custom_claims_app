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
      print('40 shop owner services shop name value is => ${user.shopName}');
      DocumentSnapshot shopDoc = await _db.document(user.shopName).get();
      print('42 shop owner services shop doc  => ${shopDoc.data}');
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

//    return _db.document(user.shopName)
//        .collection('products')
//        .snapshots()
//        .map((query) => query.documents)
//        .map((snapshot) =>
//        snapshot.map((document) => Product.fromFirestore(document.data)).toList());

//    return _db.document(user.shopName)
//        .collection('products')
//        .snapshots()
//        .map((query) => query.documents)
//        .map((snapshots) =>
//        snapshots.map((document) => Product.fromFirestore(document.data)).toList());

    return _db
        .document(user.shopName)
        .collection('products')
        .snapshots()
        .map((query) => query.documents)
        .map((snapshots) {
      return snapshots
          .map((document){
            print('shop owner services 86 snapshot data => ${document.data}');
            print('shop owner services 87 images urls data => ${document.data['imagesUrls'].runtimeType}');
            List<String> urls = document.data['imagesUrls'].cast<String>();
            print('shop owner services 89 images urls data => ${urls.runtimeType}');
            Product product = Product(uid: document.documentID, productName: document.data['productName'], productPrice: document.data['price'], urls: urls);
            user.products.add(product);
            return product;
//            return Product(uid: document.documentID, productName: document.data['productName'], productPrice: document.data['price'], urls: document.data['imagesUrls']);
//            return Product.fromFirestore(document.data, document.documentID);
      })
          .toList();
    });
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

  Future<Product> updateProduct(Product updatedProduct, List<Asset> chosedImages) async{
    //First: check if the orginalProduct is equal the updated product, and if the choosed images are null or not
    print('shop owner Services 117 => updatedProduct uid = ${updatedProduct.uid}');
    print('shop owner Services 118 => products uid = ${user.products}');
    _fetchingData.sink.add(true);
    Product orginalProduct = user.products.firstWhere((product) {
      print('shop owner Services 120 => updatedProduct uid = ${updatedProduct.uid}, orginalProduct uid = ${product.uid}');

      return product.uid == updatedProduct.uid;
    }, orElse: (){
      print('shop owner Services 124 => product not found');
      _fetchingData.sink.add(false);
      return null;
    });
    if(updatedProduct != orginalProduct || chosedImages != null){
      List<String> updatedUrls;
      List<String> urls = updatedProduct.urls;
      try{
        if(chosedImages != null){
          updatedUrls = await _uploadImages(chosedImages, user.shopName, updatedProduct.productName);
          urls = urls + updatedUrls;
        }

        await _db.document(user.shopName).collection('products').document(updatedProduct.uid).updateData({
          'productName': updatedProduct.productName,
          'price': updatedProduct.productPrice,
          'imagesUrls' : urls,
        });

      }catch(e){
        print('shop owner services 143 error: $e');
        _fetchingData.sink.add(false);
      }
    }
    _fetchingData.sink.add(false);
  }

  Future<void> deleteImageFromProduct({@required Product product,@required String imageUrl}) async {
    try{
      if(product.urls.remove(imageUrl)){
        await _db.document(user.shopName)
            .collection('products')
            .document(product.uid).updateData({'imagesUrls': product.urls});
        print('Image Removed');
      }else{
        print('Failed to Remove Image');
      }
    }catch(e){
      print('shop owner services 152 error: $e');
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
