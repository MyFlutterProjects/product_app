import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/core/models/productModel.dart';
import 'package:shopping_cart/core/services/api.dart';
import 'package:shopping_cart/locator.dart';

class CRUDModel extends ChangeNotifier { 
  // class handles operations in the Api class 

  Api _api = locator<Api>();

  List<Product> products;

  Future<List<Product>> fetchProducts() async { 
    var result = await _api.getDataCollection();
    products = result.documents
      .map((doc) => Product.fromMap(doc.data, doc.documentID))
      .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    var response = _api.streamDataCollection();
    print('Response $response');
    return response;
  }

  Future<Product> getProductById(String id) async { 
    var doc = await _api.getDocumentById(id);
    return Product.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String id) async { 
    await _api.removeDocument(id);
    return;
  }

  Future updateProduct(Product data, String id ) async { 
    var result = await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(Product data) async { 
    var result = await _api.addDocument(data.toJson());
    return;
  }
}