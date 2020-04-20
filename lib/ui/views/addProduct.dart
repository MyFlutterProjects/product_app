import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/core/models/productModel.dart';
import 'package:shopping_cart/core/viewModels/CRUDModel.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String productType = 'Bag';
  String title;
  String price;

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding( 
        padding: EdgeInsets.all(12),
        child: Form( 
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField( 
                decoration: InputDecoration( 
                  border: InputBorder.none,
                  hintText: 'Product Title',
                  fillColor: Colors.grey[300], 
                  filled: true,
                ),
                validator: (value) {
                  if ( value.isEmpty) {
                    return 'Please enter Product Title';
                  }
                },
                onSaved: (value) => title = value,
              ),
              SizedBox(height: 16,),
              TextFormField( 
                keyboardType: TextInputType.number,
                decoration: InputDecoration( 
                    border: InputBorder.none,
                    hintText: 'Price',
                    filled: true,
                    fillColor: Colors.grey[300],
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the price';
                      }
                    },
                    onSaved: (value) => price = value,
              ),
              DropdownButton<String>( 
                value: productType,
                onChanged: (String newValue) {
                  setState(() {
                    productType = newValue;
                  });
                },
                items: <String>['Bag', 'Computer', 'Dress', 'Phone', 'Shoes']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>( 
                     value: value,
                     child: Text(value),
                  );
                
                }).toList(),
              ),
              RaisedButton( 
                splashColor: Colors.red,
                onPressed: () async { 
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await productProvider.addProduct(
                      Product(
                        name: title, 
                        price: price,
                        img: productType.toLowerCase()
                    ));
                   
                  }
                   Navigator.pop(context);

                },
                child: Text('add Product',
                 style: TextStyle(color: Colors.white),),
                 color: Colors.blue,
              )
            ],),
        ),
      ),
      
    );
  }
}