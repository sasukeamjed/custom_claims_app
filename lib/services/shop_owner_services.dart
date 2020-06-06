import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ShopOwnerServices{


  Future<void> addProduct({@required String shopName, @required String productName, @required double price, @required List<Asset> assets}) async{
    assert(shopName != null && productName != null && price != null, 'can not accept a null value');

    try{
      List<String> imagesUrls = await _uploadImages(assets);

      DocumentSnapshot shopDocument = await Firestore.instance.collection('Shops').document(shopName).get();
      if(shopDocument.exists){
        return shopDocument.reference.collection('Products').document().setData({
          'productName' : productName,
          'price' : price,
          'imagesUrls' : imagesUrls
        });
      }

    }catch(e){
      print('data_managment.dart 95: $e');
    }

  }

  Future<List<String>> _uploadImages(List<Asset> assets) async{
    print('Uploading Images');
    List<String> urls = [];
    await Future.forEach(assets, (asset) async {
      try{
        ByteData byteData = await asset.requestOriginal();
        List<int> imageData = byteData.buffer.asUint8List();
        StorageReference ref = FirebaseStorage.instance.ref().child(asset.name);
        StorageUploadTask uploadTask = ref.putData(imageData);

        String url = await (await uploadTask.onComplete).ref.getDownloadURL();
        urls.add(url.toString());
        print('Done Uploading Images');
      }catch(e){
        print('--------------Error while uploading------ ($e)');
      }
    });
    print(urls);
    return urls;
  }

}