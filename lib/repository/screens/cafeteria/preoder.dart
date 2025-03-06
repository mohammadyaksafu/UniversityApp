class PreOrder {
  final List<Map<String, String>> _items = [];

  void addItem(Map<String, String> item) {
    _items.add(item);
  }

  void removeItem(String itemName) {
    _items.removeWhere((item) => item['name'] == itemName);
  }

  List<Map<String, String>> get items => _items;

  void clear() {
    _items.clear();
  }

  double getTotalPrice() {
    return _items.fold(0, (total, item) {
      return total + parsePrice(item['price']!);
    });
  }
}


double parsePrice(String price) {
  String cleanedPrice = price.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.parse(cleanedPrice);
}