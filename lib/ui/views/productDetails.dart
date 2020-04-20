import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/core/models/productModel.dart';
import 'package:shopping_cart/core/viewModels/CRUDModel.dart';
import 'package:shopping_cart/ui/views/modifyProduct.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  ProductDetails({@required this.product});


  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(  
        title: Text('Product details'),
        actions: <Widget>[
          IconButton( 
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await productProvider.removeProduct(product.id);
              Navigator.pop(context);
            },
          ),
          IconButton( 
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => ModifyProduct(product: product,)  ));
            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero( 
            tag: product.id,
            child: Image.asset( 
              'assets/${product.img}.jpg',
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(height: 20,),
          Text( 
            product.name, 
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
           Text( 
            '${product.price} UGX', 
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.orangeAccent,
            ),
          )

      ],),

      
    );
  }
}