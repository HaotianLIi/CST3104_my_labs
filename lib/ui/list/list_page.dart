import 'package:flutter/material.dart';
import 'package:my_labs/database/database.dart';
import 'package:my_labs/database/shopping_item.dart';
import 'package:my_labs/database/shopping_item_dao.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // Lab7: the list now holds ShoppingItem objects instead of Strings.
  List<ShoppingItem> items = [];

  // Lab7: DAO object, set in initState() once the database is open.
  late ShoppingItemDAO myDAO;

  @override
  void initState() {
    super.initState();

    // Lab7: open the database and load the items saved last time.
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((database) {
      // get the database DAO object
      myDAO = database.shoppingItemDao;
      myDAO.getAllItems().then((listOfItems) {
        // add the items from the database
        setState(() {
          items.clear();
          items.addAll(listOfItems);
        });
      });
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void addItem() {
    if (_itemController.text.isEmpty || _quantityController.text.isEmpty) return;

    setState(() {
      // Lab7: create the item with a new id, save it in the database, then show it.
      var newItem = ShoppingItem(ShoppingItem.ID++, _itemController.text, _quantityController.text);
      myDAO.insertItem(newItem);
      items.add(newItem);
    });

    _itemController.clear();
    _quantityController.clear();
  }

  void showDeleteDialog(int rowNum) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to delete ${items[rowNum].name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Lab7: remove from the database first, then from the list.
                myDAO.deleteItem(items[rowNum]);
                items.removeAt(rowNum);
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Widget listPage() {
    return Column(children: [
      Row(children: [
        Expanded(
          child: TextField(
            controller: _itemController,
            decoration: const InputDecoration(hintText: 'Type the item here'),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _quantityController,
            decoration: const InputDecoration(hintText: 'Type the quantity here'),
          ),
        ),
        ElevatedButton(onPressed: addItem, child: const Text('Add')),
      ]),
      Expanded(
        child: items.isEmpty
            ? const Text('There are no items in the list')
            : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, rowNum) {
            return GestureDetector(
              onLongPress: () => showDeleteDialog(rowNum),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lab7: the row now reads from the ShoppingItem object.
                  Text('${rowNum + 1}: ${items[rowNum].name}'),
                  Text('quantity: ${items[rowNum].quantity}'),
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: listPage(),
    );
  }
}