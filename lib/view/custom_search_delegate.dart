import 'package:flutter/material.dart';
import 'shopping_item.dart';

class CustomSearchDelegate extends SearchDelegate<ShoppingItem> {
  final Map<String, List<ShoppingItem>> shoppingLists;

  CustomSearchDelegate(this.shoppingLists);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }
@override
Widget buildLeading(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      close(context, ShoppingItem(name: 'Nome do Item', quantity: 1, isBought: false)); 
    },
  );
}
  @override
  Widget buildResults(BuildContext context) {
    List<ShoppingItem> results = [];
    shoppingLists.forEach((listName, items) {
      results.addAll(items.where(
        (item) => item.name.toLowerCase().contains(query.toLowerCase()),
      ));
    });
    return ListView(
      children: results.map((item) => ListTile(
        title: Text(item.name),
        leading: Icon(item.isBought ? Icons.check : Icons.shopping_cart),
        subtitle: Text('Quantity: ${item.quantity}'),
        onTap: () {
          close(context, item);
        },
      )).toList(),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<ShoppingItem> suggestions = [];
    shoppingLists.forEach((listName, items) {
      suggestions.addAll(items.where(
        (item) => item.name.toLowerCase().contains(query.toLowerCase()),
      ));
    });
    return ListView(
      children: suggestions.map((item) => ListTile(
        title: Text(item.name),
        leading: Icon(item.isBought ? Icons.check : Icons.shopping_cart),
        subtitle: Text('Quantity: ${item.quantity}'),
        onTap: () {
          query = item.name;
          showResults(context);
        },
      )).toList(),
    );
  }
}
