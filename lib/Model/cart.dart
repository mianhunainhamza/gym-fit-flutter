import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';
import 'catalog.dart';

class CartModel {
  //catalog field
  late CatalogModel catalog;

  //list of ids
  final List<int> itemIds = [];

  //get items to the cart
  List get items => itemIds.map((id) => catalog.getById(id)).toList();

  //get total price
  num get totalPrice =>
      items.fold(0, (previousValue, element) => previousValue + element.prices);
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;
  AddMutation(this.item);
  @override
  perform() {
    store?.cart.itemIds.add(item.id);
    throw UnimplementedError();
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;
  RemoveMutation(this.item);
  @override
  perform() {
    store?.cart.itemIds.remove(item.id);
    // TODO: implement perform
    throw UnimplementedError();
  }
}
