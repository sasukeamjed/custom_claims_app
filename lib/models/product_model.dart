import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String uid;
  final String productName;
  final double productPrice;
  final List<String> urls;

  Product({this.uid, this.productName, this.productPrice, this.urls});

  @override
  // TODO: implement props
  List<Object> get props => [uid, productName, productPrice, urls];

}