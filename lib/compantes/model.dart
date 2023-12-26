import 'package:flutter/material.dart';
import 'package:untitled/model/item.dart';

class Cart with ChangeNotifier {
  List<Item> itemss = [];
  double price = 0.0;
  void add(Item item) {
    itemss.add(item);
    price += item.price!;
    notifyListeners();
  }

  int get count {
    return itemss.length;
  }

  double get totalprice {
    return price;
  }

  List<Item> get basketitem {
    return itemss;
  }

  void remove(Item item) {
    itemss.remove(item);
    price -= item.price!;
    notifyListeners();
  }
}
