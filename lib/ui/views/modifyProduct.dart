import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/core/models/productModel.dart';
import 'package:shopping_cart/core/viewModels/CRUDModel.dart';

class ModifyProduct extends StatefulWidget {
  final Product product;
  ModifyProduct({@required this.product});

  @override
  _ModifyProductState createState() => _ModifyProductState();
}

class _ModifyProductState extends State<ModifyProduct> {
   final _formKey = GlobalKey<FormState>();
   String productType;
   String title;
   String price;

  @override
  Widget build(BuildContext context) {   
    final productProvider = Provider.of<CRUDModel>(context);
    productType = widget.product.img[0].toUpperCase() + widget.product.img.substring(1);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar( 
        title: Center(child: Text('Modify Product details'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form( 
          key: _formKey,
          child: Column( 
            children: <Widget>[
              TextFormField( 
                initialValue: widget.product.name,
                decoration: InputDecoration( 
                  border: InputBorder.none,
                  hintText: 'Product Title',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Please enter Product Title';
                  }
                },
                onSaved: (value) => title = value,
              ),
              SizedBox(height: 16,),
              TextFormField( 
                initialValue: widget.product.price,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration( 
                  border: InputBorder.none,
                  hintText: 'Price',
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Please enter the price';
                  }
                },
                onSaved: (value) => price = value,
              ),
              
              DropdownButton<String> ( 
                value: productType,
                onChanged: (String newValue) {
                  setState(() {
                    print(newValue);
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
                    await productProvider
                    .updateProduct( 
                      Product( 
                        name:title,
                        price: price,
                        img: productType.toLowerCase()
                        ), widget.product.id);
                  }
                  Navigator.pushNamed(context,'/');
                  
                },
                child: Text('Modify Product',  
                style: TextStyle(color: Colors.white),),
                color: Colors.blue,
              )
            ],),
          
        ),
      ),
      
    );
  }
}