import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/core/viewModels/CRUDModel.dart';
import 'package:shopping_cart/locator.dart';
import 'package:shopping_cart/ui/router.dart';

void main() { 
  setupLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_) => locator<CRUDModel>(),        
          ),
      ],
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Product App',
        theme: ThemeData(),
        onGenerateRoute: Router.generateRoute,
      ),
   
      
    );
  }
}