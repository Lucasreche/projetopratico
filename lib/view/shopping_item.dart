class ShoppingItem {
  String name;
  int quantity;
  bool isBought;
  ShoppingItem({
    required this.name,
    this.quantity = 1,
    this.isBought = false,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'isBought': isBought,
    };
  }
  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      name: map['name'],
      quantity: map['quantity'] ?? 1,
      isBought: map['isBought'] ?? false,
    );
  }
}
