import 'package:flutter/material.dart';
import 'package:helloworld/components/list_item.dart';
import 'package:helloworld/models/home.dart';
import 'package:helloworld/models/item.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, value, child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            const Text(
            'My Lists', 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 24),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(
              itemCount: value.getUserCart().length,
              itemBuilder: (context, index) {
              //get individual item
              Item individualItem = value.getUserCart()[index];

              //return cart item
              return ListItem(item: individualItem);
            },
            ),
           )
          ],
        ),
    ),
    );
  }
}