// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:projetopratico/view/custom_search_delegate.dart';
import 'package:projetopratico/view/list_details_screen.dart';
import 'shopping_item.dart'; // Caminho atualizado para ShoppingItem

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  // Mapa para armazenar os nomes das listas e os itens correspondentes.
  Map<String, List<ShoppingItem>> shoppingLists = {};
  List<ShoppingItem> searchResults = [];
  // Método para criar uma nova lista de compras.
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
                    shoppingLists[newListName] = []; // Adiciona uma nova lista ao mapa.
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
  // Método para editar uma lista de compras.
void _editShoppingList(String listName) {
  if (!shoppingLists.containsKey(listName)) return; // Verifica se a lista existe.
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
                // Atualiza o mapa com a nova chave e remove a antiga.
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
  // Mostra um diálogo de confirmação antes de remover a lista
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
              Navigator.of(context).pop(); // Simplesmente fecha o diálogo
            },
          ),
          TextButton(
            child: const Text('Remover'),
            onPressed: () {
              // Remove a lista pelo nome se ela existir no mapa
              if (shoppingLists.containsKey(listName)) {
                setState(() {
                  shoppingLists.remove(listName); // Remove a lista usando a chave
                });
                Navigator.of(context).pop(); // Fecha o diálogo após a remoção
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
              // Verifica se a lista existe
              if (!shoppingLists.containsKey(listName)) {
                shoppingLists[listName] = []; // Cria a lista se não existir
              }
              
              // Adiciona o item à lista
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
  // Primeiro, encontra a lista de compras pelo nome.
  if (!shoppingLists.containsKey(listName)) {
    // A lista especificada não existe.
    return;
  }
  List<ShoppingItem>? items = shoppingLists[listName];
  // Encontra o item específico dentro da lista.
  int itemIndex = items!.indexWhere((item) => item.name == itemName);
  if (itemIndex == -1) {
    // O item especificado não foi encontrado na lista.
    return;
  }
  ShoppingItem itemToEdit = items[itemIndex];
  // Controladores para os campos de texto no diálogo de edição.
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
              // Atualiza o item com os novos valores.
              itemToEdit.name = itemNameController.text;
              itemToEdit.quantity = int.tryParse(itemQuantityController.text) ?? itemToEdit.quantity;
              
              // Não é estritamente necessário atualizar a lista no mapa, pois
              // a modificação é feita por referência. Mas é necessário chamar
              // setState para atualizar a UI.
              setState(() {});
              Navigator.pop(context); // Fecha o diálogo
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}
void _removeItemFromList(String listName, String itemName) {
  // Verifica se a lista existe
  if (!shoppingLists.containsKey(listName)) {
    // A lista especificada não existe
    return;
  }
  List<ShoppingItem>? items = shoppingLists[listName];
  // Encontra o índice do item específico dentro da lista, baseado no nome
  int itemIndex = items!.indexWhere((item) => item.name == itemName);
  if (itemIndex != -1) {
    // Remove o item da lista se encontrado
    setState(() {
      items.removeAt(itemIndex);
    });
  }
}
void _toggleItemBought(String listName, String itemName, bool isBought) {
  // Verifica se a lista existe
  if (!shoppingLists.containsKey(listName)) {
    // A lista especificada não existe
    return;
  }
  List<ShoppingItem> items = shoppingLists[listName]!;
  // Encontra o item específico dentro da lista
  int itemIndex = items.indexWhere((item) => item.name == itemName);
  if (itemIndex != -1) {
    // Se o item for encontrado, alterna o estado de 'comprado'
    setState(() {
      items[itemIndex].isBought = isBought;
    });
  }
}
  void _searchForItem(String query) {
    List<ShoppingItem> results = [];
    shoppingLists.forEach((listName, items) {
      // Filtra os itens que contêm a query no nome e adiciona à lista de resultados
      results.addAll(items.where((item) => item.name.toLowerCase().contains(query.toLowerCase())));
    });
    setState(() {
      searchResults = results; // Atualiza a lista de resultados de pesquisa.
    });
  }
  @override
  Widget build(BuildContext context) {
    // Aqui construímos a UI. A ListView.builder vai iterar sobre as chaves do mapa shoppingLists.
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
              // Aqui você navegaria para a tela que mostra os itens desta lista.
              // A implementação dessa navegação dependerá de como você estruturou suas telas.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListDetailsScreen(
                    listName: listName,
                    items: shoppingLists[listName]!,
                    onAddItem: (newItem) {
                      // Aqui você implementaria a lógica para adicionar um item à lista
                    },
                    onEditItem: (editedItem, index) {
                      // Aqui você implementaria a lógica para atualizar um item existente
                    }, 
                  ),
                ),
              );
            },
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
