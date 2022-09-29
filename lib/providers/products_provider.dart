import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  int? _selectedProductIndex;

  final _products = [
    Product(image: 'assets/images/shoes1.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes2.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes1.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes2.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes1.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes2.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes1.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes2.jpg', name: 'Sapato'),
    Product(image: 'assets/images/shoes1.jpg', name: 'Sapato'),
  ];

  void fetchMoreProducts() {
    _products.add(Product(image: 'assets/images/shoes1.jpg', name: 'Sapato'));
    _products.add(Product(image: 'assets/images/shoes2.jpg', name: 'Sapato'));
    notifyListeners();
  }

  void setSelectedProductIndex(int index) {
    _selectedProductIndex = index;
  }

  List<Product> get products => [..._products];

  int? get selectedProductIndex => _selectedProductIndex;

  Product get selectedProduct => _products.elementAt(_selectedProductIndex!);
}
