// shopping_item.dart

import 'package:floor/floor.dart';

@entity
class ShoppingItem {
  // The next id to give to a new item.
  static int ID = 1;

  @primaryKey
  final int id;
  final String name;
  final String quantity;

  ShoppingItem(this.id, this.name, this.quantity) {
    // Items loaded from the database may already have big ids,
    // so make sure the next new item gets a higher one.
    if (id >= ID) {
      ID = id + 1;
    }
  }
}