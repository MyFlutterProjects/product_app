// for global access 

import 'package:get_it/get_it.dart';
import 'package:shopping_cart/core/services/api.dart';
import 'package:shopping_cart/core/viewModels/CRUDModel.dart';

GetIt locator = GetIt.instance;  // global access


void setupLocator() {
  locator.registerLazySingleton(() => Api('products'));
  locator.registerLazySingleton(() => CRUDModel());
}

//  It's a locator for your objects
//   so you need some other way to notify your
//   UI about changes like Streams or ValueNotifiers