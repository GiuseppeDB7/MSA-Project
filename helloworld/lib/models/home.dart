import 'package:flutter/material.dart';
import 'package:helloworld/models/item.dart';

class Cart extends ChangeNotifier{
  //list Items for sale
  List<Item> ItemShop = [
    Item(
      name: 'TEXT', 
      price: 'number', 
      description: 'Description',
      imagePath: 'lib/assets/white.png',
      ),

      Item(
      name: 'TEXT', 
      price: 'number', 
      description: 'Description',
      imagePath: 'lib/assets/white.png',
      ),

      Item(
      name: 'TEXT', 
      price: 'number', 
      description: 'Description',
      imagePath: 'lib/assets/white.png',
      ),

      Item(
      name: 'TEXT', 
      price: 'number', 
      description: 'Description',
      imagePath: 'lib/assets/white.png',
      ),
  ];

  //list items in cart
  List<Item> userCart = [];

  //get list of Items for sale
  List<Item> getItemList() {
    return ItemShop;
  }

  //get cart
  List<Item> getUserCart() {
    return userCart;
  }

  //add to cart
  void addItemToCart(Item Item){
    userCart.add(Item);
    notifyListeners();
  }

  //remove from cart
  void removeItemByCart(Item Item){
    userCart.remove(Item);
    notifyListeners();
  }
}