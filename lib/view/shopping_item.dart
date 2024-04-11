class ShoppingItem {
  String name;
  int quantity;
  bool isBought;

  ShoppingItem({
    required this.name,
    this.quantity = 1,
    this.isBought = false,
  });

  // Você pode adicionar métodos adicionais aqui, se necessário, como um método para converter o objeto para um mapa, o que é útil para salvar em um banco de dados ou compartilhar entre componentes.

  // Um exemplo simples de como converter um ShoppingItem para um Map:
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'isBought': isBought,
    };
  }

  // E um método para criar um ShoppingItem a partir de um Map:
  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      name: map['name'],
      quantity: map['quantity'] ?? 1,
      isBought: map['isBought'] ?? false,
    );
  }
}
