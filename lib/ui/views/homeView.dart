import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/core/models/productModel.dart';
import 'package:shopping_cart/core/viewModels/CRUDModel.dart';
import 'package:shopping_cart/ui/widgets/productCard.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);
    return Scaffold( 

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/addProduct');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar( 
        title: Center(child: Text('My products app'),),
      ),
      body: Container(
        child: StreamBuilder( 
          stream: productProvider.fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.documents 
              .map((doc) => Product.fromMap(doc.data,doc.documentID))
              .toList();
              return ListView.builder( 
                itemCount: products.length,
                itemBuilder: (buildContext, index) => ProductCard(productDetails: products[index]),
              );
            } else {
              return Text('fetching');
            }
          },

        ),
      ),
      
    );
  }
}