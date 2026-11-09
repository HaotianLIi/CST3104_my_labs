import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  List<String> items = [];
  List<String> quantities = [];

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void addItem() {
    if (_itemController.text.isEmpty || _quantityController.text.isEmpty) return;

    setState(() {
      items.add(_itemController.text);
      quantities.add(_quantityController.text);
    });

    _itemController.clear();
    _quantityController.clear();
  }

  void showDeleteDialog(int rowNum) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you want to delete ${items[rowNum]}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                items.removeAt(rowNum);
                quantities.removeAt(rowNum);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${rowNum + 1}: ${items[rowNum]}'),
                  Text('quantity: ${quantities[rowNum]}'),
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