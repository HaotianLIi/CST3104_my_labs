// database.dart

// required package imports
import 'dart:async';
import './shopping_item_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'shopping_item.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ShoppingItem])
abstract class AppDatabase extends FloorDatabase {
  ShoppingItemDAO get shoppingItemDao;
}