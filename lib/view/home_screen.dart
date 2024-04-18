// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:projetopratico/view/custom_search_delegate.dart';
import 'package:projetopratico/view/list_details_screen.dart';
import 'shopping_item.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<ShoppingItem>> shoppingLists = {};
  List<ShoppingItem> searchResults = [];
  void _createNewShoppingList() {
    TextEditingController newListNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nova Lista de Compras'),
          content: TextField(
            controller: newListNameController,
            decoration: const InputDecoration(
              hintText: 'Digite o nome da lista',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Criar'),
              onPressed: () {
                String newListName = newListNameController.text;
                if (newListName.isNotEmpty) {
                  setState(() {
                    shoppingLists[newListName] = []; 
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
void _editShoppingList(String listName) {
  if (!shoppingLists.containsKey(listName)) return; 
  TextEditingController editListNameController = TextEditingController(text: listName);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar nome da lista'),
        content: TextField(
          controller: editListNameController,
          decoration: const InputDecoration(hintText: 'Digite o novo nome da lista'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              String newName = editListNameController.text;
              if (newName.isNotEmpty && newName != listName) {
                setState(() {
                  shoppingLists[newName] = shoppingLists[listName]!;
                  shoppingLists.remove(listName);
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}
void _removeShoppingList(String listName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Remover Lista'),
        content: Text('Tem certeza de que deseja remover a lista "$listName"?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          TextButton(
            child: const Text('Remover'),
            onPressed: () {
              if (shoppingLists.containsKey(listName)) {
                setState(() {
                  shoppingLists.remove(listName); 
                });
                Navigator.of(context).pop(); 
              }
            },
          ),
        ],
      );
    },
  );
}
void _addItemToList(String listName) {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Adicionar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: itemNameController,
              decoration: const InputDecoration(labelText: 'Nome do Item'),
            ),
            TextField(
              controller: itemQuantityController,
              decoration: const InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (!shoppingLists.containsKey(listName)) {
                shoppingLists[listName] = []; 
              }
              shoppingLists[listName]!.add(
                ShoppingItem(
                  name: itemNameController.text,
                  quantity: int.tryParse(itemQuantityController.text) ?? 1,
                ),
              );
              Navigator.pop(context); 
              setState(() {}); 
            },
            child: const Text('Adicionar'),
          ),
        ],
      );
    },
  );
}
  void _editItemInList(String listName, String itemName) {
  if (!shoppingLists.containsKey(listName)) {
    return;
  }
  List<ShoppingItem>? items = shoppingLists[listName];
  int itemIndex = items!.indexWhere((item) => item.name == itemName);
  if (itemIndex == -1) {
    return;
  }
  ShoppingItem itemToEdit = items[itemIndex];
  TextEditingController itemNameController = TextEditingController(text: itemToEdit.name);
  TextEditingController itemQuantityController = TextEditingController(text: itemToEdit.quantity.toString());
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: itemNameController,
              decoration: const InputDecoration(labelText: 'Nome do Item'),
            ),
            TextField(
              controller: itemQuantityController,
              decoration: const InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              itemToEdit.name = itemNameController.text;
              itemToEdit.quantity = int.tryParse(itemQuantityController.text) ?? itemToEdit.quantity;
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}
void _removeItemFromList(String listName, String itemName) {
  if (!shoppingLists.containsKey(listName)) {
    return;
  }
  List<ShoppingItem>? items = shoppingLists[listName];
  int itemIndex = items!.indexWhere((item) => item.name == itemName);
  if (itemIndex != -1) {
    setState(() {
      items.removeAt(itemIndex);
    });
  }
}
void _toggleItemBought(String listName, String itemName, bool isBought) {
  if (!shoppingLists.containsKey(listName)) {
    return;
  }
  List<ShoppingItem> items = shoppingLists[listName]!;
  int itemIndex = items.indexWhere((item) => item.name == itemName);
  if (itemIndex != -1) {
    setState(() {
      items[itemIndex].isBought = isBought;
    });
  }
}
  void _searchForItem(String query) {
    List<ShoppingItem> results = [];
    shoppingLists.forEach((listName, items) {
      results.addAll(items.where((item) => item.name.toLowerCase().contains(query.toLowerCase())));
    });
    setState(() {
      searchResults = results; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas de Compras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(shoppingLists),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: shoppingLists.keys.length,
        itemBuilder: (context, index) {
          String listName = shoppingLists.keys.elementAt(index);
          return ListTile(
            title: Text(listName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListDetailsScreen(
                    listName: listName,
                    items: shoppingLists[listName]!,
                    onAddItem: (newItem) {
                    },
                    onEditItem: (editedItem, index) {
                    }, 
              
                  ),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
            ],),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewShoppingList,
        tooltip: 'Criar Lista',
        child: const Icon(Icons.add),
      ),
    );
  }
}
