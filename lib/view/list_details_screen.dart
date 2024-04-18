import 'package:flutter/material.dart';
import 'package:projetopratico/view/shopping_item.dart';

class ListDetailsScreen extends StatefulWidget {
  final String listName;
  final List<ShoppingItem> items;
  final void Function(ShoppingItem) onAddItem;
  final void Function(ShoppingItem, int) onEditItem;
  const ListDetailsScreen({
    super.key,
    required this.items,
    required this.onAddItem,
    required this.onEditItem, required this.listName,
  });
  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}
class _ListDetailsScreenState extends State<ListDetailsScreen> {
  void _showEditItemDialog(ShoppingItem item, int index) {
    TextEditingController nameController = TextEditingController(text: item.name);
    TextEditingController quantityController = TextEditingController(text: item.quantity.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Nome do item'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(hintText: 'Quantidade'),
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                // Fechar o diálogo
                Navigator.of(context).pop();
                if (index >= widget.items.length) {
                  setState(() {
                    // Adicionando o novo item à lista
                    final newItem = ShoppingItem(
                      name: nameController.text,
                      quantity: int.tryParse(quantityController.text) ?? 1,
                      isBought: false,
                    );
                    widget.items.add(newItem);
                  });
                } else {
                  setState(() {
                    widget.items[index].name = nameController.text;
                    widget.items[index].quantity = int.tryParse(quantityController.text) ?? 1;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Lista - ${widget.listName}", style: const TextStyle(fontSize: 15,),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text("Quantidade: ${item.quantity}"),
            trailing: Icon(item.isBought ? Icons.check : Icons.shopping_cart),
            onTap: () => _showEditItemDialog(item, index),
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showEditItemDialog(ShoppingItem(name: '', quantity: 1, isBought: false), widget.items.length);
        },
      ),
    );
  }
}
