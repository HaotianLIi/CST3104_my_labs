// shopping_item_dao.dart

import 'package:floor/floor.dart';
import 'shopping_item.dart';

@dao
abstract class ShoppingItemDAO {
  @Query('SELECT * FROM ShoppingItem')
  Future<List<ShoppingItem>> getAllItems();

  @insert
  Future<void> insertItem(ShoppingItem itm);

  @delete
  Future<void> deleteItem(ShoppingItem itm);
}